-- Add foreign key constraint from products.unit to units.value
-- First, ensure all existing product units exist in the units table
INSERT INTO units (value, label, sort_order)
SELECT DISTINCT p.unit, p.unit, 100
FROM products p
WHERE p.unit IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM units u WHERE u.value = p.unit)
ON CONFLICT (value) DO NOTHING;

-- Add the foreign key constraint
ALTER TABLE products
ADD CONSTRAINT fk_products_unit
FOREIGN KEY (unit) REFERENCES units(value)
ON UPDATE CASCADE
ON DELETE RESTRICT;

-- Create index for better join performance
CREATE INDEX IF NOT EXISTS idx_products_unit ON products(unit);
