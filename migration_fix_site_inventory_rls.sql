-- Migration: Fix RLS policies for site_inventory
-- This ensures managers and owners can insert/update inventory records

-- Drop existing policies if they exist
DROP POLICY IF EXISTS "Users can view inventory for their sites" ON site_inventory;
DROP POLICY IF EXISTS "Managers can insert inventory" ON site_inventory;
DROP POLICY IF EXISTS "Managers can update inventory" ON site_inventory;
DROP POLICY IF EXISTS "Owners can manage all inventory" ON site_inventory;

-- Enable RLS on site_inventory
ALTER TABLE site_inventory ENABLE ROW LEVEL SECURITY;

-- Policy 1: Users can view inventory for sites they have access to
CREATE POLICY "Users can view inventory for their sites"
ON site_inventory
FOR SELECT
USING (
  EXISTS (
    SELECT 1 FROM site_user_roles
    WHERE site_user_roles.user_id = auth.uid()
    AND site_user_roles.site_id = site_inventory.site_id
  )
  OR
  EXISTS (
    SELECT 1 FROM user_profiles
    WHERE user_profiles.id = auth.uid()
    AND user_profiles.role IN ('manager', 'owner')
  )
);

-- Policy 2: Managers and owners can insert inventory for any site
CREATE POLICY "Managers and owners can insert inventory"
ON site_inventory
FOR INSERT
WITH CHECK (
  EXISTS (
    SELECT 1 FROM user_profiles
    WHERE user_profiles.id = auth.uid()
    AND user_profiles.role IN ('manager', 'owner')
  )
);

-- Policy 3: Managers and owners can update inventory for any site
CREATE POLICY "Managers and owners can update inventory"
ON site_inventory
FOR UPDATE
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
);

-- Policy 4: Only owners can delete inventory
CREATE POLICY "Owners can delete inventory"
ON site_inventory
FOR DELETE
USING (
  EXISTS (
    SELECT 1 FROM user_profiles
    WHERE user_profiles.id = auth.uid()
    AND user_profiles.role = 'owner'
  )
);

-- Verify the policies
SELECT schemaname, tablename, policyname, permissive, roles, cmd, qual, with_check
FROM pg_policies
WHERE tablename = 'site_inventory'
ORDER BY policyname;
