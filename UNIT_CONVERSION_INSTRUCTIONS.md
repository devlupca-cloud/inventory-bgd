# Instructions: Add Unit Conversion Support

## What this adds:

This migration adds support for products that are purchased in one unit (e.g., "box") but distributed in smaller units (e.g., individual "units").

### Example:
- **Mop Head**: Buy by "box", distribute by "unit"
  - 1 box = 12 units
  - Price: R$ 120 per box = R$ 10 per unit
  - Can send: 2 boxes OR 15 units to a site

## Step 1: Run the Migration

1. Go to your Supabase Dashboard
2. Navigate to **SQL Editor**
3. Open the file: `migration_add_product_unit_conversion.sql`
4. Copy all the SQL and paste it into the SQL Editor
5. Click **Run**

## Step 2: Verify

After running the migration, verify the new columns exist:

```sql
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'products'
ORDER BY ordinal_position;
```

You should see:
- `base_unit` (character varying, NOT NULL)
- `units_per_package` (numeric, default 1)

## Step 3: Update Existing Products

All existing products will have:
- `base_unit` = same as `unit` 
- `units_per_package` = 1

You can now edit products to set proper conversions.

## How to Use:

### Creating a Product:

1. Go to **Products** → **New Product**
2. Fill in:
   - **Name**: Mop Head
   - **Purchase Unit**: box
   - **Price per Purchase Unit**: 120.00
   - **Distribution Unit**: unit
   - **Units per Package**: 12

The system will show: "1 box = 12 unit • Cost per unit: R$ 10.00"

### Distributing Products:

When distributing, you'll be able to choose:
- Send 2 **boxes** (= 24 units in inventory)
- OR send 15 **units** directly

All inventory is tracked in the **base unit** (smallest unit).

## Important Notes:

- **All quantities in `site_inventory` and `stock_movements` are stored in BASE UNITS**
- When you buy 1 box (12 units), the inventory will show **12** units
- When you distribute 3 units, the inventory decreases by **3** units
- Prices are calculated proportionally: (unit_price / units_per_package) × quantity

## Next Steps:

After running the migration, the Product Form will automatically include the new fields.
