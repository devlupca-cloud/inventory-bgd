-- ============================================
-- SEED FAKE DATA FOR TESTING
-- Execute this in Supabase SQL Editor
-- ============================================

-- Note: Replace 'YOUR_USER_ID' with your actual user ID from auth.users
-- You can get it by running: SELECT id FROM auth.users WHERE email = 'your@email.com';

DO $$
DECLARE
  v_user_id UUID := '95695c12-3202-43a9-b3f3-9bd96ddfb163'; -- CHANGE THIS!
  v_master_site_id UUID;
  v_site_chefs_hall UUID;
  v_site_hhr_law UUID;
  v_site_downtown UUID;
  v_site_tech_center UUID;
  
  v_product_rice UUID;
  v_product_beans UUID;
  v_product_oil UUID;
  v_product_salt UUID;
  v_product_sugar UUID;
  v_product_coffee UUID;
  v_product_paper UUID;
  v_product_soap UUID;
  v_product_cleaner UUID;
  v_product_wipes UUID;
  
  v_pr1 UUID;
  v_pr2 UUID;
  v_pr3 UUID;
  v_pr4 UUID;
  v_pr5 UUID;
  v_pr6 UUID;
  
BEGIN
  -- Clean up existing test data (optional - comment out if you want to keep existing data)
  -- DELETE FROM stock_movements;
  -- DELETE FROM purchase_request_items;
  -- DELETE FROM purchase_requests;
  -- DELETE FROM direct_purchases;
  -- DELETE FROM site_inventory;
  -- DELETE FROM products;
  -- DELETE FROM sites WHERE name != 'Master Warehouse';

  -- ============================================
  -- 1. CREATE SITES
  -- ============================================
  
  -- Get or create Master Warehouse
  SELECT id INTO v_master_site_id FROM sites WHERE is_master = true LIMIT 1;
  
  IF v_master_site_id IS NULL THEN
    INSERT INTO sites (name, address, is_master)
    VALUES ('Master Warehouse', 'Central Storage Facility, Downtown', true)
    RETURNING id INTO v_master_site_id;
  END IF;
  
  -- Create regular sites
  INSERT INTO sites (name, address, supervisor_name, supervisor_phone, is_master)
  VALUES 
    ('Chef''s Hall Restaurant', '123 Culinary Street, District 1', 'Carlos Silva', '+55 11 98765-4321', false),
    ('HHR Law Firm', '456 Justice Avenue, District 2', 'Maria Santos', '+55 11 97654-3210', false),
    ('Downtown Office', '789 Business Blvd, District 3', 'João Oliveira', '+55 11 96543-2109', false),
    ('Tech Center', '321 Innovation Drive, District 4', 'Ana Costa', '+55 11 95432-1098', false);
  
  -- Get site IDs
  SELECT id INTO v_site_chefs_hall FROM sites WHERE name = 'Chef''s Hall Restaurant' LIMIT 1;
  SELECT id INTO v_site_hhr_law FROM sites WHERE name = 'HHR Law Firm' LIMIT 1;
  SELECT id INTO v_site_downtown FROM sites WHERE name = 'Downtown Office' LIMIT 1;
  SELECT id INTO v_site_tech_center FROM sites WHERE name = 'Tech Center' LIMIT 1;

  -- ============================================
  -- 2. CREATE PRODUCTS
  -- ============================================
  
  INSERT INTO products (name, unit, price)
  VALUES 
    ('Rice 5kg', 'bag', 25.50),
    ('Black Beans 1kg', 'bag', 8.90),
    ('Cooking Oil 900ml', 'bottle', 12.30),
    ('Salt 1kg', 'bag', 3.50),
    ('Sugar 1kg', 'bag', 4.20),
    ('Coffee Powder 500g', 'pack', 18.75),
    ('Toilet Paper 12 rolls', 'pack', 22.50),
    ('Liquid Soap 500ml', 'bottle', 8.50),
    ('Glass Cleaner 500ml', 'bottle', 11.20),
    ('Disinfectant Wipes 50ct', 'case', 15.80);
  
  -- Get product IDs
  SELECT id INTO v_product_rice FROM products WHERE name = 'Rice 5kg' LIMIT 1;
  SELECT id INTO v_product_beans FROM products WHERE name = 'Black Beans 1kg' LIMIT 1;
  SELECT id INTO v_product_oil FROM products WHERE name = 'Cooking Oil 900ml' LIMIT 1;
  SELECT id INTO v_product_salt FROM products WHERE name = 'Salt 1kg' LIMIT 1;
  SELECT id INTO v_product_sugar FROM products WHERE name = 'Sugar 1kg' LIMIT 1;
  SELECT id INTO v_product_coffee FROM products WHERE name = 'Coffee Powder 500g' LIMIT 1;
  SELECT id INTO v_product_paper FROM products WHERE name = 'Toilet Paper 12 rolls' LIMIT 1;
  SELECT id INTO v_product_soap FROM products WHERE name = 'Liquid Soap 500ml' LIMIT 1;
  SELECT id INTO v_product_cleaner FROM products WHERE name = 'Glass Cleaner 500ml' LIMIT 1;
  SELECT id INTO v_product_wipes FROM products WHERE name = 'Disinfectant Wipes 50ct' LIMIT 1;

  -- ============================================
  -- 3. CREATE PURCHASE REQUESTS (DIFFERENT MONTHS)
  -- ============================================
  
  -- PR1: October 2025 - FULFILLED
  INSERT INTO purchase_requests (site_id, status, requested_by, approved_by, approved_at, notes, created_at, updated_at)
  VALUES (
    NULL,
    'fulfilled',
    v_user_id,
    v_user_id,
    '2025-10-15 10:00:00',
    'Monthly supplies for Chef''s Hall and HHR Law',
    '2025-10-10 09:00:00',
    '2025-10-15 14:30:00'
  )
  RETURNING id INTO v_pr1;
  
  -- PR1 Items
  INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, quantity_received, unit_price, target_site_id)
  VALUES
    (v_pr1, v_product_rice, 20, 20, 25.50, v_site_chefs_hall),
    (v_pr1, v_product_beans, 30, 30, 8.90, v_site_chefs_hall),
    (v_pr1, v_product_oil, 15, 15, 12.30, v_site_chefs_hall),
    (v_pr1, v_product_paper, 10, 10, 22.50, v_site_hhr_law),
    (v_pr1, v_product_soap, 20, 20, 8.50, v_site_hhr_law);
  
  -- PR2: November 2025 - FULFILLED
  INSERT INTO purchase_requests (site_id, status, requested_by, approved_by, approved_at, notes, created_at, updated_at)
  VALUES (
    NULL,
    'fulfilled',
    v_user_id,
    v_user_id,
    '2025-11-12 11:00:00',
    'Restock for all locations',
    '2025-11-08 08:30:00',
    '2025-11-12 16:00:00'
  )
  RETURNING id INTO v_pr2;
  
  -- PR2 Items
  INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, quantity_received, unit_price, target_site_id)
  VALUES
    (v_pr2, v_product_coffee, 25, 25, 18.75, v_site_downtown),
    (v_pr2, v_product_sugar, 40, 35, 4.20, v_site_chefs_hall),
    (v_pr2, v_product_salt, 30, 30, 3.50, v_site_chefs_hall),
    (v_pr2, v_product_cleaner, 15, 15, 11.20, v_site_tech_center),
    (v_pr2, v_product_wipes, 20, 18, 15.80, v_site_tech_center);
  
  -- PR3: December 2025 - FULFILLED
  INSERT INTO purchase_requests (site_id, status, requested_by, approved_by, approved_at, notes, created_at, updated_at)
  VALUES (
    NULL,
    'fulfilled',
    v_user_id,
    v_user_id,
    '2025-12-05 09:30:00',
    'Year-end supplies',
    '2025-12-01 10:00:00',
    '2025-12-05 15:00:00'
  )
  RETURNING id INTO v_pr3;
  
  -- PR3 Items
  INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, quantity_received, unit_price, target_site_id)
  VALUES
    (v_pr3, v_product_rice, 30, 30, 26.00, v_site_chefs_hall),
    (v_pr3, v_product_beans, 40, 40, 9.20, v_site_chefs_hall),
    (v_pr3, v_product_paper, 25, 25, 23.00, v_site_hhr_law),
    (v_pr3, v_product_soap, 30, 30, 8.75, v_site_downtown),
    (v_pr3, v_product_coffee, 20, 20, 19.50, v_site_downtown);
  
  -- PR4: January 2026 - FULFILLED
  INSERT INTO purchase_requests (site_id, status, requested_by, approved_by, approved_at, notes, created_at, updated_at)
  VALUES (
    NULL,
    'fulfilled',
    v_user_id,
    v_user_id,
    '2026-01-10 10:30:00',
    'New year restock',
    '2026-01-05 09:00:00',
    '2026-01-10 14:00:00'
  )
  RETURNING id INTO v_pr4;
  
  -- PR4 Items
  INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, quantity_received, unit_price, target_site_id)
  VALUES
    (v_pr4, v_product_oil, 20, 20, 12.50, v_site_chefs_hall),
    (v_pr4, v_product_salt, 25, 25, 3.60, v_site_chefs_hall),
    (v_pr4, v_product_wipes, 30, 30, 16.00, v_site_tech_center),
    (v_pr4, v_product_cleaner, 20, 20, 11.50, v_site_hhr_law);
  
  -- PR5: January 2026 - APPROVED (ready to purchase)
  INSERT INTO purchase_requests (site_id, status, requested_by, approved_by, approved_at, notes, created_at, updated_at)
  VALUES (
    NULL,
    'approved',
    v_user_id,
    v_user_id,
    '2026-01-20 11:00:00',
    'Mid-month supplies',
    '2026-01-18 10:00:00',
    '2026-01-20 11:00:00'
  )
  RETURNING id INTO v_pr5;
  
  -- PR5 Items
  INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, quantity_received, unit_price, target_site_id)
  VALUES
    (v_pr5, v_product_rice, 15, 0, 25.50, v_site_downtown),
    (v_pr5, v_product_coffee, 10, 0, 18.75, v_site_tech_center),
    (v_pr5, v_product_paper, 12, 0, 22.50, v_site_hhr_law);
  
  -- PR6: January 2026 - SUBMITTED (waiting approval)
  INSERT INTO purchase_requests (site_id, status, requested_by, notes, created_at, updated_at)
  VALUES (
    NULL,
    'submitted',
    v_user_id,
    'Urgent cleaning supplies needed',
    '2026-01-22 14:00:00',
    '2026-01-22 14:00:00'
  )
  RETURNING id INTO v_pr6;
  
  -- PR6 Items
  INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, quantity_received, unit_price, target_site_id)
  VALUES
    (v_pr6, v_product_soap, 25, 0, 8.50, v_site_downtown),
    (v_pr6, v_product_cleaner, 18, 0, 11.20, v_site_tech_center),
    (v_pr6, v_product_wipes, 15, 0, 15.80, v_site_hhr_law);

  -- ============================================
  -- 4. CREATE DIRECT PURCHASES (for monthly spending)
  -- ============================================
  
  -- Direct purchases in October
  INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, notes, purchased_at, purchased_by)
  VALUES
    (v_product_sugar, 50, 4.10, 'Emergency restock', '2025-10-20 10:00:00', v_user_id),
    (v_product_coffee, 30, 18.50, 'Extra coffee for events', '2025-10-25 11:00:00', v_user_id);
  
  -- Direct purchases in November
  INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, notes, purchased_at, purchased_by)
  VALUES
    (v_product_paper, 40, 22.00, 'Bulk purchase discount', '2025-11-18 09:00:00', v_user_id);
  
  -- Direct purchases in December
  INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, notes, purchased_at, purchased_by)
  VALUES
    (v_product_wipes, 25, 15.50, 'Year-end cleaning', '2025-12-15 10:00:00', v_user_id),
    (v_product_soap, 35, 8.30, 'Discount batch', '2025-12-20 14:00:00', v_user_id);
  
  -- Direct purchases in January
  INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, notes, purchased_at, purchased_by)
  VALUES
    (v_product_beans, 45, 9.00, 'New supplier test', '2026-01-12 09:30:00', v_user_id);

  -- ============================================
  -- 5. CREATE STOCK MOVEMENTS (distributions)
  -- ============================================
  
  -- Distributions from PR1 (October)
  INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
  VALUES
    -- To Master first (when purchased)
    (v_master_site_id, v_product_rice, 'IN', 20, 'Purchase from request ' || v_pr1, v_user_id, '2025-10-15 14:30:00'),
    (v_master_site_id, v_product_beans, 'IN', 30, 'Purchase from request ' || v_pr1, v_user_id, '2025-10-15 14:30:00'),
    (v_master_site_id, v_product_oil, 'IN', 15, 'Purchase from request ' || v_pr1, v_user_id, '2025-10-15 14:30:00'),
    (v_master_site_id, v_product_paper, 'IN', 10, 'Purchase from request ' || v_pr1, v_user_id, '2025-10-15 14:30:00'),
    (v_master_site_id, v_product_soap, 'IN', 20, 'Purchase from request ' || v_pr1, v_user_id, '2025-10-15 14:30:00'),
    
    -- Distributions to sites
    (v_master_site_id, v_product_rice, 'TRANSFER_OUT', 20, 'Distribution from purchase request ' || v_pr1, v_user_id, '2025-10-16 10:00:00'),
    (v_site_chefs_hall, v_product_rice, 'TRANSFER_IN', 20, 'Distribution from purchase request ' || v_pr1, v_user_id, '2025-10-16 10:00:00'),
    
    (v_master_site_id, v_product_beans, 'TRANSFER_OUT', 30, 'Distribution from purchase request ' || v_pr1, v_user_id, '2025-10-16 10:05:00'),
    (v_site_chefs_hall, v_product_beans, 'TRANSFER_IN', 30, 'Distribution from purchase request ' || v_pr1, v_user_id, '2025-10-16 10:05:00'),
    
    (v_master_site_id, v_product_oil, 'TRANSFER_OUT', 15, 'Distribution from purchase request ' || v_pr1, v_user_id, '2025-10-16 10:10:00'),
    (v_site_chefs_hall, v_product_oil, 'TRANSFER_IN', 15, 'Distribution from purchase request ' || v_pr1, v_user_id, '2025-10-16 10:10:00'),
    
    (v_master_site_id, v_product_paper, 'TRANSFER_OUT', 10, 'Distribution from purchase request ' || v_pr1, v_user_id, '2025-10-16 11:00:00'),
    (v_site_hhr_law, v_product_paper, 'TRANSFER_IN', 10, 'Distribution from purchase request ' || v_pr1, v_user_id, '2025-10-16 11:00:00'),
    
    (v_master_site_id, v_product_soap, 'TRANSFER_OUT', 20, 'Distribution from purchase request ' || v_pr1, v_user_id, '2025-10-16 11:05:00'),
    (v_site_hhr_law, v_product_soap, 'TRANSFER_IN', 20, 'Distribution from purchase request ' || v_pr1, v_user_id, '2025-10-16 11:05:00');
  
  -- Similar distributions for PR2 (November)
  INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
  VALUES
    (v_master_site_id, v_product_coffee, 'IN', 25, 'Purchase from request ' || v_pr2, v_user_id, '2025-11-12 16:00:00'),
    (v_master_site_id, v_product_sugar, 'IN', 35, 'Purchase from request ' || v_pr2, v_user_id, '2025-11-12 16:00:00'),
    (v_master_site_id, v_product_salt, 'IN', 30, 'Purchase from request ' || v_pr2, v_user_id, '2025-11-12 16:00:00'),
    (v_master_site_id, v_product_cleaner, 'IN', 15, 'Purchase from request ' || v_pr2, v_user_id, '2025-11-12 16:00:00'),
    (v_master_site_id, v_product_wipes, 'IN', 18, 'Purchase from request ' || v_pr2, v_user_id, '2025-11-12 16:00:00'),
    
    -- Partial distributions for PR2
    (v_master_site_id, v_product_coffee, 'TRANSFER_OUT', 15, 'Distribution from purchase request ' || v_pr2, v_user_id, '2025-11-13 10:00:00'),
    (v_site_downtown, v_product_coffee, 'TRANSFER_IN', 15, 'Distribution from purchase request ' || v_pr2, v_user_id, '2025-11-13 10:00:00'),
    
    (v_master_site_id, v_product_cleaner, 'TRANSFER_OUT', 10, 'Distribution from purchase request ' || v_pr2, v_user_id, '2025-11-13 11:00:00'),
    (v_site_tech_center, v_product_cleaner, 'TRANSFER_IN', 10, 'Distribution from purchase request ' || v_pr2, v_user_id, '2025-11-13 11:00:00');
  
  -- Distributions for PR3 (December) and PR4 (January) - abbreviated
  INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
  VALUES
    -- PR3 purchases
    (v_master_site_id, v_product_rice, 'IN', 30, 'Purchase from request ' || v_pr3, v_user_id, '2025-12-05 15:00:00'),
    (v_master_site_id, v_product_beans, 'IN', 40, 'Purchase from request ' || v_pr3, v_user_id, '2025-12-05 15:00:00'),
    (v_master_site_id, v_product_paper, 'IN', 25, 'Purchase from request ' || v_pr3, v_user_id, '2025-12-05 15:00:00'),
    
    -- PR4 purchases
    (v_master_site_id, v_product_oil, 'IN', 20, 'Purchase from request ' || v_pr4, v_user_id, '2026-01-10 14:00:00'),
    (v_master_site_id, v_product_wipes, 'IN', 30, 'Purchase from request ' || v_pr4, v_user_id, '2026-01-10 14:00:00');

  -- ============================================
  -- 6. UPDATE SITE INVENTORY (current stock)
  -- ============================================
  
  -- Master Warehouse (has some undistributed stock)
  INSERT INTO site_inventory (site_id, product_id, quantity_on_hand, last_updated)
  VALUES
    (v_master_site_id, v_product_coffee, 10, NOW()),
    (v_master_site_id, v_product_sugar, 35, NOW()),
    (v_master_site_id, v_product_salt, 30, NOW()),
    (v_master_site_id, v_product_cleaner, 5, NOW()),
    (v_master_site_id, v_product_wipes, 18, NOW()),
    (v_master_site_id, v_product_rice, 30, NOW()),
    (v_master_site_id, v_product_beans, 40, NOW()),
    (v_master_site_id, v_product_paper, 25, NOW()),
    (v_master_site_id, v_product_oil, 20, NOW())
  ON CONFLICT (site_id, product_id) 
  DO UPDATE SET quantity_on_hand = EXCLUDED.quantity_on_hand, last_updated = EXCLUDED.last_updated;
  
  -- Chef's Hall
  INSERT INTO site_inventory (site_id, product_id, quantity_on_hand, last_updated)
  VALUES
    (v_site_chefs_hall, v_product_rice, 15, NOW()),
    (v_site_chefs_hall, v_product_beans, 22, NOW()),
    (v_site_chefs_hall, v_product_oil, 8, NOW()),
    (v_site_chefs_hall, v_product_salt, 12, NOW())
  ON CONFLICT (site_id, product_id) 
  DO UPDATE SET quantity_on_hand = EXCLUDED.quantity_on_hand, last_updated = EXCLUDED.last_updated;
  
  -- HHR Law
  INSERT INTO site_inventory (site_id, product_id, quantity_on_hand, last_updated)
  VALUES
    (v_site_hhr_law, v_product_paper, 8, NOW()),
    (v_site_hhr_law, v_product_soap, 15, NOW()),
    (v_site_hhr_law, v_product_wipes, 5, NOW())
  ON CONFLICT (site_id, product_id) 
  DO UPDATE SET quantity_on_hand = EXCLUDED.quantity_on_hand, last_updated = EXCLUDED.last_updated;
  
  -- Downtown Office
  INSERT INTO site_inventory (site_id, product_id, quantity_on_hand, last_updated)
  VALUES
    (v_site_downtown, v_product_coffee, 10, NOW()),
    (v_site_downtown, v_product_soap, 8, NOW())
  ON CONFLICT (site_id, product_id) 
  DO UPDATE SET quantity_on_hand = EXCLUDED.quantity_on_hand, last_updated = EXCLUDED.last_updated;
  
  -- Tech Center
  INSERT INTO site_inventory (site_id, product_id, quantity_on_hand, last_updated)
  VALUES
    (v_site_tech_center, v_product_cleaner, 7, NOW()),
    (v_site_tech_center, v_product_wipes, 12, NOW())
  ON CONFLICT (site_id, product_id) 
  DO UPDATE SET quantity_on_hand = EXCLUDED.quantity_on_hand, last_updated = EXCLUDED.last_updated;

  RAISE NOTICE 'Fake data created successfully!';
  RAISE NOTICE 'Master Site: %', v_master_site_id;
  RAISE NOTICE 'Created % sites, % products, % purchase requests', 4, 10, 6;
  
END $$;

-- ============================================
-- VERIFY DATA
-- ============================================

SELECT 'Sites Created' as info, COUNT(*) as count FROM sites;
SELECT 'Products Created' as info, COUNT(*) as count FROM products;
SELECT 'Purchase Requests' as info, COUNT(*) as count FROM purchase_requests;
SELECT 'Purchase Request Items' as info, COUNT(*) as count FROM purchase_request_items;
SELECT 'Stock Movements' as info, COUNT(*) as count FROM stock_movements;
SELECT 'Direct Purchases' as info, COUNT(*) as count FROM direct_purchases;
SELECT 'Site Inventory Records' as info, COUNT(*) as count FROM site_inventory;
