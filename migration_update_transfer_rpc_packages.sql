-- Migration: Update rpc_transfer_between_sites to handle packages and loose units
-- This implements automatic box opening when sending loose units

DROP FUNCTION IF EXISTS rpc_transfer_between_sites(UUID, UUID, UUID, DECIMAL, UUID, TEXT);

CREATE OR REPLACE FUNCTION rpc_transfer_between_sites(
  p_from_site_id UUID,
  p_to_site_id UUID,
  p_product_id UUID,
  p_quantity DECIMAL,
  p_user_id UUID,
  p_notes TEXT DEFAULT NULL
)
RETURNS JSON
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_from_inventory RECORD;
  v_units_per_package DECIMAL;
  v_available_total DECIMAL;
  v_boxes_to_open INTEGER;
  v_new_packages INTEGER;
  v_new_loose_units DECIMAL;
BEGIN
  -- Validate user_id
  IF p_user_id IS NULL THEN
    RETURN json_build_object('success', false, 'message', 'User ID is required');
  END IF;

  -- Validate quantity
  IF p_quantity <= 0 THEN
    RETURN json_build_object('success', false, 'message', 'Quantity must be greater than 0');
  END IF;

  -- Get current inventory and product info
  SELECT 
    si.quantity_packages,
    si.quantity_loose_units,
    si.quantity_on_hand,
    p.units_per_package
  INTO v_from_inventory
  FROM site_inventory si
  JOIN products p ON si.product_id = p.id
  WHERE si.site_id = p_from_site_id
    AND si.product_id = p_product_id;

  IF v_from_inventory IS NULL THEN
    RETURN json_build_object('success', false, 'message', 'Product not found in source inventory');
  END IF;

  v_units_per_package := COALESCE(v_from_inventory.units_per_package, 1);
  v_available_total := v_from_inventory.quantity_on_hand;

  -- Validate sufficient inventory
  IF v_available_total < p_quantity THEN
    RETURN json_build_object(
      'success', false, 
      'message', format('Insufficient inventory. Available: %s units', v_available_total)
    );
  END IF;

  -- Calculate how to deduct: try to use loose_units first, then open boxes
  v_new_loose_units := v_from_inventory.quantity_loose_units;
  v_new_packages := v_from_inventory.quantity_packages;
  
  -- Deduct from loose_units first
  IF v_new_loose_units >= p_quantity THEN
    -- Enough loose units, just deduct
    v_new_loose_units := v_new_loose_units - p_quantity;
  ELSE
    -- Need to open boxes
    DECLARE
      v_remaining_to_deduct DECIMAL;
      v_boxes_needed INTEGER;
    BEGIN
      v_remaining_to_deduct := p_quantity - v_new_loose_units;
      v_boxes_needed := CEIL(v_remaining_to_deduct / v_units_per_package)::INTEGER;
      
      -- Check if we have enough boxes
      IF v_new_packages < v_boxes_needed THEN
        RETURN json_build_object(
          'success', false,
          'message', format('Not enough packages to open. Need %s, have %s', v_boxes_needed, v_new_packages)
        );
      END IF;
      
      -- Open boxes and deduct
      v_new_packages := v_new_packages - v_boxes_needed;
      v_new_loose_units := v_new_loose_units + (v_boxes_needed * v_units_per_package) - p_quantity;
    END;
  END IF;

  -- Update source site inventory
  UPDATE site_inventory
  SET 
    quantity_packages = v_new_packages,
    quantity_loose_units = v_new_loose_units,
    last_updated = NOW()
  WHERE site_id = p_from_site_id
    AND product_id = p_product_id;

  -- Record TRANSFER_OUT movement
  INSERT INTO stock_movements (
    site_id, product_id, movement_type, quantity, notes, created_by, created_at
  ) VALUES (
    p_from_site_id, p_product_id, 'TRANSFER_OUT', p_quantity, p_notes, p_user_id, NOW()
  );

  -- Add to destination site (as packages if possible, otherwise as loose units)
  -- When receiving, we add as packages if quantity is multiple of units_per_package
  DECLARE
    v_received_packages INTEGER;
    v_received_loose DECIMAL;
  BEGIN
    IF v_units_per_package > 1 AND p_quantity >= v_units_per_package THEN
      v_received_packages := FLOOR(p_quantity / v_units_per_package)::INTEGER;
      v_received_loose := p_quantity - (v_received_packages * v_units_per_package);
    ELSE
      v_received_packages := 0;
      v_received_loose := p_quantity;
    END IF;

    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (p_to_site_id, p_product_id, v_received_packages, v_received_loose, NOW())
    ON CONFLICT (site_id, product_id)
    DO UPDATE SET 
      quantity_packages = site_inventory.quantity_packages + v_received_packages,
      quantity_loose_units = site_inventory.quantity_loose_units + v_received_loose,
      last_updated = NOW();
  END;

  -- Record TRANSFER_IN movement
  INSERT INTO stock_movements (
    site_id, product_id, movement_type, quantity, notes, created_by, created_at
  ) VALUES (
    p_to_site_id, p_product_id, 'TRANSFER_IN', p_quantity, p_notes, p_user_id, NOW()
  );

  RETURN json_build_object('success', true, 'message', 'Transfer completed successfully');
  
EXCEPTION
  WHEN OTHERS THEN
    RETURN json_build_object('success', false, 'message', SQLERRM);
END;
$$;

GRANT EXECUTE ON FUNCTION rpc_transfer_between_sites TO authenticated;

COMMENT ON FUNCTION rpc_transfer_between_sites IS 
'Transfer inventory between sites with automatic box opening. Uses loose_units first, then opens boxes as needed.';
