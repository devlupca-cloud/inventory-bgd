const XLSX = require('xlsx');
const fs = require('fs');

function cleanProductName(name) {
  if (!name) return null;
  return name.toString().trim();
}

function parseQuantity(value) {
  if (!value || value === 'N/A' || value === '') return 0;
  const num = parseFloat(value);
  return isNaN(num) ? 0 : Math.floor(num);
}

function excelDateToISO(excelDate) {
  if (!excelDate || typeof excelDate !== 'number') return null;
  const date = new Date((excelDate - 25569) * 86400 * 1000);
  return date.toISOString();
}

function mapRequestStatus(excelStatus) {
  const statusMap = {
    'Ordered': 'approved',
    'Pending': 'submitted',
    'Relocated': 'draft',
    'Fulfilled': 'fulfilled',
  };
  return statusMap[excelStatus] || 'draft';
}

const workbook = XLSX.readFile('Supplies Management.xlsx');
const supplies = XLSX.utils.sheet_to_json(workbook.Sheets['Supplies'], { defval: null });
const sites = XLSX.utils.sheet_to_json(workbook.Sheets['Sites'], { defval: null });
const inventory = XLSX.utils.sheet_to_json(workbook.Sheets['Inventory'], { defval: null });
const requests = XLSX.utils.sheet_to_json(workbook.Sheets['Requests'], { defval: null });
const purchases = XLSX.utils.sheet_to_json(workbook.Sheets['Purchases'], { defval: null });

console.log('📊 Data Summary:');
console.log(`- Products: ${supplies.filter(r => r['Supplies list'] && r['Unit price']).length}`);
console.log(`- Sites: ${sites.filter(r => r['Sites']).length}`);
console.log(`- Inventory rows: ${inventory.filter(r => r['Supply']).length}`);
console.log(`- Requests: ${requests.length}`);
console.log(`- Purchases: ${purchases.length}\n`);

let sql = `-- Complete Import from Excel: Supplies Management.xlsx
-- Generated: ${new Date().toISOString()}
-- ⚠️  REVIEW BEFORE RUNNING!
-- Note: Some data may be incomplete. Review and adjust as needed.

-- ============================================
-- STEP 1: Products
-- ============================================
DO $$
DECLARE
  v_product_id UUID;
BEGIN
`;

supplies.forEach((row) => {
  const name = cleanProductName(row['Supplies list']);
  const price = parseFloat(row['Unit price']) || 0;
  
  if (!name || price <= 0) return;
  
  const safeName = name.replace(/'/g, "''");
  
  sql += `  -- Product: ${name}\n`;
  sql += `  SELECT id INTO v_product_id FROM products WHERE name = '${safeName}' LIMIT 1;\n`;
  sql += `  IF v_product_id IS NULL THEN\n`;
  sql += `    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)\n`;
  sql += `    VALUES ('${safeName}', 'box', 'unit', 1, ${price.toFixed(2)}, NOW(), NOW());\n`;
  sql += `  ELSE\n`;
  sql += `    UPDATE products SET price = ${price.toFixed(2)}, updated_at = NOW() WHERE id = v_product_id;\n`;
  sql += `  END IF;\n\n`;
});

sql += `END $$;\n\n`;

// Sites
sql += `-- ============================================
-- STEP 2: Sites
-- ============================================
DO $$
DECLARE
  v_site_id UUID;
BEGIN
`;

sites.forEach((row) => {
  const name = cleanProductName(row['Sites']);
  if (!name) return;
  
  const safeName = name.replace(/'/g, "''");
  const address = row['Endereço'] ? row['Endereço'].toString().replace(/'/g, "''") : null;
  const isMaster = name.toLowerCase().includes('general') ? 'true' : 'false';
  
  sql += `  -- Site: ${name}\n`;
  sql += `  SELECT id INTO v_site_id FROM sites WHERE name = '${safeName}' LIMIT 1;\n`;
  sql += `  IF v_site_id IS NULL THEN\n`;
  sql += `    INSERT INTO sites (name, address, is_master, created_at, updated_at)\n`;
  sql += `    VALUES ('${safeName}', ${address ? `'${address}'` : 'NULL'}, ${isMaster}, NOW(), NOW());\n`;
  sql += `  ELSE\n`;
  sql += `    UPDATE sites SET address = COALESCE(${address ? `'${address}'` : 'NULL'}, sites.address), updated_at = NOW() WHERE id = v_site_id;\n`;
  sql += `  END IF;\n\n`;
});

sql += `END $$;\n\n`;

// Inventory
sql += `-- ============================================
-- STEP 3: Inventory
-- ============================================
DO $$
DECLARE
  v_product_id UUID;
  v_site_id UUID;
BEGIN
`;

const siteColumns = Object.keys(inventory[0] || {}).filter(col => col !== 'Supply');

inventory.forEach((row) => {
  const productName = cleanProductName(row['Supply']);
  if (!productName) return;
  
  const safeProductName = productName.replace(/'/g, "''");
  
  siteColumns.forEach((siteName) => {
    const qty = parseQuantity(row[siteName]);
    if (qty > 0) {
      const safeSiteName = siteName.replace(/'/g, "''");
      sql += `  -- ${productName} -> ${siteName}: ${qty} boxes\n`;
      sql += `  SELECT id INTO v_product_id FROM products WHERE name = '${safeProductName}' LIMIT 1;\n`;
      sql += `  SELECT id INTO v_site_id FROM sites WHERE name = '${safeSiteName}' LIMIT 1;\n`;
      sql += `  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN\n`;
      sql += `    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)\n`;
      sql += `    VALUES (v_site_id, v_product_id, ${qty}, 0, NOW())\n`;
      sql += `    ON CONFLICT (site_id, product_id) DO UPDATE SET\n`;
      sql += `      quantity_packages = EXCLUDED.quantity_packages,\n`;
      sql += `      quantity_loose_units = 0,\n`;
      sql += `      last_updated = NOW();\n`;
      sql += `  END IF;\n\n`;
    }
  });
});

sql += `END $$;\n\n`;

// Purchase Requests - Group by Date + Site
const requestGroups = new Map();
requests.forEach((row) => {
  const dateRequested = row['Date Requested'];
  const siteName = cleanProductName(row['Site']);
  const productName = cleanProductName(row['Product']);
  const quantity = parseQuantity(row['Quantity']);
  const unitPrice = parseFloat(row[' Est. Unit Price ']) || 0;
  const status = row['Status'] || 'Pending';
  
  if (!dateRequested || !siteName || !productName || quantity <= 0) return;
  
  const groupKey = `${dateRequested}_${siteName}`;
  if (!requestGroups.has(groupKey)) {
    requestGroups.set(groupKey, {
      dateRequested,
      siteName,
      status,
      items: []
    });
  }
  
  requestGroups.get(groupKey).items.push({
    productName,
    quantity,
    unitPrice
  });
});

sql += `-- ============================================
-- STEP 4: Purchase Requests (from Requests sheet)
-- Grouped by Date Requested + Site
-- ============================================
DO $$
DECLARE
  v_product_id UUID;
  v_site_id UUID;
  v_request_id UUID;
  v_user_id UUID;
  v_request_date TIMESTAMP;
BEGIN
  -- Get a user ID (use first manager/owner)
  SELECT id INTO v_user_id FROM user_profiles WHERE role IN ('manager', 'owner') LIMIT 1;
  
  IF v_user_id IS NULL THEN
    RAISE NOTICE 'No manager/owner user found. Purchase requests will not have created_by.';
  END IF;

`;

requestGroups.forEach((group) => {
  const safeSiteName = group.siteName.replace(/'/g, "''");
  const requestDate = excelDateToISO(group.dateRequested);
  const status = mapRequestStatus(group.status);
  
  sql += `  -- Purchase Request: ${group.siteName} - ${requestDate ? new Date(requestDate).toLocaleDateString() : 'Unknown date'}\n`;
  sql += `  SELECT id INTO v_site_id FROM sites WHERE name = '${safeSiteName}' LIMIT 1;\n`;
  sql += `  IF v_site_id IS NOT NULL THEN\n`;
  sql += `    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)\n`;
  sql += `    VALUES (v_site_id, '${status}', ${requestDate ? `'${requestDate}'` : 'NOW()'}, v_user_id)\n`;
  sql += `    RETURNING id INTO v_request_id;\n\n`;
  
  group.items.forEach((item) => {
    const safeProductName = item.productName.replace(/'/g, "''");
    sql += `    -- Item: ${item.productName} - ${item.quantity} @ $ ${item.unitPrice.toFixed(2)}\n`;
    sql += `    SELECT id INTO v_product_id FROM products WHERE name = '${safeProductName}' LIMIT 1;\n`;
    sql += `    IF v_product_id IS NOT NULL THEN\n`;
    sql += `      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)\n`;
    sql += `      VALUES (v_request_id, v_product_id, ${item.quantity}, ${item.unitPrice.toFixed(2)}, v_site_id);\n`;
    sql += `    END IF;\n\n`;
  });
  
  sql += `  END IF;\n\n`;
});

sql += `END $$;\n\n`;

// Direct Purchases
sql += `-- ============================================
-- STEP 5: Direct Purchases (from Purchases sheet)
-- These are added to MASTER warehouse inventory
-- ============================================
DO $$
DECLARE
  v_product_id UUID;
  v_site_id UUID;
  v_master_site_id UUID;
  v_user_id UUID;
  v_purchase_id UUID;
  v_purchase_date TIMESTAMP;
BEGIN
  -- Get master site
  SELECT id INTO v_master_site_id FROM sites WHERE is_master = true LIMIT 1;
  
  IF v_master_site_id IS NULL THEN
    RAISE EXCEPTION 'Master warehouse not found!';
  END IF;
  
  -- Get a user ID
  SELECT id INTO v_user_id FROM user_profiles WHERE role IN ('manager', 'owner') LIMIT 1;
  
  IF v_user_id IS NULL THEN
    RAISE NOTICE 'No manager/owner user found. Direct purchases will not have purchased_by.';
  END IF;

`;

purchases.forEach((row, index) => {
  const siteName = cleanProductName(row['Site']);
  const productName = cleanProductName(row['Product']);
  const quantity = parseQuantity(row['Quantity']);
  const unitPrice = parseFloat(row['Unit Price']) || 0;
  const notes = row['Notes'] ? row['Notes'].toString().replace(/'/g, "''") : null;
  const dateReceived = row['Date Received'];
  const purchaseDate = dateReceived ? excelDateToISO(dateReceived) : null;
  
  if (!siteName || !productName || quantity <= 0 || unitPrice <= 0) return;
  
  const safeSiteName = siteName.replace(/'/g, "''");
  const safeProductName = productName.replace(/'/g, "''");
  const purchaseNotes = notes || `Imported from Excel - Original Site: ${safeSiteName}`;
  
  sql += `  -- Purchase ${index + 1}: ${productName} -> ${siteName} (${quantity} @ $ ${unitPrice.toFixed(2)})\n`;
  sql += `  SELECT id INTO v_product_id FROM products WHERE name = '${safeProductName}' LIMIT 1;\n`;
  sql += `  IF v_product_id IS NOT NULL THEN\n`;
  sql += `    -- Create direct purchase record\n`;
  sql += `    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)\n`;
  sql += `    VALUES (\n`;
  sql += `      v_product_id,\n`;
  sql += `      ${quantity},\n`;
  sql += `      ${unitPrice.toFixed(2)},\n`;
  sql += `      ${purchaseDate ? `'${purchaseDate}'` : 'NOW()'},\n`;
  sql += `      v_user_id,\n`;
  sql += `      '${purchaseNotes.replace(/'/g, "''")}'\n`;
  sql += `    ) RETURNING id INTO v_purchase_id;\n\n`;
  
  sql += `    -- Add to master warehouse inventory (as packages)\n`;
  sql += `    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)\n`;
  sql += `    VALUES (v_master_site_id, v_product_id, ${quantity}, 0, NOW())\n`;
  sql += `    ON CONFLICT (site_id, product_id) DO UPDATE SET\n`;
  sql += `      quantity_packages = site_inventory.quantity_packages + ${quantity},\n`;
  sql += `      last_updated = NOW();\n\n`;
  
  sql += `    -- Record stock movement\n`;
  sql += `    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)\n`;
  sql += `    VALUES (\n`;
  sql += `      v_master_site_id,\n`;
  sql += `      v_product_id,\n`;
  sql += `      'IN',\n`;
  sql += `      ${quantity},\n`;
  sql += `      'Direct purchase from Excel - ${safeSiteName} - ${purchaseNotes.replace(/'/g, "''")}',\n`;
  sql += `      v_user_id,\n`;
  sql += `      ${purchaseDate ? `'${purchaseDate}'` : 'NOW()'}\n`;
  sql += `    );\n\n`;
  
  sql += `  END IF;\n\n`;
});

sql += `END $$;\n\n`;

sql += `-- ============================================
-- STEP 6: Verify Import
-- ============================================
SELECT 
  'Products' as table_name, COUNT(*) as count FROM products
UNION ALL
SELECT 'Sites', COUNT(*) FROM sites
UNION ALL
SELECT 'Inventory Records', COUNT(*) FROM site_inventory
UNION ALL
SELECT 'Purchase Requests', COUNT(*) FROM purchase_requests
UNION ALL
SELECT 'Purchase Request Items', COUNT(*) FROM purchase_request_items
UNION ALL
SELECT 'Direct Purchases', COUNT(*) FROM direct_purchases
UNION ALL
SELECT 'Stock Movements', COUNT(*) FROM stock_movements;
`;

fs.writeFileSync('import_excel_complete.sql', sql);
console.log('✅ Complete SQL file generated: import_excel_complete.sql');
console.log('\n📋 Summary:');
console.log(`- ${supplies.filter(r => r['Supplies list'] && r['Unit price']).length} products`);
console.log(`- ${sites.filter(r => r['Sites']).length} sites`);
console.log(`- ${inventory.filter(r => r['Supply']).length} products with inventory`);
console.log(`- ${requestGroups.size} purchase requests (grouped from ${requests.length} request items)`);
console.log(`- ${purchases.filter(r => r['Product'] && r['Quantity'] && r['Unit Price']).length} direct purchases`);
console.log('\n⚠️  NOTES:');
console.log('1. Purchase requests are grouped by Date + Site');
console.log('2. Direct purchases are added to MASTER warehouse inventory');
console.log('3. Some data may be incomplete (missing dates, users, etc.)');
console.log('4. Review the SQL before running!');
