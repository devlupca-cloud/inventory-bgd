-- Seed data for development/testing
-- Note: Run this after migrations and create users in Supabase Auth first

-- Insert sample sites
INSERT INTO sites (id, name, address) VALUES
  ('00000000-0000-0000-0000-000000000001', 'Downtown Office', '123 Main St, City, State 12345'),
  ('00000000-0000-0000-0000-000000000002', 'North Branch', '456 Oak Ave, City, State 12345'),
  ('00000000-0000-0000-0000-000000000003', 'South Warehouse', '789 Pine Rd, City, State 12345')
ON CONFLICT DO NOTHING;

-- Insert sample products
INSERT INTO products (id, name, unit) VALUES
  ('10000000-0000-0000-0000-000000000001', 'Paper Towels', 'roll'),
  ('10000000-0000-0000-0000-000000000002', 'Pine-Sol Cleaner', 'bottle'),
  ('10000000-0000-0000-0000-000000000003', 'Stainless Steel Cleaner', 'bottle'),
  ('10000000-0000-0000-0000-000000000004', 'Glass Cleaner', 'bottle'),
  ('10000000-0000-0000-0000-000000000005', 'Trash Bags', 'box'),
  ('10000000-0000-0000-0000-000000000006', 'Disinfectant Wipes', 'container'),
  ('10000000-0000-0000-0000-000000000007', 'Mop Heads', 'each'),
  ('10000000-0000-0000-0000-000000000008', 'Floor Cleaner', 'gallon')
ON CONFLICT DO NOTHING;

-- Set minimum levels for some products at some sites
INSERT INTO site_product_min_levels (site_id, product_id, min_level) VALUES
  ('00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000001', 10),
  ('00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000002', 5),
  ('00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000003', 3),
  ('00000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000001', 8),
  ('00000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000002', 4),
  ('00000000-0000-0000-0000-000000000003', '10000000-0000-0000-0000-000000000001', 15),
  ('00000000-0000-0000-0000-000000000003', '10000000-0000-0000-0000-000000000005', 5)
ON CONFLICT DO NOTHING;

-- Note: User profiles will be created automatically via trigger when users sign up
-- Site user roles should be created manually for supervisors after users are created
