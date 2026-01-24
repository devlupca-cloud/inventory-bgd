-- Migration: Add package and loose unit tracking to site_inventory
-- This allows tracking boxes/packages separately from loose units

-- Step 1: Add new columns
ALTER TABLE site_inventory 
ADD COLUMN IF NOT EXISTS quantity_packages INTEGER DEFAULT 0,
ADD COLUMN IF NOT EXISTS quantity_loose_units DECIMAL(10, 2) DEFAULT 0;

-- Step 2: Migrate existing data
-- Convert current quantity_on_hand (assumed to be in base units) to packages + loose units
DO $$
DECLARE
  inv_record RECORD;
  units_per_pkg DECIMAL;
  total_units DECIMAL;
  packages INTEGER;
  loose_units DECIMAL;
BEGIN
  FOR inv_record IN 
    SELECT si.site_id, si.product_id, si.quantity_on_hand, p.units_per_package
    FROM site_inventory si
    JOIN products p ON si.product_id = p.id
    WHERE si.quantity_on_hand > 0
  LOOP
    units_per_pkg := COALESCE(inv_record.units_per_package, 1);
    total_units := inv_record.quantity_on_hand;
    
    -- Calculate packages (full boxes)
    packages := FLOOR(total_units / units_per_pkg)::INTEGER;
    
    -- Calculate loose units (remainder)
    loose_units := total_units - (packages * units_per_pkg);
    
    -- Update the record
    UPDATE site_inventory
    SET 
      quantity_packages = packages,
      quantity_loose_units = loose_units
    WHERE site_id = inv_record.site_id
      AND product_id = inv_record.product_id;
  END LOOP;
END $$;

-- Step 3: Make quantity_on_hand a computed/generated column (or keep it as sum)
-- For now, we'll keep quantity_on_hand but it should be: packages * units_per_package + loose_units
-- We'll update it via triggers or application logic

-- Step 4: Add check constraint to ensure loose_units < units_per_package
-- (This will be enforced at application level since we need product info)

-- Step 5: Add comments
COMMENT ON COLUMN site_inventory.quantity_packages IS 'Number of complete packages/boxes (unopened)';
COMMENT ON COLUMN site_inventory.quantity_loose_units IS 'Number of loose units from opened packages';
COMMENT ON COLUMN site_inventory.quantity_on_hand IS 'Total quantity in base units (packages * units_per_package + loose_units)';

-- Step 6: Create function to sync quantity_on_hand
CREATE OR REPLACE FUNCTION sync_inventory_quantity()
RETURNS TRIGGER AS $$
DECLARE
  units_per_pkg DECIMAL;
BEGIN
  -- Get units_per_package for this product
  SELECT COALESCE(units_per_package, 1) INTO units_per_pkg
  FROM products
  WHERE id = NEW.product_id;
  
  -- Calculate total: packages * units_per_package + loose_units
  NEW.quantity_on_hand := (NEW.quantity_packages * units_per_pkg) + NEW.quantity_loose_units;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Step 7: Create trigger to auto-sync quantity_on_hand
DROP TRIGGER IF EXISTS sync_inventory_quantity_trigger ON site_inventory;
CREATE TRIGGER sync_inventory_quantity_trigger
  BEFORE INSERT OR UPDATE ON site_inventory
  FOR EACH ROW
  EXECUTE FUNCTION sync_inventory_quantity();

-- Step 8: Verify migration
SELECT 
  si.site_id,
  s.name as site_name,
  p.name as product_name,
  si.quantity_packages,
  si.quantity_loose_units,
  si.quantity_on_hand,
  p.units_per_package,
  (si.quantity_packages * p.units_per_package + si.quantity_loose_units) as calculated_total
FROM site_inventory si
JOIN sites s ON si.site_id = s.id
JOIN products p ON si.product_id = p.id
WHERE si.quantity_on_hand > 0
ORDER BY s.name, p.name
LIMIT 10;
