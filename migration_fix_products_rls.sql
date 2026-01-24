-- Fix RLS policies for products table
-- Allows managers and owners to insert, update, and read products
-- All authenticated users can read products

-- Enable RLS if not already enabled
ALTER TABLE products ENABLE ROW LEVEL SECURITY;

-- Drop existing policies if they exist (to avoid conflicts)
DROP POLICY IF EXISTS "Managers and owners can insert products" ON products;
DROP POLICY IF EXISTS "Managers and owners can update products" ON products;
DROP POLICY IF EXISTS "Managers and owners can delete products" ON products;
DROP POLICY IF EXISTS "All authenticated users can read products" ON products;
DROP POLICY IF EXISTS "Service role can manage products" ON products;

-- Policy: All authenticated users can read products (not deleted)
CREATE POLICY "All authenticated users can read products"
ON products
FOR SELECT
TO authenticated
USING (deleted_at IS NULL);

-- Policy: Managers and owners can insert products
CREATE POLICY "Managers and owners can insert products"
ON products
FOR INSERT
TO authenticated
WITH CHECK (
  EXISTS (
    SELECT 1 FROM user_profiles
    WHERE user_profiles.id = auth.uid()
    AND user_profiles.role IN ('manager', 'owner')
  )
);

-- Policy: Managers and owners can update products (including soft delete via deleted_at)
-- USING: checks if user can update the existing row (must be manager/owner, and row exists)
-- WITH CHECK: checks if the updated row is allowed (must be manager/owner, allows setting deleted_at)
-- Note: We allow deleted_at to be set even though SELECT policy filters it out
CREATE POLICY "Managers and owners can update products"
ON products
FOR UPDATE
TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM user_profiles
    WHERE user_profiles.id = auth.uid()
    AND user_profiles.role IN ('manager', 'owner')
  )
)
WITH CHECK (
  EXISTS (
    SELECT 1 FROM user_profiles
    WHERE user_profiles.id = auth.uid()
    AND user_profiles.role IN ('manager', 'owner')
  )
  -- Allow any update, including setting deleted_at (soft delete)
  -- The SELECT policy will filter out deleted products, but UPDATE should still work
);

-- Note: For service role (used in migrations/imports), you may need to temporarily
-- disable RLS or use SECURITY DEFINER functions. For the import script, consider
-- running it as the service role or using a function with SECURITY DEFINER.
