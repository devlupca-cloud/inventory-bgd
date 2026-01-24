# Fix: RLS Error on site_inventory

## Error
```
Failed to add to inventory: new row violates row-level security policy for table "site_inventory"
```

## Cause
The Row-Level Security (RLS) policies on the `site_inventory` table are not allowing managers to insert/update records during inventory operations.

## Solution

### Step 1: Run the Migration

1. Go to your **Supabase Dashboard**
2. Navigate to **SQL Editor**
3. Open the file: `migration_fix_site_inventory_rls.sql`
4. Copy all the SQL and paste it into the SQL Editor
5. Click **Run**

### Step 2: Verify Policies

After running, you should see 4 policies created:

1. **Users can view inventory for their sites** - SELECT
2. **Managers and owners can insert inventory** - INSERT
3. **Managers and owners can update inventory** - UPDATE
4. **Owners can delete inventory** - DELETE

### What This Does:

- ✅ Managers and Owners can now insert/update inventory records
- ✅ Users can view inventory for sites they have access to
- ✅ Only managers/owners can modify inventory
- ✅ Only owners can delete inventory

### After Running:

Try your operation again (direct purchase, distribution, etc.). The error should be resolved!

## Testing

After the migration, test:
1. **Direct Purchase** - Should work ✅
2. **Distribution** - Should work ✅
3. **Send to Site** - Should work ✅
4. **View Inventory** - Should work ✅

## Summary

- ❌ **Problem**: RLS blocking inserts/updates to `site_inventory`
- ✅ **Solution**: Policies allowing managers/owners to modify inventory
- 🎯 **Result**: All inventory operations now work correctly
