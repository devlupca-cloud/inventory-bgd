-- Function to update site inventory after stock movements
CREATE OR REPLACE FUNCTION update_site_inventory()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    -- Handle INSERT
    IF NEW.movement_type = 'IN' OR NEW.movement_type = 'TRANSFER_IN' THEN
      INSERT INTO site_inventory (site_id, product_id, quantity_on_hand, last_updated)
      VALUES (NEW.site_id, NEW.product_id, NEW.quantity, NOW())
      ON CONFLICT (site_id, product_id)
      DO UPDATE SET
        quantity_on_hand = site_inventory.quantity_on_hand + NEW.quantity,
        last_updated = NOW();
    ELSIF NEW.movement_type = 'OUT' OR NEW.movement_type = 'TRANSFER_OUT' THEN
      INSERT INTO site_inventory (site_id, product_id, quantity_on_hand, last_updated)
      VALUES (NEW.site_id, NEW.product_id, -NEW.quantity, NOW())
      ON CONFLICT (site_id, product_id)
      DO UPDATE SET
        quantity_on_hand = site_inventory.quantity_on_hand - NEW.quantity,
        last_updated = NOW();
    END IF;
    RETURN NEW;
  ELSIF TG_OP = 'UPDATE' THEN
    -- Handle UPDATE (recalculate from scratch for affected products)
    -- This is a simplified version - in production you might want to recalculate all movements
    RETURN NEW;
  ELSIF TG_OP = 'DELETE' THEN
    -- Handle DELETE
    IF OLD.movement_type = 'IN' OR OLD.movement_type = 'TRANSFER_IN' THEN
      UPDATE site_inventory
      SET quantity_on_hand = quantity_on_hand - OLD.quantity,
          last_updated = NOW()
      WHERE site_id = OLD.site_id AND product_id = OLD.product_id;
    ELSIF OLD.movement_type = 'OUT' OR OLD.movement_type = 'TRANSFER_OUT' THEN
      UPDATE site_inventory
      SET quantity_on_hand = quantity_on_hand + OLD.quantity,
          last_updated = NOW()
      WHERE site_id = OLD.site_id AND product_id = OLD.product_id;
    END IF;
    RETURN OLD;
  END IF;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Trigger for stock movements
CREATE TRIGGER trigger_update_site_inventory
  AFTER INSERT OR UPDATE OR DELETE ON stock_movements
  FOR EACH ROW EXECUTE FUNCTION update_site_inventory();

-- RPC: Register stock IN
CREATE OR REPLACE FUNCTION rpc_register_in(
  p_site_id UUID,
  p_product_id UUID,
  p_quantity NUMERIC,
  p_notes TEXT DEFAULT NULL
)
RETURNS JSON AS $$
DECLARE
  v_user_id UUID;
  v_has_access BOOLEAN;
BEGIN
  v_user_id := auth.uid();
  
  IF v_user_id IS NULL THEN
    RETURN json_build_object('success', false, 'message', 'Not authenticated');
  END IF;

  -- Check permissions: manager or owner only
  SELECT is_manager_or_owner() INTO v_has_access;
  
  IF NOT v_has_access THEN
    RETURN json_build_object('success', false, 'message', 'Insufficient permissions. Only managers and owners can register stock IN.');
  END IF;

  -- Validate quantity
  IF p_quantity <= 0 THEN
    RETURN json_build_object('success', false, 'message', 'Quantity must be greater than 0');
  END IF;

  -- Insert stock movement
  INSERT INTO stock_movements (
    site_id,
    product_id,
    movement_type,
    quantity,
    notes,
    created_by
  ) VALUES (
    p_site_id,
    p_product_id,
    'IN',
    p_quantity,
    p_notes,
    v_user_id
  );

  RETURN json_build_object('success', true, 'message', 'Stock registered successfully');
EXCEPTION
  WHEN OTHERS THEN
    RETURN json_build_object('success', false, 'message', SQLERRM);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- RPC: Register stock OUT
CREATE OR REPLACE FUNCTION rpc_register_out(
  p_site_id UUID,
  p_product_id UUID,
  p_quantity NUMERIC,
  p_notes TEXT DEFAULT NULL
)
RETURNS JSON AS $$
DECLARE
  v_user_id UUID;
  v_has_access BOOLEAN;
  v_current_stock NUMERIC;
BEGIN
  v_user_id := auth.uid();
  
  IF v_user_id IS NULL THEN
    RETURN json_build_object('success', false, 'message', 'Not authenticated');
  END IF;

  -- Check permissions: supervisor (for assigned site), manager, or owner
  SELECT 
    is_manager_or_owner() OR has_site_access(p_site_id)
  INTO v_has_access;
  
  IF NOT v_has_access THEN
    RETURN json_build_object('success', false, 'message', 'Insufficient permissions. You do not have access to this site.');
  END IF;

  -- Check if supervisor has access (if not manager/owner)
  IF NOT is_manager_or_owner() THEN
    SELECT EXISTS (
      SELECT 1 FROM site_user_roles
      WHERE user_id = v_user_id AND site_id = p_site_id
    ) INTO v_has_access;
    
    IF NOT v_has_access THEN
      RETURN json_build_object('success', false, 'message', 'Insufficient permissions. You are not assigned to this site.');
    END IF;
  END IF;

  -- Validate quantity
  IF p_quantity <= 0 THEN
    RETURN json_build_object('success', false, 'message', 'Quantity must be greater than 0');
  END IF;

  -- Check current stock (optional - you might want to allow negative for losses)
  SELECT COALESCE(quantity_on_hand, 0) INTO v_current_stock
  FROM site_inventory
  WHERE site_id = p_site_id AND product_id = p_product_id;

  -- Insert stock movement
  INSERT INTO stock_movements (
    site_id,
    product_id,
    movement_type,
    quantity,
    notes,
    created_by
  ) VALUES (
    p_site_id,
    p_product_id,
    'OUT',
    p_quantity,
    p_notes,
    v_user_id
  );

  RETURN json_build_object('success', true, 'message', 'Stock consumption registered successfully');
EXCEPTION
  WHEN OTHERS THEN
    RETURN json_build_object('success', false, 'message', SQLERRM);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- RPC: Transfer between sites
CREATE OR REPLACE FUNCTION rpc_transfer_between_sites(
  p_from_site_id UUID,
  p_to_site_id UUID,
  p_product_id UUID,
  p_quantity NUMERIC,
  p_notes TEXT DEFAULT NULL
)
RETURNS JSON AS $$
DECLARE
  v_user_id UUID;
  v_has_access_from BOOLEAN;
  v_has_access_to BOOLEAN;
  v_current_stock NUMERIC;
  v_out_movement_id UUID;
  v_in_movement_id UUID;
BEGIN
  v_user_id := auth.uid();
  
  IF v_user_id IS NULL THEN
    RETURN json_build_object('success', false, 'message', 'Not authenticated');
  END IF;

  -- Check permissions: manager/owner can transfer between any sites
  -- Supervisor can transfer if assigned to both sites
  IF is_manager_or_owner() THEN
    v_has_access_from := true;
    v_has_access_to := true;
  ELSE
    -- Check supervisor access to both sites
    SELECT 
      EXISTS (SELECT 1 FROM site_user_roles WHERE user_id = v_user_id AND site_id = p_from_site_id),
      EXISTS (SELECT 1 FROM site_user_roles WHERE user_id = v_user_id AND site_id = p_to_site_id)
    INTO v_has_access_from, v_has_access_to;
    
    IF NOT (v_has_access_from AND v_has_access_to) THEN
      RETURN json_build_object('success', false, 'message', 'Insufficient permissions. You must have access to both sites.');
    END IF;
  END IF;

  -- Validate sites are different
  IF p_from_site_id = p_to_site_id THEN
    RETURN json_build_object('success', false, 'message', 'Source and destination sites must be different');
  END IF;

  -- Validate quantity
  IF p_quantity <= 0 THEN
    RETURN json_build_object('success', false, 'message', 'Quantity must be greater than 0');
  END IF;

  -- Check current stock at source site
  SELECT COALESCE(quantity_on_hand, 0) INTO v_current_stock
  FROM site_inventory
  WHERE site_id = p_from_site_id AND product_id = p_product_id;

  -- Create transfer movements atomically
  INSERT INTO stock_movements (
    site_id,
    product_id,
    movement_type,
    quantity,
    transfer_to_site_id,
    notes,
    created_by
  ) VALUES (
    p_from_site_id,
    p_product_id,
    'TRANSFER_OUT',
    p_quantity,
    p_to_site_id,
    p_notes,
    v_user_id
  ) RETURNING id INTO v_out_movement_id;

  INSERT INTO stock_movements (
    site_id,
    product_id,
    movement_type,
    quantity,
    transfer_to_site_id,
    transfer_movement_id,
    notes,
    created_by
  ) VALUES (
    p_to_site_id,
    p_product_id,
    'TRANSFER_IN',
    p_quantity,
    NULL,
    v_out_movement_id,
    p_notes,
    v_user_id
  ) RETURNING id INTO v_in_movement_id;

  -- Update the OUT movement to reference the IN movement
  UPDATE stock_movements
  SET transfer_movement_id = v_in_movement_id
  WHERE id = v_out_movement_id;

  RETURN json_build_object('success', true, 'message', 'Transfer completed successfully');
EXCEPTION
  WHEN OTHERS THEN
    RETURN json_build_object('success', false, 'message', SQLERRM);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- RPC: Approve purchase request
CREATE OR REPLACE FUNCTION rpc_approve_purchase_request(
  p_request_id UUID
)
RETURNS JSON AS $$
DECLARE
  v_user_id UUID;
  v_request_record RECORD;
BEGIN
  v_user_id := auth.uid();
  
  IF v_user_id IS NULL THEN
    RETURN json_build_object('success', false, 'message', 'Not authenticated');
  END IF;

  -- Check permissions: manager or owner only
  IF NOT is_manager_or_owner() THEN
    RETURN json_build_object('success', false, 'message', 'Insufficient permissions. Only managers and owners can approve purchase requests.');
  END IF;

  -- Get purchase request
  SELECT * INTO v_request_record
  FROM purchase_requests
  WHERE id = p_request_id;

  IF NOT FOUND THEN
    RETURN json_build_object('success', false, 'message', 'Purchase request not found');
  END IF;

  IF v_request_record.status != 'submitted' THEN
    RETURN json_build_object('success', false, 'message', 'Only submitted purchase requests can be approved');
  END IF;

  -- Update purchase request
  UPDATE purchase_requests
  SET 
    status = 'approved',
    approved_by = v_user_id,
    approved_at = NOW(),
    updated_at = NOW()
  WHERE id = p_request_id;

  RETURN json_build_object('success', true, 'message', 'Purchase request approved successfully');
EXCEPTION
  WHEN OTHERS THEN
    RETURN json_build_object('success', false, 'message', SQLERRM);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- RPC: Receive purchase request (with partial fulfillment support)
CREATE OR REPLACE FUNCTION rpc_receive_purchase_request(
  p_request_id UUID,
  p_items_received JSONB
)
RETURNS JSON AS $$
DECLARE
  v_user_id UUID;
  v_request_record RECORD;
  v_item RECORD;
  v_item_id UUID;
  v_quantity_received NUMERIC;
  v_unit_price NUMERIC;
  v_all_fulfilled BOOLEAN := true;
  v_some_fulfilled BOOLEAN := false;
BEGIN
  v_user_id := auth.uid();
  
  IF v_user_id IS NULL THEN
    RETURN json_build_object('success', false, 'message', 'Not authenticated');
  END IF;

  -- Check permissions: manager or owner only
  IF NOT is_manager_or_owner() THEN
    RETURN json_build_object('success', false, 'message', 'Insufficient permissions. Only managers and owners can receive purchase requests.');
  END IF;

  -- Get purchase request
  SELECT * INTO v_request_record
  FROM purchase_requests
  WHERE id = p_request_id;

  IF NOT FOUND THEN
    RETURN json_build_object('success', false, 'message', 'Purchase request not found');
  END IF;

  IF v_request_record.status != 'approved' THEN
    RETURN json_build_object('success', false, 'message', 'Only approved purchase requests can be received');
  END IF;

  -- Process each item received
  FOR v_item IN SELECT * FROM jsonb_array_elements(p_items_received)
  LOOP
    v_item_id := (v_item.value->>'item_id')::UUID;
    v_quantity_received := (v_item.value->>'quantity_received')::NUMERIC;
    v_unit_price := NULLIF((v_item.value->>'unit_price')::NUMERIC, 0);

    -- Validate item belongs to this request
    IF NOT EXISTS (
      SELECT 1 FROM purchase_request_items
      WHERE id = v_item_id AND purchase_request_id = p_request_id
    ) THEN
      CONTINUE; -- Skip invalid items
    END IF;

    -- Update item
    UPDATE purchase_request_items
    SET 
      quantity_received = LEAST(v_quantity_received, quantity_requested),
      unit_price = COALESCE(v_unit_price, unit_price)
    WHERE id = v_item_id;

    -- Register stock IN for this item
    PERFORM rpc_register_in(
      v_request_record.site_id,
      (SELECT product_id FROM purchase_request_items WHERE id = v_item_id),
      LEAST(v_quantity_received, (SELECT quantity_requested FROM purchase_request_items WHERE id = v_item_id)),
      'Received from purchase request ' || p_request_id::TEXT
    );
  END LOOP;

  -- Check fulfillment status
  SELECT 
    bool_and(quantity_received >= quantity_requested),
    bool_or(quantity_received > 0)
  INTO v_all_fulfilled, v_some_fulfilled
  FROM purchase_request_items
  WHERE purchase_request_id = p_request_id;

  -- Update request status
  IF v_all_fulfilled THEN
    UPDATE purchase_requests
    SET status = 'fulfilled', updated_at = NOW()
    WHERE id = p_request_id;
  ELSIF v_some_fulfilled THEN
    UPDATE purchase_requests
    SET status = 'partially_fulfilled', updated_at = NOW()
    WHERE id = p_request_id;
  END IF;

  RETURN json_build_object('success', true, 'message', 'Purchase request items received successfully');
EXCEPTION
  WHEN OTHERS THEN
    RETURN json_build_object('success', false, 'message', SQLERRM);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
