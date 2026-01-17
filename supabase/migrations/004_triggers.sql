-- Create low stock alerts view
CREATE OR REPLACE VIEW low_stock_alerts AS
SELECT 
  si.site_id,
  s.name as site_name,
  si.product_id,
  p.name as product_name,
  si.quantity_on_hand,
  spml.min_level,
  (spml.min_level - si.quantity_on_hand) as shortage
FROM site_inventory si
JOIN sites s ON si.site_id = s.id
JOIN products p ON si.product_id = p.id
LEFT JOIN site_product_min_levels spml ON si.site_id = spml.site_id AND si.product_id = spml.product_id
WHERE si.quantity_on_hand < COALESCE(spml.min_level, 0)
  AND spml.min_level IS NOT NULL;

-- Grant access to the view
GRANT SELECT ON low_stock_alerts TO authenticated;

-- Function to automatically create user profile on signup
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.user_profiles (id, email, full_name, role)
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'full_name', NULL),
    COALESCE(NEW.raw_user_meta_data->>'role', 'viewer')::TEXT
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger to create user profile on signup
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION handle_new_user();
