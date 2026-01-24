const XLSX = require('xlsx');

const workbook = XLSX.readFile('Supplies Management.xlsx');

console.log('📊 All Sheets:', workbook.SheetNames);
console.log('\n');

// Analyze Requests sheet
if (workbook.Sheets['Requests']) {
  const requests = XLSX.utils.sheet_to_json(workbook.Sheets['Requests'], { defval: null });
  console.log('=== REQUESTS SHEET ===');
  console.log(`Total rows: ${requests.length}`);
  if (requests.length > 0) {
    console.log('Columns:', Object.keys(requests[0]));
    console.log('\nFirst 3 rows:');
    console.log(JSON.stringify(requests.slice(0, 3), null, 2));
    console.log('\nSample statuses:', [...new Set(requests.map(r => r.Status).filter(Boolean))]);
  }
}

console.log('\n');

// Analyze Purchases sheet
if (workbook.Sheets['Purchases']) {
  const purchases = XLSX.utils.sheet_to_json(workbook.Sheets['Purchases'], { defval: null });
  console.log('=== PURCHASES SHEET ===');
  console.log(`Total rows: ${purchases.length}`);
  if (purchases.length > 0) {
    console.log('Columns:', Object.keys(purchases[0]));
    console.log('\nFirst 3 rows:');
    console.log(JSON.stringify(purchases.slice(0, 3), null, 2));
  }
}
