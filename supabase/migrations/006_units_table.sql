-- Create units table
CREATE TABLE units (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  value TEXT NOT NULL UNIQUE,
  label TEXT NOT NULL,
  sort_order INTEGER DEFAULT 0,
  deleted_at TIMESTAMPTZ DEFAULT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE units ENABLE ROW LEVEL SECURITY;

-- All authenticated users can view active units
CREATE POLICY "All authenticated users can view active units"
  ON units FOR SELECT
  TO authenticated
  USING (deleted_at IS NULL);

-- Only managers and owners can manage units
CREATE POLICY "Managers and owners can manage units"
  ON units FOR ALL
  TO authenticated
  USING (is_manager_or_owner())
  WITH CHECK (is_manager_or_owner());

-- Insert default units
INSERT INTO units (value, label, sort_order) VALUES
  ('unit', 'Unit (each)', 1),
  ('roll', 'Roll', 2),
  ('bottle', 'Bottle', 3),
  ('gallon', 'Gallon', 4),
  ('box', 'Box', 5),
  ('pack', 'Pack', 6),
  ('container', 'Container', 7),
  ('bag', 'Bag', 8),
  ('case', 'Case', 9),
  ('pair', 'Pair', 10),
  ('set', 'Set', 11),
  ('liter', 'Liter', 12),
  ('kg', 'Kilogram', 13),
  ('lb', 'Pound', 14)
ON CONFLICT (value) DO NOTHING;

-- Create index
CREATE INDEX idx_units_sort_order ON units(sort_order);
CREATE INDEX idx_units_deleted_at ON units(deleted_at);
