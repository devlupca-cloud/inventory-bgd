-- Add soft delete columns to tables
ALTER TABLE sites ADD COLUMN IF NOT EXISTS deleted_at TIMESTAMPTZ DEFAULT NULL;
ALTER TABLE products ADD COLUMN IF NOT EXISTS deleted_at TIMESTAMPTZ DEFAULT NULL;
ALTER TABLE purchase_requests ADD COLUMN IF NOT EXISTS deleted_at TIMESTAMPTZ DEFAULT NULL;

-- Create index for faster queries on non-deleted records
CREATE INDEX IF NOT EXISTS idx_sites_deleted_at ON sites(deleted_at);
CREATE INDEX IF NOT EXISTS idx_products_deleted_at ON products(deleted_at);
CREATE INDEX IF NOT EXISTS idx_purchase_requests_deleted_at ON purchase_requests(deleted_at);

-- Update RLS policies to exclude soft-deleted records for regular queries
-- Sites: Only show non-deleted sites
DROP POLICY IF EXISTS "All authenticated users can view sites" ON sites;
CREATE POLICY "All authenticated users can view active sites"
  ON sites FOR SELECT
  TO authenticated
  USING (deleted_at IS NULL);

-- Products: Only show non-deleted products
DROP POLICY IF EXISTS "All authenticated users can view products" ON products;
CREATE POLICY "All authenticated users can view active products"
  ON products FOR SELECT
  TO authenticated
  USING (deleted_at IS NULL);

-- Purchase requests: Only show non-deleted requests
DROP POLICY IF EXISTS "Users can view purchase requests for accessible sites" ON purchase_requests;
CREATE POLICY "Users can view active purchase requests for accessible sites"
  ON purchase_requests FOR SELECT
  TO authenticated
  USING (deleted_at IS NULL AND has_site_access(site_id));
