-- Migration: Update rpc_register_in to add items as packages when purchased
-- When you buy products, they arrive as complete packages/boxes

DROP FUNCTION IF EXISTS rpc_register_in(UUID, UUID, DECIMAL, UUID, TEXT);

CREATE OR REPLACE FUNCTION rpc_register_in(
  p_site_id UUID,
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
  v_units_per_package DECIMAL;
  v_packages_to_add INTEGER;
  v_loose_units_to_add DECIMAL;
BEGIN
  IF p_user_id IS NULL THEN
    RETURN json_build_object('success', false, 'message', 'User ID is required');
  END IF;

  IF p_quantity <= 0 THEN
    RETURN json_build_object('success', false, 'message', 'Quantity must be greater than 0');
  END IF;

  -- Get units_per_package for this product
  SELECT COALESCE(units_per_package, 1) INTO v_units_per_package
  FROM products
  WHERE id = p_product_id;

  -- When purchasing, assume quantity is in purchase units (packages)
  -- So if you buy 3 boxes, p_quantity = 3
  -- But we need to check: is p_quantity in packages or units?
  -- For now, assume it's in packages if > 1 and units_per_package > 1
  -- Otherwise, it's in base units
  
  -- Actually, let's make it simpler: p_quantity is always in purchase units (packages)
  -- So if you buy 3 boxes, p_quantity = 3
  v_packages_to_add := FLOOR(p_quantity)::INTEGER;
  v_loose_units_to_add := 0; -- Purchases are always complete packages

  -- Add to inventory
  INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
  VALUES (p_site_id, p_product_id, v_packages_to_add, v_loose_units_to_add, NOW())
  ON CONFLICT (site_id, product_id)
  DO UPDATE SET 
    quantity_packages = site_inventory.quantity_packages + v_packages_to_add,
    quantity_loose_units = site_inventory.quantity_loose_units + v_loose_units_to_add,
    last_updated = NOW();

  -- Record movement with total units
  INSERT INTO stock_movements (
    site_id, product_id, movement_type, quantity, notes, created_by, created_at
  ) VALUES (
    p_site_id, p_product_id, 'IN', v_packages_to_add * v_units_per_package, p_notes, p_user_id, NOW()
  );

  RETURN json_build_object('success', true, 'message', 'Stock registered');
  
EXCEPTION
  WHEN OTHERS THEN
    RETURN json_build_object('success', false, 'message', SQLERRM);
END;
$$;

GRANT EXECUTE ON FUNCTION rpc_register_in TO authenticated;

COMMENT ON FUNCTION rpc_register_in IS 
'Register stock IN. Assumes quantity is in purchase units (packages/boxes). Adds as complete packages.';
