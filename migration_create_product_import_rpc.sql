-- Create RPC function for importing products (bypasses RLS)
-- This function can be used by the import script to insert products
-- It uses SECURITY DEFINER to run with elevated privileges

CREATE OR REPLACE FUNCTION rpc_import_product(
  p_name TEXT,
  p_unit TEXT,
  p_base_unit TEXT,
  p_units_per_package DECIMAL,
  p_price DECIMAL
)
RETURNS UUID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path TO public
AS $$
DECLARE
  v_product_id UUID;
BEGIN
  -- Check if product already exists
  SELECT id INTO v_product_id
  FROM products
  WHERE name = p_name
  AND deleted_at IS NULL
  LIMIT 1;

  IF v_product_id IS NOT NULL THEN
    -- Update existing product
    UPDATE products
    SET 
      unit = p_unit,
      base_unit = p_base_unit,
      units_per_package = p_units_per_package,
      price = p_price,
      updated_at = NOW()
    WHERE id = v_product_id;
    
    RETURN v_product_id;
  ELSE
    -- Insert new product
    INSERT INTO products (
      name,
      unit,
      base_unit,
      units_per_package,
      price,
      created_at,
      updated_at
    )
    VALUES (
      p_name,
      p_unit,
      p_base_unit,
      p_units_per_package,
      p_price,
      NOW(),
      NOW()
    )
    RETURNING id INTO v_product_id;
    
    RETURN v_product_id;
  END IF;
END;
$$;

-- Grant execute permission to authenticated users
GRANT EXECUTE ON FUNCTION rpc_import_product TO authenticated;
