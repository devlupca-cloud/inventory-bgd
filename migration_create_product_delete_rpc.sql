-- Create RPC function for soft deleting products (bypasses RLS issues)
-- This function uses SECURITY DEFINER to run with elevated privileges
-- Similar to rpc_delete_site for sites

CREATE OR REPLACE FUNCTION rpc_delete_product(
  p_product_id UUID
)
RETURNS JSON
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path TO public
AS $$
DECLARE
  v_current_user_id UUID;
  v_user_role TEXT;
  v_product_name TEXT;
BEGIN
  -- Get current authenticated user
  v_current_user_id := auth.uid();
  
  -- Validate user authentication
  IF v_current_user_id IS NULL THEN
    RETURN json_build_object(
      'success', false,
      'message', 'User not authenticated'
    );
  END IF;

  -- Check if user is manager or owner
  SELECT role INTO v_user_role
  FROM user_profiles
  WHERE id = v_current_user_id;

  IF v_user_role NOT IN ('manager', 'owner') THEN
    RETURN json_build_object(
      'success', false,
      'message', 'Only managers and owners can delete products'
    );
  END IF;

  -- Get product name for validation
  SELECT name INTO v_product_name
  FROM products
  WHERE id = p_product_id
  AND deleted_at IS NULL;

  IF v_product_name IS NULL THEN
    RETURN json_build_object(
      'success', false,
      'message', 'Product not found or already deleted'
    );
  END IF;

  -- Soft delete: set deleted_at timestamp
  UPDATE products
  SET 
    deleted_at = NOW(),
    updated_at = NOW()
  WHERE id = p_product_id;

  RETURN json_build_object(
    'success', true,
    'message', format('Product "%s" deleted successfully', v_product_name),
    'product_id', p_product_id
  );

EXCEPTION
  WHEN OTHERS THEN
    RETURN json_build_object(
      'success', false,
      'message', format('Error: %s', SQLERRM)
    );
END;
$$;

-- Grant execute permission to authenticated users
GRANT EXECUTE ON FUNCTION rpc_delete_product TO authenticated;
