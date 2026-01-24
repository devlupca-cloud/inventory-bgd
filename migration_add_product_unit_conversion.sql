-- Migration: Add unit conversion fields to products table
-- This enables products to have different purchase and distribution units
-- Example: Buy by "box" but distribute by "unit"

-- Add new columns to products table
ALTER TABLE products 
ADD COLUMN IF NOT EXISTS base_unit VARCHAR(50),
ADD COLUMN IF NOT EXISTS units_per_package DECIMAL(10, 2) DEFAULT 1;

-- Add comments for documentation
COMMENT ON COLUMN products.unit IS 'Purchase unit (box, case, pack, etc.) - how you buy it';
COMMENT ON COLUMN products.base_unit IS 'Distribution unit (unit, piece, bag, etc.) - smallest unit for distribution';
COMMENT ON COLUMN products.units_per_package IS 'How many base units are in one purchase unit (e.g., 12 units per box)';

-- Set default values for existing products (assume 1:1 conversion for existing data)
UPDATE products 
SET 
  base_unit = unit,
  units_per_package = 1
WHERE base_unit IS NULL;

-- Make base_unit NOT NULL after setting defaults
ALTER TABLE products 
ALTER COLUMN base_unit SET NOT NULL,
ALTER COLUMN base_unit SET DEFAULT 'unit';

-- Note: All quantities in site_inventory, stock_movements are stored in BASE UNITS
-- This means if you buy 1 box (with 12 units), inventory will show 12 units
