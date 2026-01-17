-- Enable Row Level Security on all tables
ALTER TABLE sites ENABLE ROW LEVEL SECURITY;
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE site_user_roles ENABLE ROW LEVEL SECURITY;
ALTER TABLE site_inventory ENABLE ROW LEVEL SECURITY;
ALTER TABLE site_product_min_levels ENABLE ROW LEVEL SECURITY;
ALTER TABLE stock_movements ENABLE ROW LEVEL SECURITY;
ALTER TABLE purchase_requests ENABLE ROW LEVEL SECURITY;
ALTER TABLE purchase_request_items ENABLE ROW LEVEL SECURITY;

-- Helper function to check if user is manager or owner
CREATE OR REPLACE FUNCTION is_manager_or_owner()
RETURNS BOOLEAN AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM user_profiles
    WHERE id = auth.uid() AND role IN ('manager', 'owner')
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Helper function to check if user is viewer
CREATE OR REPLACE FUNCTION is_viewer()
RETURNS BOOLEAN AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM user_profiles
    WHERE id = auth.uid() AND role = 'viewer'
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Helper function to check if user has access to a site
CREATE OR REPLACE FUNCTION has_site_access(p_site_id UUID)
RETURNS BOOLEAN AS $$
BEGIN
  RETURN (
    is_manager_or_owner()
    OR EXISTS (
      SELECT 1 FROM site_user_roles
      WHERE user_id = auth.uid() AND site_id = p_site_id
    )
    OR is_viewer()
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Sites policies
CREATE POLICY "All authenticated users can view sites"
  ON sites FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Only managers and owners can insert sites"
  ON sites FOR INSERT
  TO authenticated
  WITH CHECK (is_manager_or_owner());

CREATE POLICY "Only managers and owners can update sites"
  ON sites FOR UPDATE
  TO authenticated
  USING (is_manager_or_owner())
  WITH CHECK (is_manager_or_owner());

CREATE POLICY "Only managers and owners can delete sites"
  ON sites FOR DELETE
  TO authenticated
  USING (is_manager_or_owner());

-- Products policies
CREATE POLICY "All authenticated users can view products"
  ON products FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Only managers and owners can insert products"
  ON products FOR INSERT
  TO authenticated
  WITH CHECK (is_manager_or_owner());

CREATE POLICY "Only managers and owners can update products"
  ON products FOR UPDATE
  TO authenticated
  USING (is_manager_or_owner())
  WITH CHECK (is_manager_or_owner());

CREATE POLICY "Only managers and owners can delete products"
  ON products FOR DELETE
  TO authenticated
  USING (is_manager_or_owner());

-- User profiles policies
CREATE POLICY "All authenticated users can view user profiles"
  ON user_profiles FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Users can insert their own profile"
  ON user_profiles FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = id);

CREATE POLICY "Users can update their own profile or managers/owners can update any"
  ON user_profiles FOR UPDATE
  TO authenticated
  USING (auth.uid() = id OR is_manager_or_owner())
  WITH CHECK (auth.uid() = id OR is_manager_or_owner());

-- Site user roles policies
CREATE POLICY "Managers and owners can view site user roles"
  ON site_user_roles FOR SELECT
  TO authenticated
  USING (is_manager_or_owner());

CREATE POLICY "Managers and owners can insert site user roles"
  ON site_user_roles FOR INSERT
  TO authenticated
  WITH CHECK (is_manager_or_owner());

CREATE POLICY "Managers and owners can update site user roles"
  ON site_user_roles FOR UPDATE
  TO authenticated
  USING (is_manager_or_owner())
  WITH CHECK (is_manager_or_owner());

CREATE POLICY "Managers and owners can delete site user roles"
  ON site_user_roles FOR DELETE
  TO authenticated
  USING (is_manager_or_owner());

-- Site inventory policies
CREATE POLICY "Users can view inventory for accessible sites"
  ON site_inventory FOR SELECT
  TO authenticated
  USING (has_site_access(site_id));

-- Site product min levels policies
CREATE POLICY "Users can view min levels for accessible sites"
  ON site_product_min_levels FOR SELECT
  TO authenticated
  USING (has_site_access(site_id));

CREATE POLICY "Managers and owners can manage min levels"
  ON site_product_min_levels FOR ALL
  TO authenticated
  USING (is_manager_or_owner())
  WITH CHECK (is_manager_or_owner());

-- Stock movements policies
CREATE POLICY "Users can view movements for accessible sites"
  ON stock_movements FOR SELECT
  TO authenticated
  USING (has_site_access(site_id));

-- Note: INSERT is handled via RPC functions only, so no direct INSERT policy needed

-- Purchase requests policies
CREATE POLICY "Users can view purchase requests for accessible sites"
  ON purchase_requests FOR SELECT
  TO authenticated
  USING (has_site_access(site_id));

CREATE POLICY "Supervisors can create purchase requests for assigned sites, managers/owners for any"
  ON purchase_requests FOR INSERT
  TO authenticated
  WITH CHECK (
    is_manager_or_owner()
    OR (
      EXISTS (
        SELECT 1 FROM user_profiles
        WHERE id = auth.uid() AND role = 'supervisor'
      )
      AND EXISTS (
        SELECT 1 FROM site_user_roles
        WHERE user_id = auth.uid() AND site_id = purchase_requests.site_id
      )
    )
  );

CREATE POLICY "Supervisors can update their own draft/submitted requests, managers can update any"
  ON purchase_requests FOR UPDATE
  TO authenticated
  USING (
    is_manager_or_owner()
    OR (
      requested_by = auth.uid()
      AND status IN ('draft', 'submitted')
      AND EXISTS (
        SELECT 1 FROM site_user_roles
        WHERE user_id = auth.uid() AND site_id = purchase_requests.site_id
      )
    )
  )
  WITH CHECK (
    is_manager_or_owner()
    OR (
      requested_by = auth.uid()
      AND status IN ('draft', 'submitted')
      AND EXISTS (
        SELECT 1 FROM site_user_roles
        WHERE user_id = auth.uid() AND site_id = purchase_requests.site_id
      )
    )
  );

-- Purchase request items policies
CREATE POLICY "Users can view items for accessible purchase requests"
  ON purchase_request_items FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM purchase_requests pr
      WHERE pr.id = purchase_request_items.purchase_request_id
      AND has_site_access(pr.site_id)
    )
  );

CREATE POLICY "Users can insert items for purchase requests they can modify"
  ON purchase_request_items FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM purchase_requests pr
      WHERE pr.id = purchase_request_items.purchase_request_id
      AND (
        is_manager_or_owner()
        OR (
          pr.requested_by = auth.uid()
          AND pr.status IN ('draft', 'submitted')
          AND EXISTS (
            SELECT 1 FROM site_user_roles
            WHERE user_id = auth.uid() AND site_id = pr.site_id
          )
        )
      )
    )
  );

CREATE POLICY "Users can update items for purchase requests they can modify"
  ON purchase_request_items FOR UPDATE
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM purchase_requests pr
      WHERE pr.id = purchase_request_items.purchase_request_id
      AND (
        is_manager_or_owner()
        OR (
          pr.requested_by = auth.uid()
          AND pr.status IN ('draft', 'submitted')
          AND EXISTS (
            SELECT 1 FROM site_user_roles
            WHERE user_id = auth.uid() AND site_id = pr.site_id
          )
        )
      )
    )
  )
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM purchase_requests pr
      WHERE pr.id = purchase_request_items.purchase_request_id
      AND (
        is_manager_or_owner()
        OR (
          pr.requested_by = auth.uid()
          AND pr.status IN ('draft', 'submitted')
          AND EXISTS (
            SELECT 1 FROM site_user_roles
            WHERE user_id = auth.uid() AND site_id = pr.site_id
          )
        )
      )
    )
  );
