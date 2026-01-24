-- Complete Import from Excel: Supplies Management.xlsx
-- Generated: 2026-01-24T21:18:06.589Z
-- ⚠️  REVIEW BEFORE RUNNING!
-- Note: Some data may be incomplete. Review and adjust as needed.

-- ============================================
-- STEP 1: Products
-- ============================================
DO $$
DECLARE
  v_product_id UUID;
BEGIN
  -- Product: Garbage Bag 35x50 CLEAR
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 35x50 CLEAR' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Garbage Bag 35x50 CLEAR', 'box', 'unit', 1, 43.93, NOW(), NOW());
  ELSE
    UPDATE products SET price = 43.93, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Garbage Bag 35x50 BLACK
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 35x50 BLACK' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Garbage Bag 35x50 BLACK', 'box', 'unit', 1, 37.24, NOW(), NOW());
  ELSE
    UPDATE products SET price = 37.24, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Garbage Bag 30x38 CLEAR
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 30x38 CLEAR' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Garbage Bag 30x38 CLEAR', 'box', 'unit', 1, 30.23, NOW(), NOW());
  ELSE
    UPDATE products SET price = 30.23, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Garbage Bag 30x38 BLACK
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 30x38 BLACK' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Garbage Bag 30x38 BLACK', 'box', 'unit', 1, 24.22, NOW(), NOW());
  ELSE
    UPDATE products SET price = 24.22, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Garbage Bag 24x22 CLEAR
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 24x22 CLEAR' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Garbage Bag 24x22 CLEAR', 'box', 'unit', 1, 28.59, NOW(), NOW());
  ELSE
    UPDATE products SET price = 28.59, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Garbage Bag 24x22 BLACK
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 24x22 BLACK' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Garbage Bag 24x22 BLACK', 'box', 'unit', 1, 24.09, NOW(), NOW());
  ELSE
    UPDATE products SET price = 24.09, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Paper Towel Multifold
  SELECT id INTO v_product_id FROM products WHERE name = 'Paper Towel Multifold' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Paper Towel Multifold', 'box', 'unit', 1, 39.98, NOW(), NOW());
  ELSE
    UPDATE products SET price = 39.98, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Paper Towel Singlefold
  SELECT id INTO v_product_id FROM products WHERE name = 'Paper Towel Singlefold' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Paper Towel Singlefold', 'box', 'unit', 1, 39.99, NOW(), NOW());
  ELSE
    UPDATE products SET price = 39.99, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Toilet Paper Jumbo
  SELECT id INTO v_product_id FROM products WHERE name = 'Toilet Paper Jumbo' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Toilet Paper Jumbo', 'box', 'unit', 1, 44.97, NOW(), NOW());
  ELSE
    UPDATE products SET price = 44.97, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Toilet Paper Regular
  SELECT id INTO v_product_id FROM products WHERE name = 'Toilet Paper Regular' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Toilet Paper Regular', 'box', 'unit', 1, 38.99, NOW(), NOW());
  ELSE
    UPDATE products SET price = 38.99, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Toilet Paper Sierra
  SELECT id INTO v_product_id FROM products WHERE name = 'Toilet Paper Sierra' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Toilet Paper Sierra', 'box', 'unit', 1, 46.26, NOW(), NOW());
  ELSE
    UPDATE products SET price = 46.26, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Pine Sol
  SELECT id INTO v_product_id FROM products WHERE name = 'Pine Sol' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Pine Sol', 'box', 'unit', 1, 13.99, NOW(), NOW());
  ELSE
    UPDATE products SET price = 13.99, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Mr Clean
  SELECT id INTO v_product_id FROM products WHERE name = 'Mr Clean' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Mr Clean', 'box', 'unit', 1, 14.99, NOW(), NOW());
  ELSE
    UPDATE products SET price = 14.99, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: StrongArm
  SELECT id INTO v_product_id FROM products WHERE name = 'StrongArm' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('StrongArm', 'box', 'unit', 1, 38.08, NOW(), NOW());
  ELSE
    UPDATE products SET price = 38.08, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Windex
  SELECT id INTO v_product_id FROM products WHERE name = 'Windex' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Windex', 'box', 'unit', 1, 22.99, NOW(), NOW());
  ELSE
    UPDATE products SET price = 22.99, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Deep Blue
  SELECT id INTO v_product_id FROM products WHERE name = 'Deep Blue' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Deep Blue', 'box', 'unit', 1, 33.71, NOW(), NOW());
  ELSE
    UPDATE products SET price = 33.71, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Daily desinfectant
  SELECT id INTO v_product_id FROM products WHERE name = 'Daily desinfectant' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Daily desinfectant', 'box', 'unit', 1, 60.79, NOW(), NOW());
  ELSE
    UPDATE products SET price = 60.79, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Ph7 Ultra
  SELECT id INTO v_product_id FROM products WHERE name = 'Ph7 Ultra' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Ph7 Ultra', 'box', 'unit', 1, 25.45, NOW(), NOW());
  ELSE
    UPDATE products SET price = 25.45, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Kool Splash Aloe Vera Foaming Soap
  SELECT id INTO v_product_id FROM products WHERE name = 'Kool Splash Aloe Vera Foaming Soap' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Kool Splash Aloe Vera Foaming Soap', 'box', 'unit', 1, 17.98, NOW(), NOW());
  ELSE
    UPDATE products SET price = 17.98, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Toilet bowl
  SELECT id INTO v_product_id FROM products WHERE name = 'Toilet bowl' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Toilet bowl', 'box', 'unit', 1, 14.99, NOW(), NOW());
  ELSE
    UPDATE products SET price = 14.99, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Mop head (boxes)
  SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Mop head (boxes)', 'box', 'unit', 1, 6.88, NOW(), NOW());
  ELSE
    UPDATE products SET price = 6.88, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Gloves Small
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Small' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Gloves Small', 'box', 'unit', 1, 10.50, NOW(), NOW());
  ELSE
    UPDATE products SET price = 10.50, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Gloves Medium
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Medium' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Gloves Medium', 'box', 'unit', 1, 10.50, NOW(), NOW());
  ELSE
    UPDATE products SET price = 10.50, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Gloves Large
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Large' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Gloves Large', 'box', 'unit', 1, 10.50, NOW(), NOW());
  ELSE
    UPDATE products SET price = 10.50, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Gloves X-Large
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves X-Large' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Gloves X-Large', 'box', 'unit', 1, 10.50, NOW(), NOW());
  ELSE
    UPDATE products SET price = 10.50, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Febreeze air freshener
  SELECT id INTO v_product_id FROM products WHERE name = 'Febreeze air freshener' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Febreeze air freshener', 'box', 'unit', 1, 18.99, NOW(), NOW());
  ELSE
    UPDATE products SET price = 18.99, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Maxithins Pads
  SELECT id INTO v_product_id FROM products WHERE name = 'Maxithins Pads' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Maxithins Pads', 'box', 'unit', 1, 78.39, NOW(), NOW());
  ELSE
    UPDATE products SET price = 78.39, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Tampax
  SELECT id INTO v_product_id FROM products WHERE name = 'Tampax' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Tampax', 'box', 'unit', 1, 137.29, NOW(), NOW());
  ELSE
    UPDATE products SET price = 137.29, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Cloth
  SELECT id INTO v_product_id FROM products WHERE name = 'Cloth' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Cloth', 'box', 'unit', 1, 10.75, NOW(), NOW());
  ELSE
    UPDATE products SET price = 10.75, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Squeegee sponge refill
  SELECT id INTO v_product_id FROM products WHERE name = 'Squeegee sponge refill' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Squeegee sponge refill', 'box', 'unit', 1, 12.99, NOW(), NOW());
  ELSE
    UPDATE products SET price = 12.99, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Swiffer
  SELECT id INTO v_product_id FROM products WHERE name = 'Swiffer' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Swiffer', 'box', 'unit', 1, 16.98, NOW(), NOW());
  ELSE
    UPDATE products SET price = 16.98, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Fantastik
  SELECT id INTO v_product_id FROM products WHERE name = 'Fantastik' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Fantastik', 'box', 'unit', 1, 14.48, NOW(), NOW());
  ELSE
    UPDATE products SET price = 14.48, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Vim spray
  SELECT id INTO v_product_id FROM products WHERE name = 'Vim spray' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Vim spray', 'box', 'unit', 1, 7.64, NOW(), NOW());
  ELSE
    UPDATE products SET price = 7.64, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Zep purple degreaser
  SELECT id INTO v_product_id FROM products WHERE name = 'Zep purple degreaser' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Zep purple degreaser', 'box', 'unit', 1, 13.98, NOW(), NOW());
  ELSE
    UPDATE products SET price = 13.98, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Neutral Cleaner Safeblend
  SELECT id INTO v_product_id FROM products WHERE name = 'Neutral Cleaner Safeblend' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Neutral Cleaner Safeblend', 'box', 'unit', 1, 18.68, NOW(), NOW());
  ELSE
    UPDATE products SET price = 18.68, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Urinal screen
  SELECT id INTO v_product_id FROM products WHERE name = 'Urinal screen' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Urinal screen', 'box', 'unit', 1, 2.73, NOW(), NOW());
  ELSE
    UPDATE products SET price = 2.73, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Stainless Steel Cleaner
  SELECT id INTO v_product_id FROM products WHERE name = 'Stainless Steel Cleaner' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Stainless Steel Cleaner', 'box', 'unit', 1, 8.28, NOW(), NOW());
  ELSE
    UPDATE products SET price = 8.28, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Lysol All purpose
  SELECT id INTO v_product_id FROM products WHERE name = 'Lysol All purpose' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Lysol All purpose', 'box', 'unit', 1, 6.97, NOW(), NOW());
  ELSE
    UPDATE products SET price = 6.97, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Goo gone
  SELECT id INTO v_product_id FROM products WHERE name = 'Goo gone' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Goo gone', 'box', 'unit', 1, 16.98, NOW(), NOW());
  ELSE
    UPDATE products SET price = 16.98, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Soft shine liquid
  SELECT id INTO v_product_id FROM products WHERE name = 'Soft shine liquid' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Soft shine liquid', 'box', 'unit', 1, 6.30, NOW(), NOW());
  ELSE
    UPDATE products SET price = 6.30, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Vim cream
  SELECT id INTO v_product_id FROM products WHERE name = 'Vim cream' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Vim cream', 'box', 'unit', 1, 6.87, NOW(), NOW());
  ELSE
    UPDATE products SET price = 6.87, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Dawn dish washer liquid soap
  SELECT id INTO v_product_id FROM products WHERE name = 'Dawn dish washer liquid soap' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Dawn dish washer liquid soap', 'box', 'unit', 1, 34.99, NOW(), NOW());
  ELSE
    UPDATE products SET price = 34.99, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Mop head Costco
  SELECT id INTO v_product_id FROM products WHERE name = 'Mop head Costco' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Mop head Costco', 'box', 'unit', 1, 8.98, NOW(), NOW());
  ELSE
    UPDATE products SET price = 8.98, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Tide Laundry Detergent
  SELECT id INTO v_product_id FROM products WHERE name = 'Tide Laundry Detergent' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Tide Laundry Detergent', 'box', 'unit', 1, 28.98, NOW(), NOW());
  ELSE
    UPDATE products SET price = 28.98, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Downy Laundry
  SELECT id INTO v_product_id FROM products WHERE name = 'Downy Laundry' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Downy Laundry', 'box', 'unit', 1, 15.98, NOW(), NOW());
  ELSE
    UPDATE products SET price = 15.98, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Palmolive Dish Liquid
  SELECT id INTO v_product_id FROM products WHERE name = 'Palmolive Dish Liquid' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Palmolive Dish Liquid', 'box', 'unit', 1, 10.99, NOW(), NOW());
  ELSE
    UPDATE products SET price = 10.99, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Cascade Roll towel Costco
  SELECT id INTO v_product_id FROM products WHERE name = 'Cascade Roll towel Costco' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Cascade Roll towel Costco', 'box', 'unit', 1, 15.99, NOW(), NOW());
  ELSE
    UPDATE products SET price = 15.99, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Vacuum Bag 3-4.5 gallon
  SELECT id INTO v_product_id FROM products WHERE name = 'Vacuum Bag 3-4.5 gallon' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Vacuum Bag 3-4.5 gallon', 'box', 'unit', 1, 26.34, NOW(), NOW());
  ELSE
    UPDATE products SET price = 26.34, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Vacuum Bag 5-10 gallon
  SELECT id INTO v_product_id FROM products WHERE name = 'Vacuum Bag 5-10 gallon' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Vacuum Bag 5-10 gallon', 'box', 'unit', 1, 32.99, NOW(), NOW());
  ELSE
    UPDATE products SET price = 32.99, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Vacuum Bag 12-16 gallon
  SELECT id INTO v_product_id FROM products WHERE name = 'Vacuum Bag 12-16 gallon' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Vacuum Bag 12-16 gallon', 'box', 'unit', 1, 39.03, NOW(), NOW());
  ELSE
    UPDATE products SET price = 39.03, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Hygiene sanitary bags
  SELECT id INTO v_product_id FROM products WHERE name = 'Hygiene sanitary bags' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Hygiene sanitary bags', 'box', 'unit', 1, 25.89, NOW(), NOW());
  ELSE
    UPDATE products SET price = 25.89, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Paper towel Kirkland
  SELECT id INTO v_product_id FROM products WHERE name = 'Paper towel Kirkland' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Paper towel Kirkland', 'box', 'unit', 1, 26.99, NOW(), NOW());
  ELSE
    UPDATE products SET price = 26.99, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Swiffer duster
  SELECT id INTO v_product_id FROM products WHERE name = 'Swiffer duster' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Swiffer duster', 'box', 'unit', 1, 26.99, NOW(), NOW());
  ELSE
    UPDATE products SET price = 26.99, updated_at = NOW() WHERE id = v_product_id;
  END IF;

  -- Product: Mop bucket
  SELECT id INTO v_product_id FROM products WHERE name = 'Mop bucket' LIMIT 1;
  IF v_product_id IS NULL THEN
    INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
    VALUES ('Mop bucket', 'box', 'unit', 1, 43.99, NOW(), NOW());
  ELSE
    UPDATE products SET price = 43.99, updated_at = NOW() WHERE id = v_product_id;
  END IF;

END $$;

-- ============================================
-- STEP 2: Sites
-- ============================================
DO $$
DECLARE
  v_site_id UUID;
BEGIN
  -- Site: Chef's Hall
  SELECT id INTO v_site_id FROM sites WHERE name = 'Chef''s Hall' LIMIT 1;
  IF v_site_id IS NULL THEN
    INSERT INTO sites (name, address, is_master, created_at, updated_at)
    VALUES ('Chef''s Hall', NULL, false, NOW(), NOW());
  ELSE
    UPDATE sites SET address = COALESCE(NULL, sites.address), updated_at = NOW() WHERE id = v_site_id;
  END IF;

  -- Site: HHR Law
  SELECT id INTO v_site_id FROM sites WHERE name = 'HHR Law' LIMIT 1;
  IF v_site_id IS NULL THEN
    INSERT INTO sites (name, address, is_master, created_at, updated_at)
    VALUES ('HHR Law', '235 King St E', false, NOW(), NOW());
  ELSE
    UPDATE sites SET address = COALESCE('235 King St E', sites.address), updated_at = NOW() WHERE id = v_site_id;
  END IF;

  -- Site: Little Canada
  SELECT id INTO v_site_id FROM sites WHERE name = 'Little Canada' LIMIT 1;
  IF v_site_id IS NULL THEN
    INSERT INTO sites (name, address, is_master, created_at, updated_at)
    VALUES ('Little Canada', '10 Dundas St E', false, NOW(), NOW());
  ELSE
    UPDATE sites SET address = COALESCE('10 Dundas St E', sites.address), updated_at = NOW() WHERE id = v_site_id;
  END IF;

  -- Site: No Vacancy
  SELECT id INTO v_site_id FROM sites WHERE name = 'No Vacancy' LIMIT 1;
  IF v_site_id IS NULL THEN
    INSERT INTO sites (name, address, is_master, created_at, updated_at)
    VALUES ('No Vacancy', '74 Ossington Ave', false, NOW(), NOW());
  ELSE
    UPDATE sites SET address = COALESCE('74 Ossington Ave', sites.address), updated_at = NOW() WHERE id = v_site_id;
  END IF;

  -- Site: Polytarp
  SELECT id INTO v_site_id FROM sites WHERE name = 'Polytarp' LIMIT 1;
  IF v_site_id IS NULL THEN
    INSERT INTO sites (name, address, is_master, created_at, updated_at)
    VALUES ('Polytarp', '350 Wildcat Rd', false, NOW(), NOW());
  ELSE
    UPDATE sites SET address = COALESCE('350 Wildcat Rd', sites.address), updated_at = NOW() WHERE id = v_site_id;
  END IF;

  -- Site: Pos Construction
  SELECT id INTO v_site_id FROM sites WHERE name = 'Pos Construction' LIMIT 1;
  IF v_site_id IS NULL THEN
    INSERT INTO sites (name, address, is_master, created_at, updated_at)
    VALUES ('Pos Construction', NULL, false, NOW(), NOW());
  ELSE
    UPDATE sites SET address = COALESCE(NULL, sites.address), updated_at = NOW() WHERE id = v_site_id;
  END IF;

  -- Site: Vena Solutions
  SELECT id INTO v_site_id FROM sites WHERE name = 'Vena Solutions' LIMIT 1;
  IF v_site_id IS NULL THEN
    INSERT INTO sites (name, address, is_master, created_at, updated_at)
    VALUES ('Vena Solutions', '2 Fraser Ave', false, NOW(), NOW());
  ELSE
    UPDATE sites SET address = COALESCE('2 Fraser Ave', sites.address), updated_at = NOW() WHERE id = v_site_id;
  END IF;

  -- Site: WealthSimple
  SELECT id INTO v_site_id FROM sites WHERE name = 'WealthSimple' LIMIT 1;
  IF v_site_id IS NULL THEN
    INSERT INTO sites (name, address, is_master, created_at, updated_at)
    VALUES ('WealthSimple', '80 Spadina Ave', false, NOW(), NOW());
  ELSE
    UPDATE sites SET address = COALESCE('80 Spadina Ave', sites.address), updated_at = NOW() WHERE id = v_site_id;
  END IF;

  -- Site: Wilcox
  SELECT id INTO v_site_id FROM sites WHERE name = 'Wilcox' LIMIT 1;
  IF v_site_id IS NULL THEN
    INSERT INTO sites (name, address, is_master, created_at, updated_at)
    VALUES ('Wilcox', '30 Eglinton Ave W', false, NOW(), NOW());
  ELSE
    UPDATE sites SET address = COALESCE('30 Eglinton Ave W', sites.address), updated_at = NOW() WHERE id = v_site_id;
  END IF;

  -- Site: Sana
  SELECT id INTO v_site_id FROM sites WHERE name = 'Sana' LIMIT 1;
  IF v_site_id IS NULL THEN
    INSERT INTO sites (name, address, is_master, created_at, updated_at)
    VALUES ('Sana', NULL, false, NOW(), NOW());
  ELSE
    UPDATE sites SET address = COALESCE(NULL, sites.address), updated_at = NOW() WHERE id = v_site_id;
  END IF;

END $$;

-- ============================================
-- STEP 3: Inventory
-- ============================================
DO $$
DECLARE
  v_product_id UUID;
  v_site_id UUID;
BEGIN
  -- Garbage Bag 35x50 CLEAR -> Little Canada: 3 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 35x50 CLEAR' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Little Canada' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Garbage Bag 35x50 CLEAR -> Vena: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 35x50 CLEAR' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Vena' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Garbage Bag 35x50 CLEAR -> WealthSimple: 5 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 35x50 CLEAR' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'WealthSimple' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 5, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Garbage Bag 35x50 CLEAR -> General: 5 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 35x50 CLEAR' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 5, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Garbage Bag 35x50 BLACK -> Little Canada: 5 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 35x50 BLACK' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Little Canada' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 5, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Garbage Bag 35x50 BLACK -> Vena: 3 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 35x50 BLACK' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Vena' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Garbage Bag 35x50 BLACK -> WealthSimple: 4 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 35x50 BLACK' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'WealthSimple' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Garbage Bag 35x50 BLACK -> General: 5 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 35x50 BLACK' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 5, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Garbage Bag 30x38 CLEAR -> HHR Law: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 30x38 CLEAR' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'HHR Law' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Garbage Bag 30x38 CLEAR -> Little Canada: 4 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 30x38 CLEAR' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Little Canada' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Garbage Bag 30x38 CLEAR -> Vena: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 30x38 CLEAR' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Vena' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Garbage Bag 30x38 CLEAR -> WealthSimple: 9 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 30x38 CLEAR' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'WealthSimple' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 9, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Garbage Bag 30x38 CLEAR -> General: 6 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 30x38 CLEAR' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 6, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Garbage Bag 30x38 BLACK -> HHR Law: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 30x38 BLACK' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'HHR Law' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Garbage Bag 30x38 BLACK -> Little Canada: 4 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 30x38 BLACK' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Little Canada' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Garbage Bag 30x38 BLACK -> No Vacancy: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 30x38 BLACK' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'No Vacancy' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Garbage Bag 30x38 BLACK -> Vena: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 30x38 BLACK' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Vena' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Garbage Bag 30x38 BLACK -> WealthSimple: 6 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 30x38 BLACK' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'WealthSimple' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 6, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Garbage Bag 30x38 BLACK -> General: 12 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 30x38 BLACK' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 12, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Garbage Bag 24x22 CLEAR -> HHR Law: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 24x22 CLEAR' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'HHR Law' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Garbage Bag 24x22 CLEAR -> Little Canada: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 24x22 CLEAR' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Little Canada' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Garbage Bag 24x22 CLEAR -> Vena: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 24x22 CLEAR' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Vena' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Garbage Bag 24x22 CLEAR -> WealthSimple: 7 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 24x22 CLEAR' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'WealthSimple' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 7, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Garbage Bag 24x22 CLEAR -> General: 5 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 24x22 CLEAR' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 5, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Garbage Bag 24x22 BLACK -> HHR Law: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 24x22 BLACK' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'HHR Law' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Garbage Bag 24x22 BLACK -> Little Canada: 3 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 24x22 BLACK' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Little Canada' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Garbage Bag 24x22 BLACK -> Vena: 4 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 24x22 BLACK' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Vena' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Garbage Bag 24x22 BLACK -> WealthSimple: 5 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 24x22 BLACK' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'WealthSimple' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 5, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Garbage Bag 24x22 BLACK -> General: 9 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 24x22 BLACK' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 9, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Paper Towel Multifold -> HHR Law: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Paper Towel Multifold' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'HHR Law' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Paper Towel Multifold -> Little Canada: 11 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Paper Towel Multifold' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Little Canada' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 11, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Paper Towel Multifold -> Vena: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Paper Towel Multifold' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Vena' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Paper Towel Multifold -> WealthSimple: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Paper Towel Multifold' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'WealthSimple' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Paper Towel Multifold -> Wilcox: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Paper Towel Multifold' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Wilcox' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Paper Towel Multifold -> General: 8 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Paper Towel Multifold' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 8, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Paper Towel Singlefold -> Little Canada: 6 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Paper Towel Singlefold' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Little Canada' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 6, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Toilet Paper Jumbo -> Little Canada: 11 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Toilet Paper Jumbo' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Little Canada' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 11, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Toilet Paper Jumbo -> Vena: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Toilet Paper Jumbo' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Vena' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Toilet Paper Regular -> Vena: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Toilet Paper Regular' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Vena' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Toilet Paper Regular -> WealthSimple: 7 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Toilet Paper Regular' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'WealthSimple' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 7, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Toilet Paper Regular -> General: 10 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Toilet Paper Regular' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 10, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Toilet Paper Sierra -> WealthSimple: 5 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Toilet Paper Sierra' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'WealthSimple' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 5, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Toilet Paper Sierra -> General: 3 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Toilet Paper Sierra' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Pine Sol -> Chef's Hall: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Pine Sol' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Chef''s Hall' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Pine Sol -> HHR Law: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Pine Sol' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'HHR Law' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Pine Sol -> Little Canada: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Pine Sol' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Little Canada' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Pine Sol -> No Vacancy: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Pine Sol' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'No Vacancy' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Pine Sol -> Polytarp: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Pine Sol' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Polytarp' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Pine Sol -> Vena: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Pine Sol' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Vena' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Pine Sol -> WealthSimple: 4 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Pine Sol' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'WealthSimple' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Pine Sol -> Wilcox: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Pine Sol' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Wilcox' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Mr Clean -> Polytarp: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Mr Clean' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Polytarp' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Mr Clean -> Wilcox: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Mr Clean' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Wilcox' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Mr Clean -> General: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Mr Clean' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- StrongArm -> WealthSimple: 3 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'StrongArm' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'WealthSimple' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- StrongArm -> General: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'StrongArm' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Windex -> Chef's Hall: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Windex' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Chef''s Hall' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Windex -> No Vacancy: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Windex' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'No Vacancy' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Windex -> Polytarp: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Windex' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Polytarp' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Windex -> Vena: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Windex' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Vena' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Windex -> WealthSimple: 6 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Windex' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'WealthSimple' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 6, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Windex -> Wilcox: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Windex' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Wilcox' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Windex -> General: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Windex' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Deep Blue -> Little Canada: 4 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Deep Blue' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Little Canada' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Deep Blue -> Vena: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Deep Blue' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Vena' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Daily desinfectant -> Little Canada: 8 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Daily desinfectant' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Little Canada' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 8, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Daily desinfectant -> Vena: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Daily desinfectant' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Vena' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Ph7 Ultra -> Little Canada: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Ph7 Ultra' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Little Canada' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Ph7 Ultra -> Vena: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Ph7 Ultra' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Vena' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Kool Splash Aloe Vera Foaming Soap -> Chef's Hall: 3 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Kool Splash Aloe Vera Foaming Soap' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Chef''s Hall' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Kool Splash Aloe Vera Foaming Soap -> Little Canada: 5 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Kool Splash Aloe Vera Foaming Soap' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Little Canada' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 5, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Kool Splash Aloe Vera Foaming Soap -> No Vacancy: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Kool Splash Aloe Vera Foaming Soap' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'No Vacancy' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Kool Splash Aloe Vera Foaming Soap -> Vena: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Kool Splash Aloe Vera Foaming Soap' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Vena' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Kool Splash Aloe Vera Foaming Soap -> General: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Kool Splash Aloe Vera Foaming Soap' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Toilet bowl -> Chef's Hall: 4 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Toilet bowl' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Chef''s Hall' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Toilet bowl -> HHR Law: 4 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Toilet bowl' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'HHR Law' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Toilet bowl -> Little Canada: 7 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Toilet bowl' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Little Canada' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 7, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Toilet bowl -> No Vacancy: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Toilet bowl' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'No Vacancy' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Toilet bowl -> Polytarp: 6 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Toilet bowl' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Polytarp' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 6, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Toilet bowl -> Vena: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Toilet bowl' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Vena' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Toilet bowl -> WealthSimple: 7 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Toilet bowl' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'WealthSimple' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 7, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Toilet bowl -> Wilcox: 3 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Toilet bowl' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Wilcox' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Toilet bowl -> General: 12 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Toilet bowl' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 12, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Mop head (boxes) -> Chef's Hall: 4 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Chef''s Hall' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Mop head (boxes) -> HHR Law: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'HHR Law' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Mop head (boxes) -> Little Canada: 4 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Little Canada' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Mop head (boxes) -> No Vacancy: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'No Vacancy' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Mop head (boxes) -> Polytarp: 5 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Polytarp' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 5, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Mop head (boxes) -> Vena: 4 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Vena' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Mop head (boxes) -> WealthSimple: 24 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'WealthSimple' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 24, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Mop head (boxes) -> Wilcox: 3 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Wilcox' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Mop head (boxes) -> General: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Gloves Small -> Little Canada: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Small' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Little Canada' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Gloves Medium -> Little Canada: 12 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Medium' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Little Canada' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 12, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Gloves Medium -> No Vacancy: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Medium' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'No Vacancy' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Gloves Medium -> Polytarp: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Medium' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Polytarp' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Gloves Medium -> Vena: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Medium' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Vena' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Gloves Medium -> WealthSimple: 17 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Medium' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'WealthSimple' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 17, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Gloves Medium -> Wilcox: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Medium' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Wilcox' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Gloves Medium -> General: 13 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Medium' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 13, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Gloves Large -> Chef's Hall: 3 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Large' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Chef''s Hall' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Gloves Large -> HHR Law: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Large' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'HHR Law' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Gloves Large -> Little Canada: 12 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Large' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Little Canada' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 12, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Gloves Large -> No Vacancy: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Large' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'No Vacancy' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Gloves Large -> Polytarp: 4 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Large' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Polytarp' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Gloves Large -> Vena: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Large' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Vena' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Gloves Large -> WealthSimple: 18 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Large' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'WealthSimple' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 18, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Gloves Large -> Wilcox: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Large' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Wilcox' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Gloves Large -> General: 13 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Large' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 13, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Gloves X-Large -> HHR Law: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves X-Large' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'HHR Law' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Gloves X-Large -> Little Canada: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves X-Large' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Little Canada' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Gloves X-Large -> No Vacancy: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves X-Large' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'No Vacancy' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Gloves X-Large -> WealthSimple: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves X-Large' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'WealthSimple' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Gloves X-Large -> Wilcox: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves X-Large' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Wilcox' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Gloves X-Large -> General: 4 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves X-Large' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Febreeze air freshener -> Chef's Hall: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Febreeze air freshener' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Chef''s Hall' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Febreeze air freshener -> HHR Law: 8 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Febreeze air freshener' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'HHR Law' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 8, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Febreeze air freshener -> Little Canada: 4 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Febreeze air freshener' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Little Canada' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Febreeze air freshener -> Polytarp: 6 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Febreeze air freshener' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Polytarp' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 6, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Febreeze air freshener -> Wilcox: 4 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Febreeze air freshener' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Wilcox' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Febreeze air freshener -> General: 14 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Febreeze air freshener' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 14, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Maxithins Pads -> Little Canada: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Maxithins Pads' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Little Canada' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Tampax -> Little Canada: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Tampax' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Little Canada' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Cloth -> HHR Law: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Cloth' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'HHR Law' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Cloth -> Little Canada: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Cloth' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Little Canada' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Cloth -> Vena: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Cloth' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Vena' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Cloth -> General: 3 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Cloth' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Squeegee sponge refill -> General: 4 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Squeegee sponge refill' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Swiffer -> General: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Swiffer' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Fantastik -> Chef's Hall: 4 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Fantastik' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Chef''s Hall' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Fantastik -> No Vacancy: 4 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Fantastik' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'No Vacancy' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Fantastik -> General: 4 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Fantastik' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Vim spray -> Chef's Hall: 5 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Vim spray' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Chef''s Hall' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 5, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Vim spray -> HHR Law: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Vim spray' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'HHR Law' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Vim spray -> Vena: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Vim spray' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Vena' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Zep purple degreaser -> Chef's Hall: 4 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Zep purple degreaser' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Chef''s Hall' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Zep purple degreaser -> No Vacancy: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Zep purple degreaser' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'No Vacancy' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Zep purple degreaser -> Wilcox: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Zep purple degreaser' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Wilcox' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Zep purple degreaser -> General: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Zep purple degreaser' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Neutral Cleaner Safeblend -> HHR Law: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Neutral Cleaner Safeblend' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'HHR Law' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Urinal screen -> Little Canada: 4 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Urinal screen' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Little Canada' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Urinal screen -> Wilcox: 5 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Urinal screen' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Wilcox' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 5, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Urinal screen -> General: 18 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Urinal screen' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 18, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Stainless Steel Cleaner -> Little Canada: 3 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Stainless Steel Cleaner' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Little Canada' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Stainless Steel Cleaner -> Vena: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Stainless Steel Cleaner' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Vena' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Stainless Steel Cleaner -> Wilcox: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Stainless Steel Cleaner' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Wilcox' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Stainless Steel Cleaner -> General: 3 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Stainless Steel Cleaner' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Lysol All purpose -> Wilcox: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Lysol All purpose' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Wilcox' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Lysol All purpose -> General: 6 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Lysol All purpose' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 6, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Goo gone -> Chef's Hall: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Goo gone' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Chef''s Hall' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Goo gone -> Vena: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Goo gone' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Vena' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Soft shine liquid -> Chef's Hall: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Soft shine liquid' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Chef''s Hall' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Soft shine liquid -> Little Canada: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Soft shine liquid' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Little Canada' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Vim cream -> Chef's Hall: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Vim cream' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Chef''s Hall' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Vim cream -> HHR Law: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Vim cream' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'HHR Law' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Vim cream -> Little Canada: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Vim cream' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Little Canada' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Vim cream -> Vena: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Vim cream' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Vena' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Vim cream -> General: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Vim cream' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Dawn dish washer liquid soap -> General: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Dawn dish washer liquid soap' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Mop head Costco -> General: 5 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Mop head Costco' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 5, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Tide Laundry Detergent -> WealthSimple: 3 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Tide Laundry Detergent' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'WealthSimple' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Tide Laundry Detergent -> General: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Tide Laundry Detergent' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Downy Laundry -> WealthSimple: 3 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Downy Laundry' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'WealthSimple' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Downy Laundry -> General: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Downy Laundry' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Palmolive Dish Liquid -> WealthSimple: 8 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Palmolive Dish Liquid' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'WealthSimple' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 8, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Palmolive Dish Liquid -> General: 3 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Palmolive Dish Liquid' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Cascade Roll towel Costco -> Vena: 2 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Cascade Roll towel Costco' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'Vena' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

  -- Cascade Roll towel Costco -> General: 1 boxes
  SELECT id INTO v_product_id FROM products WHERE name = 'Cascade Roll towel Costco' LIMIT 1;
  SELECT id INTO v_site_id FROM sites WHERE name = 'General' LIMIT 1;
  IF v_product_id IS NOT NULL AND v_site_id IS NOT NULL THEN
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = EXCLUDED.quantity_packages,
      quantity_loose_units = 0,
      last_updated = NOW();
  END IF;

END $$;

-- ============================================
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

  -- Purchase Request: Polytarp - 9/1/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'Polytarp' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'approved', '2025-09-02T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Pine Sol - 2 @ $ 13.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Pine Sol' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 13.99, v_site_id);
    END IF;

    -- Item: Mr Clean - 2 @ $ 14.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Mr Clean' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 14.99, v_site_id);
    END IF;

    -- Item: Windex - 2 @ $ 22.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Windex' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 22.99, v_site_id);
    END IF;

    -- Item: Toilet bowl - 6 @ $ 14.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Toilet bowl' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 6, 14.99, v_site_id);
    END IF;

    -- Item: Gloves Medium - 2 @ $ 10.50
    SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Medium' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 10.50, v_site_id);
    END IF;

    -- Item: Gloves Large - 2 @ $ 10.50
    SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Large' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 10.50, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: WealthSimple - 9/2/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'WealthSimple' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'approved', '2025-09-03T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Paper Towel Multifold - 5 @ $ 39.98
    SELECT id INTO v_product_id FROM products WHERE name = 'Paper Towel Multifold' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 5, 39.98, v_site_id);
    END IF;

    -- Item: Windex - 3 @ $ 22.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Windex' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 3, 22.99, v_site_id);
    END IF;

    -- Item: Toilet bowl - 8 @ $ 14.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Toilet bowl' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 8, 14.99, v_site_id);
    END IF;

    -- Item: Gloves Medium - 12 @ $ 10.50
    SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Medium' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 12, 10.50, v_site_id);
    END IF;

    -- Item: Gloves Large - 10 @ $ 10.50
    SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Large' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 10, 10.50, v_site_id);
    END IF;

    -- Item: Gloves X-Large - 5 @ $ 10.50
    SELECT id INTO v_product_id FROM products WHERE name = 'Gloves X-Large' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 5, 10.50, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: Pos Construction - 9/8/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'Pos Construction' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'approved', '2025-09-09T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Cloth - 8 @ $ 10.75
    SELECT id INTO v_product_id FROM products WHERE name = 'Cloth' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 8, 10.75, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: Chef's Hall - 9/9/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'Chef''s Hall' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'draft', '2025-09-10T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Fantastik - 4 @ $ 14.48
    SELECT id INTO v_product_id FROM products WHERE name = 'Fantastik' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 4, 14.48, v_site_id);
    END IF;

    -- Item: Mop head (boxes) - 4 @ $ 6.88
    SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 4, 6.88, v_site_id);
    END IF;

    -- Item: Zep purple degreaser - 1 @ $ 13.98
    SELECT id INTO v_product_id FROM products WHERE name = 'Zep purple degreaser' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 13.98, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: HHR Law - 9/9/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'HHR Law' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'approved', '2025-09-10T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Toilet bowl - 1 @ $ 14.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Toilet bowl' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 14.99, v_site_id);
    END IF;

    -- Item: Gloves Large - 2 @ $ 10.50
    SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Large' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 10.50, v_site_id);
    END IF;

    -- Item: Febreeze air freshener - 1 @ $ 18.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Febreeze air freshener' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 18.99, v_site_id);
    END IF;

    -- Item: Garbage Bag 30x38 BLACK - 2 @ $ 24.22
    SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 30x38 BLACK' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 24.22, v_site_id);
    END IF;

    -- Item: Paper Towel Multifold - 3 @ $ 39.98
    SELECT id INTO v_product_id FROM products WHERE name = 'Paper Towel Multifold' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 3, 39.98, v_site_id);
    END IF;

    -- Item: Vim spray - 3 @ $ 7.64
    SELECT id INTO v_product_id FROM products WHERE name = 'Vim spray' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 3, 7.64, v_site_id);
    END IF;

    -- Item: Garbage Bag 30x38 CLEAR - 1 @ $ 30.23
    SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 30x38 CLEAR' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 30.23, v_site_id);
    END IF;

    -- Item: Mop head (boxes) - 1 @ $ 6.88
    SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 6.88, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: No Vacancy - 9/9/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'No Vacancy' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'draft', '2025-09-10T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Fantastik - 4 @ $ 14.48
    SELECT id INTO v_product_id FROM products WHERE name = 'Fantastik' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 4, 14.48, v_site_id);
    END IF;

    -- Item: Mop head (boxes) - 4 @ $ 6.88
    SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 4, 6.88, v_site_id);
    END IF;

    -- Item: Zep purple degreaser - 2 @ $ 13.98
    SELECT id INTO v_product_id FROM products WHERE name = 'Zep purple degreaser' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 13.98, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: Vena Solutions - 9/9/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'Vena Solutions' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'draft', '2025-09-10T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Garbage Bag 24x22 CLEAR - 1 @ $ 28.59
    SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 24x22 CLEAR' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 28.59, v_site_id);
    END IF;

    -- Item: Toilet Paper Jumbo - 2 @ $ 44.97
    SELECT id INTO v_product_id FROM products WHERE name = 'Toilet Paper Jumbo' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 44.97, v_site_id);
    END IF;

    -- Item: Gloves Medium - 2 @ $ 10.50
    SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Medium' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 10.50, v_site_id);
    END IF;

    -- Item: Gloves Large - 2 @ $ 10.50
    SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Large' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 10.50, v_site_id);
    END IF;

    -- Item: Vim spray - 2 @ $ 7.64
    SELECT id INTO v_product_id FROM products WHERE name = 'Vim spray' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 7.64, v_site_id);
    END IF;

    -- Item: Garbage Bag 30x38 BLACK - 1 @ $ 24.22
    SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 30x38 BLACK' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 24.22, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: Wilcox - 9/9/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'Wilcox' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'approved', '2025-09-10T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Lysol All purpose - 2 @ $ 6.97
    SELECT id INTO v_product_id FROM products WHERE name = 'Lysol All purpose' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 6.97, v_site_id);
    END IF;

    -- Item: Windex - 1 @ $ 22.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Windex' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 22.99, v_site_id);
    END IF;

    -- Item: Paper Towel Multifold - 2 @ $ 39.98
    SELECT id INTO v_product_id FROM products WHERE name = 'Paper Towel Multifold' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 39.98, v_site_id);
    END IF;

    -- Item: Pine Sol - 2 @ $ 13.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Pine Sol' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 13.99, v_site_id);
    END IF;

    -- Item: Zep purple degreaser - 2 @ $ 13.98
    SELECT id INTO v_product_id FROM products WHERE name = 'Zep purple degreaser' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 13.98, v_site_id);
    END IF;

    -- Item: Stainless Steel Cleaner - 2 @ $ 8.28
    SELECT id INTO v_product_id FROM products WHERE name = 'Stainless Steel Cleaner' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 8.28, v_site_id);
    END IF;

    -- Item: Gloves Medium - 1 @ $ 10.50
    SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Medium' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 10.50, v_site_id);
    END IF;

    -- Item: Gloves Large - 1 @ $ 10.50
    SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Large' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 10.50, v_site_id);
    END IF;

    -- Item: Mop head (boxes) - 1 @ $ 6.88
    SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 6.88, v_site_id);
    END IF;

    -- Item: Febreeze air freshener - 3 @ $ 18.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Febreeze air freshener' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 3, 18.99, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: WealthSimple - 9/13/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'WealthSimple' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'approved', '2025-09-14T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Palmolive Dish Liquid - 8 @ $ 10.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Palmolive Dish Liquid' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 8, 10.99, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: WealthSimple - 9/21/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'WealthSimple' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'approved', '2025-09-22T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Tide Laundry Detergent - 3 @ $ 28.98
    SELECT id INTO v_product_id FROM products WHERE name = 'Tide Laundry Detergent' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 3, 28.98, v_site_id);
    END IF;

    -- Item: Downy Laundry - 3 @ $ 15.98
    SELECT id INTO v_product_id FROM products WHERE name = 'Downy Laundry' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 3, 15.98, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: Chef's Hall - 9/22/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'Chef''s Hall' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'approved', '2025-09-23T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Dawn dish washer liquid soap - 2 @ $ 34.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Dawn dish washer liquid soap' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 34.99, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: No Vacancy - 9/22/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'No Vacancy' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'approved', '2025-09-23T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Dawn dish washer liquid soap - 2 @ $ 34.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Dawn dish washer liquid soap' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 34.99, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: WealthSimple - 9/23/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'WealthSimple' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'approved', '2025-09-24T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Mop head Costco - 6 @ $ 8.98
    SELECT id INTO v_product_id FROM products WHERE name = 'Mop head Costco' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 6, 8.98, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: Little Canada - 9/25/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'Little Canada' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'approved', '2025-09-26T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Paper Towel Singlefold - 3 @ $ 39.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Paper Towel Singlefold' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 3, 39.99, v_site_id);
    END IF;

    -- Item: Paper Towel Multifold - 6 @ $ 39.98
    SELECT id INTO v_product_id FROM products WHERE name = 'Paper Towel Multifold' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 6, 39.98, v_site_id);
    END IF;

    -- Item: Mop head (boxes) - 2 @ $ 6.88
    SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 6.88, v_site_id);
    END IF;

    -- Item: Garbage Bag 35x50 BLACK - 3 @ $ 37.24
    SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 35x50 BLACK' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 3, 37.24, v_site_id);
    END IF;

    -- Item: Garbage Bag 30x38 BLACK - 3 @ $ 24.22
    SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 30x38 BLACK' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 3, 24.22, v_site_id);
    END IF;

    -- Item: Toilet Paper Jumbo - 5 @ $ 44.97
    SELECT id INTO v_product_id FROM products WHERE name = 'Toilet Paper Jumbo' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 5, 44.97, v_site_id);
    END IF;

    -- Item: Stainless Steel Cleaner - 3 @ $ 8.28
    SELECT id INTO v_product_id FROM products WHERE name = 'Stainless Steel Cleaner' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 3, 8.28, v_site_id);
    END IF;

    -- Item: Gloves Medium - 10 @ $ 10.50
    SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Medium' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 10, 10.50, v_site_id);
    END IF;

    -- Item: Gloves Large - 10 @ $ 10.50
    SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Large' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 10, 10.50, v_site_id);
    END IF;

    -- Item: Cloth - 1 @ $ 10.75
    SELECT id INTO v_product_id FROM products WHERE name = 'Cloth' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 10.75, v_site_id);
    END IF;

    -- Item: Kool Splash Aloe Vera Foaming Soap - 4 @ $ 17.98
    SELECT id INTO v_product_id FROM products WHERE name = 'Kool Splash Aloe Vera Foaming Soap' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 4, 17.98, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: Vena Solutions - 9/25/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'Vena Solutions' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'submitted', '2025-09-26T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Cascade Roll towel Costco - 3 @ $ 15.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Cascade Roll towel Costco' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 3, 15.99, v_site_id);
    END IF;

    -- Item: Urinal screen - 1 @ $ 2.73
    SELECT id INTO v_product_id FROM products WHERE name = 'Urinal screen' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 2.73, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: Polytarp - 9/29/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'Polytarp' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'draft', '2025-09-30T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Pine Sol - 1 @ $ 13.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Pine Sol' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 13.99, v_site_id);
    END IF;

    -- Item: Mr Clean - 1 @ $ 14.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Mr Clean' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 14.99, v_site_id);
    END IF;

    -- Item: Windex - 1 @ $ 22.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Windex' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 22.99, v_site_id);
    END IF;

    -- Item: Toilet bowl - 4 @ $ 14.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Toilet bowl' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 4, 14.99, v_site_id);
    END IF;

    -- Item: Gloves Large - 4 @ $ 10.50
    SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Large' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 4, 10.50, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: HHR Law - 10/5/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'HHR Law' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'draft', '2025-10-06T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Garbage Bag 30x38 BLACK - 1 @ $ 24.22
    SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 30x38 BLACK' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 24.22, v_site_id);
    END IF;

    -- Item: Garbage Bag 24x22 CLEAR - 1 @ $ 28.59
    SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 24x22 CLEAR' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 28.59, v_site_id);
    END IF;

    -- Item: Gloves Large - 2 @ $ 10.50
    SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Large' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 10.50, v_site_id);
    END IF;

    -- Item: Stainless Steel Cleaner - 1 @ $ 8.28
    SELECT id INTO v_product_id FROM products WHERE name = 'Stainless Steel Cleaner' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 8.28, v_site_id);
    END IF;

    -- Item: Paper Towel Multifold - 1 @ $ 39.98
    SELECT id INTO v_product_id FROM products WHERE name = 'Paper Towel Multifold' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 39.98, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: Wilcox - 10/6/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'Wilcox' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'draft', '2025-10-07T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Windex - 1 @ $ 22.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Windex' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 22.99, v_site_id);
    END IF;

    -- Item: Pine Sol - 1 @ $ 13.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Pine Sol' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 13.99, v_site_id);
    END IF;

    -- Item: Zep purple degreaser - 1 @ $ 13.98
    SELECT id INTO v_product_id FROM products WHERE name = 'Zep purple degreaser' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 13.98, v_site_id);
    END IF;

    -- Item: Mr Clean - 1 @ $ 14.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Mr Clean' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 14.99, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: Chef's Hall - 10/7/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'Chef''s Hall' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'approved', '2025-10-08T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Fantastik - 4 @ $ 14.48
    SELECT id INTO v_product_id FROM products WHERE name = 'Fantastik' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 4, 14.48, v_site_id);
    END IF;

    -- Item: Dawn dish washer liquid soap - 1 @ $ 34.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Dawn dish washer liquid soap' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 34.99, v_site_id);
    END IF;

    -- Item: Zep purple degreaser - 1 @ $ 13.98
    SELECT id INTO v_product_id FROM products WHERE name = 'Zep purple degreaser' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 13.98, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: No Vacancy - 10/7/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'No Vacancy' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'approved', '2025-10-08T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Fantastik - 4 @ $ 14.48
    SELECT id INTO v_product_id FROM products WHERE name = 'Fantastik' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 4, 14.48, v_site_id);
    END IF;

    -- Item: Dawn dish washer liquid soap - 1 @ $ 34.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Dawn dish washer liquid soap' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 34.99, v_site_id);
    END IF;

    -- Item: Zep purple degreaser - 1 @ $ 13.98
    SELECT id INTO v_product_id FROM products WHERE name = 'Zep purple degreaser' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 13.98, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: Vena Solutions - 10/7/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'Vena Solutions' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'draft', '2025-10-08T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Mop head (boxes) - 1 @ $ 6.88
    SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 6.88, v_site_id);
    END IF;

    -- Item: Garbage Bag 30x38 CLEAR - 1 @ $ 30.23
    SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 30x38 CLEAR' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 30.23, v_site_id);
    END IF;

    -- Item: Toilet bowl - 2 @ $ 14.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Toilet bowl' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 14.99, v_site_id);
    END IF;

    -- Item: Pine Sol - 1 @ $ 13.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Pine Sol' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 13.99, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: Chef's Hall - 10/8/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'Chef''s Hall' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'submitted', '2025-10-09T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Urinal screen - 1 @ $ 2.73
    SELECT id INTO v_product_id FROM products WHERE name = 'Urinal screen' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 2.73, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: Chef's Hall - 10/15/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'Chef''s Hall' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'submitted', '2025-10-16T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Mop head (boxes) - 1 @ $ 6.88
    SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 6.88, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: No Vacancy - 10/15/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'No Vacancy' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'submitted', '2025-10-16T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Mop head (boxes) - 1 @ $ 6.88
    SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 6.88, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: Polytarp - 10/19/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'Polytarp' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'approved', '2025-10-20T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Pine Sol - 1 @ $ 13.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Pine Sol' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 13.99, v_site_id);
    END IF;

    -- Item: Toilet bowl - 3 @ $ 14.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Toilet bowl' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 3, 14.99, v_site_id);
    END IF;

    -- Item: Febreeze air freshener - 2 @ $ 18.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Febreeze air freshener' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 18.99, v_site_id);
    END IF;

    -- Item: Mr Clean - 1 @ $ 14.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Mr Clean' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 14.99, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: HHR Law - 11/9/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'HHR Law' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'approved', '2025-11-10T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Paper Towel Multifold - 1 @ $ 39.98
    SELECT id INTO v_product_id FROM products WHERE name = 'Paper Towel Multifold' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 39.98, v_site_id);
    END IF;

    -- Item: Toilet bowl - 4 @ $ 14.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Toilet bowl' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 4, 14.99, v_site_id);
    END IF;

    -- Item: Garbage Bag 30x38 BLACK - 1 @ $ 24.22
    SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 30x38 BLACK' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 24.22, v_site_id);
    END IF;

    -- Item: Gloves Large - 1 @ $ 10.50
    SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Large' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 10.50, v_site_id);
    END IF;

    -- Item: Cloth - 4 @ $ 10.75
    SELECT id INTO v_product_id FROM products WHERE name = 'Cloth' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 4, 10.75, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: Chef's Hall - 11/17/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'Chef''s Hall' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'approved', '2025-11-18T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Fantastik - 4 @ $ 14.48
    SELECT id INTO v_product_id FROM products WHERE name = 'Fantastik' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 4, 14.48, v_site_id);
    END IF;

    -- Item: Dawn dish washer liquid soap - 1 @ $ 34.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Dawn dish washer liquid soap' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 34.99, v_site_id);
    END IF;

    -- Item: Zep purple degreaser - 2 @ $ 13.98
    SELECT id INTO v_product_id FROM products WHERE name = 'Zep purple degreaser' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 13.98, v_site_id);
    END IF;

    -- Item: Mop head (boxes) - 4 @ $ 6.88
    SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 4, 6.88, v_site_id);
    END IF;

    -- Item: Vim spray - 4 @ $ 7.64
    SELECT id INTO v_product_id FROM products WHERE name = 'Vim spray' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 4, 7.64, v_site_id);
    END IF;

    -- Item: Gloves Large - 4 @ $ 10.50
    SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Large' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 4, 10.50, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: No Vacancy - 11/17/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'No Vacancy' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'approved', '2025-11-18T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Fantastik - 4 @ $ 14.48
    SELECT id INTO v_product_id FROM products WHERE name = 'Fantastik' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 4, 14.48, v_site_id);
    END IF;

    -- Item: Zep purple degreaser - 2 @ $ 13.98
    SELECT id INTO v_product_id FROM products WHERE name = 'Zep purple degreaser' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 13.98, v_site_id);
    END IF;

    -- Item: Mop head (boxes) - 4 @ $ 6.88
    SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 4, 6.88, v_site_id);
    END IF;

    -- Item: Vim spray - 1 @ $ 7.64
    SELECT id INTO v_product_id FROM products WHERE name = 'Vim spray' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 7.64, v_site_id);
    END IF;

    -- Item: Pine Sol - 1 @ $ 13.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Pine Sol' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 13.99, v_site_id);
    END IF;

    -- Item: Dawn dish washer liquid soap - 1 @ $ 34.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Dawn dish washer liquid soap' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 34.99, v_site_id);
    END IF;

    -- Item: Garbage Bag 30x38 BLACK - 1 @ $ 24.22
    SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 30x38 BLACK' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 24.22, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: Wilcox - 11/17/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'Wilcox' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'approved', '2025-11-18T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Pine Sol - 3 @ $ 13.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Pine Sol' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 3, 13.99, v_site_id);
    END IF;

    -- Item: Lysol All purpose - 3 @ $ 6.97
    SELECT id INTO v_product_id FROM products WHERE name = 'Lysol All purpose' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 3, 6.97, v_site_id);
    END IF;

    -- Item: Zep purple degreaser - 3 @ $ 13.98
    SELECT id INTO v_product_id FROM products WHERE name = 'Zep purple degreaser' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 3, 13.98, v_site_id);
    END IF;

    -- Item: Febreeze air freshener - 3 @ $ 18.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Febreeze air freshener' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 3, 18.99, v_site_id);
    END IF;

    -- Item: Stainless Steel Cleaner - 3 @ $ 8.28
    SELECT id INTO v_product_id FROM products WHERE name = 'Stainless Steel Cleaner' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 3, 8.28, v_site_id);
    END IF;

    -- Item: Windex - 1 @ $ 22.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Windex' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 22.99, v_site_id);
    END IF;

    -- Item: Mop head (boxes) - 5 @ $ 6.88
    SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 5, 6.88, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: Little Canada - 11/30/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'Little Canada' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'approved', '2025-12-01T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Garbage Bag 30x38 BLACK - 2 @ $ 24.22
    SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 30x38 BLACK' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 24.22, v_site_id);
    END IF;

    -- Item: Garbage Bag 35x50 BLACK - 2 @ $ 37.24
    SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 35x50 BLACK' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 37.24, v_site_id);
    END IF;

    -- Item: Garbage Bag 35x50 CLEAR - 2 @ $ 43.93
    SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 35x50 CLEAR' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 43.93, v_site_id);
    END IF;

    -- Item: Toilet Paper Jumbo - 8 @ $ 44.97
    SELECT id INTO v_product_id FROM products WHERE name = 'Toilet Paper Jumbo' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 8, 44.97, v_site_id);
    END IF;

    -- Item: Paper Towel Multifold - 7 @ $ 39.98
    SELECT id INTO v_product_id FROM products WHERE name = 'Paper Towel Multifold' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 7, 39.98, v_site_id);
    END IF;

    -- Item: Paper Towel Singlefold - 7 @ $ 39.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Paper Towel Singlefold' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 7, 39.99, v_site_id);
    END IF;

    -- Item: Mop head (boxes) - 1 @ $ 6.88
    SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 6.88, v_site_id);
    END IF;

    -- Item: Kool Splash Aloe Vera Foaming Soap - 1 @ $ 17.98
    SELECT id INTO v_product_id FROM products WHERE name = 'Kool Splash Aloe Vera Foaming Soap' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 17.98, v_site_id);
    END IF;

    -- Item: Urinal screen - 1 @ $ 2.73
    SELECT id INTO v_product_id FROM products WHERE name = 'Urinal screen' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 2.73, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: Wilcox - 12/3/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'Wilcox' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'approved', '2025-12-04T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Urinal screen - 5 @ $ 2.73
    SELECT id INTO v_product_id FROM products WHERE name = 'Urinal screen' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 5, 2.73, v_site_id);
    END IF;

    -- Item: Hygiene sanitary bags - 1 @ $ 25.89
    SELECT id INTO v_product_id FROM products WHERE name = 'Hygiene sanitary bags' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 25.89, v_site_id);
    END IF;

    -- Item: Febreeze air freshener - 4 @ $ 18.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Febreeze air freshener' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 4, 18.99, v_site_id);
    END IF;

    -- Item: Gloves Medium - 2 @ $ 10.50
    SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Medium' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 10.50, v_site_id);
    END IF;

    -- Item: Gloves Large - 2 @ $ 10.50
    SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Large' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 10.50, v_site_id);
    END IF;

    -- Item: Zep purple degreaser - 2 @ $ 13.98
    SELECT id INTO v_product_id FROM products WHERE name = 'Zep purple degreaser' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 13.98, v_site_id);
    END IF;

    -- Item: Mop head (boxes) - 3 @ $ 6.88
    SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 3, 6.88, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: HHR Law - 12/3/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'HHR Law' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'approved', '2025-12-04T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Febreeze air freshener - 4 @ $ 18.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Febreeze air freshener' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 4, 18.99, v_site_id);
    END IF;

    -- Item: Gloves Large - 2 @ $ 10.50
    SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Large' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 10.50, v_site_id);
    END IF;

    -- Item: Vim spray - 2 @ $ 7.64
    SELECT id INTO v_product_id FROM products WHERE name = 'Vim spray' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 7.64, v_site_id);
    END IF;

    -- Item: Paper Towel Multifold - 2 @ $ 39.98
    SELECT id INTO v_product_id FROM products WHERE name = 'Paper Towel Multifold' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 39.98, v_site_id);
    END IF;

    -- Item: Garbage Bag 30x38 BLACK - 1 @ $ 24.22
    SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 30x38 BLACK' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 24.22, v_site_id);
    END IF;

    -- Item: Neutral Cleaner Safeblend - 2 @ $ 18.68
    SELECT id INTO v_product_id FROM products WHERE name = 'Neutral Cleaner Safeblend' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 18.68, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: Chef's Hall - 12/8/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'Chef''s Hall' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'draft', '2025-12-09T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Mop head (boxes) - 5 @ $ 6.88
    SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 5, 6.88, v_site_id);
    END IF;

    -- Item: Nose mask - 1 @ $ 0.00
    SELECT id INTO v_product_id FROM products WHERE name = 'Nose mask' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 0.00, v_site_id);
    END IF;

    -- Item: Gloves Large - 2 @ $ 10.50
    SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Large' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 10.50, v_site_id);
    END IF;

    -- Item: Vim spray - 3 @ $ 7.64
    SELECT id INTO v_product_id FROM products WHERE name = 'Vim spray' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 3, 7.64, v_site_id);
    END IF;

    -- Item: Zep purple degreaser - 2 @ $ 13.98
    SELECT id INTO v_product_id FROM products WHERE name = 'Zep purple degreaser' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 13.98, v_site_id);
    END IF;

    -- Item: Dawn dish washer liquid soap - 1 @ $ 34.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Dawn dish washer liquid soap' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 34.99, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: Polytarp - 12/9/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'Polytarp' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'approved', '2025-12-10T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Mr Clean - 2 @ $ 14.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Mr Clean' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 14.99, v_site_id);
    END IF;

    -- Item: Mop head (boxes) - 6 @ $ 6.88
    SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 6, 6.88, v_site_id);
    END IF;

    -- Item: Gloves Large - 4 @ $ 10.50
    SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Large' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 4, 10.50, v_site_id);
    END IF;

    -- Item: Febreeze air freshener - 6 @ $ 18.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Febreeze air freshener' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 6, 18.99, v_site_id);
    END IF;

    -- Item: Toilet bowl - 6 @ $ 14.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Toilet bowl' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 6, 14.99, v_site_id);
    END IF;

    -- Item: Pine Sol - 2 @ $ 13.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Pine Sol' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 13.99, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: Sana - 12/9/2025
  SELECT id INTO v_site_id FROM sites WHERE name = 'Sana' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'approved', '2025-12-10T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Swiffer - 1 @ $ 16.98
    SELECT id INTO v_product_id FROM products WHERE name = 'Swiffer' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 16.98, v_site_id);
    END IF;

    -- Item: Paper towel Kirkland - 1 @ $ 26.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Paper towel Kirkland' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 26.99, v_site_id);
    END IF;

    -- Item: Mop bucket - 1 @ $ 43.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Mop bucket' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 43.99, v_site_id);
    END IF;

    -- Item: Swiffer duster - 1 @ $ 26.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Swiffer duster' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 26.99, v_site_id);
    END IF;

    -- Item: Mop head Costco - 5 @ $ 8.98
    SELECT id INTO v_product_id FROM products WHERE name = 'Mop head Costco' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 5, 8.98, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: Chef's Hall - 1/1/2026
  SELECT id INTO v_site_id FROM sites WHERE name = 'Chef''s Hall' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'draft', '2026-01-02T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Mop head (boxes) - 6 @ $ 6.88
    SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 6, 6.88, v_site_id);
    END IF;

    -- Item: Toilet bowl - 5 @ $ 14.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Toilet bowl' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 5, 14.99, v_site_id);
    END IF;

    -- Item: Fantastik - 4 @ $ 14.48
    SELECT id INTO v_product_id FROM products WHERE name = 'Fantastik' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 4, 14.48, v_site_id);
    END IF;

    -- Item: Dawn dish washer liquid soap - 2 @ $ 34.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Dawn dish washer liquid soap' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 34.99, v_site_id);
    END IF;

    -- Item: Vim spray - 3 @ $ 7.64
    SELECT id INTO v_product_id FROM products WHERE name = 'Vim spray' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 3, 7.64, v_site_id);
    END IF;

    -- Item: Zep purple degreaser - 3 @ $ 13.98
    SELECT id INTO v_product_id FROM products WHERE name = 'Zep purple degreaser' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 3, 13.98, v_site_id);
    END IF;

    -- Item: Gloves X-Large - 3 @ $ 10.50
    SELECT id INTO v_product_id FROM products WHERE name = 'Gloves X-Large' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 3, 10.50, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: Wilcox - 1/1/2026
  SELECT id INTO v_site_id FROM sites WHERE name = 'Wilcox' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'approved', '2026-01-02T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Pine Sol - 3 @ $ 13.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Pine Sol' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 3, 13.99, v_site_id);
    END IF;

    -- Item: Zep purple degreaser - 3 @ $ 13.98
    SELECT id INTO v_product_id FROM products WHERE name = 'Zep purple degreaser' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 3, 13.98, v_site_id);
    END IF;

    -- Item: Windex - 1 @ $ 22.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Windex' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 22.99, v_site_id);
    END IF;

    -- Item: Febreeze air freshener - 4 @ $ 18.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Febreeze air freshener' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 4, 18.99, v_site_id);
    END IF;

    -- Item: Toilet bowl - 3 @ $ 14.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Toilet bowl' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 3, 14.99, v_site_id);
    END IF;

    -- Item: Stainless Steel Cleaner - 3 @ $ 8.28
    SELECT id INTO v_product_id FROM products WHERE name = 'Stainless Steel Cleaner' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 3, 8.28, v_site_id);
    END IF;

    -- Item: Lysol All purpose - 2 @ $ 6.97
    SELECT id INTO v_product_id FROM products WHERE name = 'Lysol All purpose' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 6.97, v_site_id);
    END IF;

    -- Item: Garbage Bag 35x50 CLEAR - 1 @ $ 43.93
    SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 35x50 CLEAR' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 43.93, v_site_id);
    END IF;

    -- Item: Garbage Bag 35x50 BLACK - 1 @ $ 37.24
    SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 35x50 BLACK' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 37.24, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: Sana - 1/4/2026
  SELECT id INTO v_site_id FROM sites WHERE name = 'Sana' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'approved', '2026-01-05T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Windex - 1 @ $ 22.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Windex' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 22.99, v_site_id);
    END IF;

    -- Item: Toilet bowl - 1 @ $ 14.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Toilet bowl' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 14.99, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: Little Canada - 1/4/2026
  SELECT id INTO v_site_id FROM sites WHERE name = 'Little Canada' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'approved', '2026-01-05T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Garbage Bag 24x22 BLACK - 1 @ $ 24.09
    SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 24x22 BLACK' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 24.09, v_site_id);
    END IF;

    -- Item: Garbage Bag 30x38 BLACK - 3 @ $ 24.22
    SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 30x38 BLACK' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 3, 24.22, v_site_id);
    END IF;

    -- Item: Mop head (boxes) - 2 @ $ 6.88
    SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 6.88, v_site_id);
    END IF;

    -- Item: Kool Splash Aloe Vera Foaming Soap - 2 @ $ 17.98
    SELECT id INTO v_product_id FROM products WHERE name = 'Kool Splash Aloe Vera Foaming Soap' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 17.98, v_site_id);
    END IF;

    -- Item: Paper Towel Singlefold - 3 @ $ 39.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Paper Towel Singlefold' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 3, 39.99, v_site_id);
    END IF;

    -- Item: Paper Towel Multifold - 7 @ $ 39.98
    SELECT id INTO v_product_id FROM products WHERE name = 'Paper Towel Multifold' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 7, 39.98, v_site_id);
    END IF;

    -- Item: Toilet Paper Jumbo - 8 @ $ 44.97
    SELECT id INTO v_product_id FROM products WHERE name = 'Toilet Paper Jumbo' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 8, 44.97, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: Vena Solutions - 1/4/2026
  SELECT id INTO v_site_id FROM sites WHERE name = 'Vena Solutions' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'draft', '2026-01-05T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Kool Splash Aloe Vera Foaming Soap - 1 @ $ 17.98
    SELECT id INTO v_product_id FROM products WHERE name = 'Kool Splash Aloe Vera Foaming Soap' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 17.98, v_site_id);
    END IF;

    -- Item: Mop head (boxes) - 3 @ $ 6.88
    SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 3, 6.88, v_site_id);
    END IF;

    -- Item: Garbage Bag 30x38 CLEAR - 2 @ $ 30.23
    SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 30x38 CLEAR' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 30.23, v_site_id);
    END IF;

    -- Item: Gloves Medium - 1 @ $ 10.50
    SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Medium' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 10.50, v_site_id);
    END IF;

    -- Item: Gloves Large - 2 @ $ 10.50
    SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Large' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 10.50, v_site_id);
    END IF;

    -- Item: Pine Sol - 1 @ $ 13.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Pine Sol' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 13.99, v_site_id);
    END IF;

    -- Item: Urinal screen - 2 @ $ 2.73
    SELECT id INTO v_product_id FROM products WHERE name = 'Urinal screen' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 2.73, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: Polytarp - 1/13/2026
  SELECT id INTO v_site_id FROM sites WHERE name = 'Polytarp' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'draft', '2026-01-14T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Pine Sol - 3 @ $ 13.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Pine Sol' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 3, 13.99, v_site_id);
    END IF;

    -- Item: Mr Clean - 3 @ $ 14.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Mr Clean' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 3, 14.99, v_site_id);
    END IF;

    -- Item: Windex - 1 @ $ 22.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Windex' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 22.99, v_site_id);
    END IF;

    -- Item: Mop head (boxes) - 6 @ $ 6.88
    SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 6, 6.88, v_site_id);
    END IF;

    -- Item: Gloves Large - 4 @ $ 10.50
    SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Large' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 4, 10.50, v_site_id);
    END IF;

    -- Item: Febreeze air freshener - 6 @ $ 18.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Febreeze air freshener' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 6, 18.99, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: HHR Law - 1/13/2026
  SELECT id INTO v_site_id FROM sites WHERE name = 'HHR Law' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'draft', '2026-01-14T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Windex - 1 @ $ 22.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Windex' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 22.99, v_site_id);
    END IF;

    -- Item: Toilet bowl - 2 @ $ 14.99
    SELECT id INTO v_product_id FROM products WHERE name = 'Toilet bowl' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 2, 14.99, v_site_id);
    END IF;

    -- Item: Gloves Large - 1 @ $ 10.50
    SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Large' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 10.50, v_site_id);
    END IF;

    -- Item: Vim spray - 1 @ $ 7.64
    SELECT id INTO v_product_id FROM products WHERE name = 'Vim spray' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 1, 7.64, v_site_id);
    END IF;

  END IF;

  -- Purchase Request: WealthSimple - 1/18/2026
  SELECT id INTO v_site_id FROM sites WHERE name = 'WealthSimple' LIMIT 1;
  IF v_site_id IS NOT NULL THEN
    INSERT INTO purchase_requests (site_id, status, created_at, requested_by)
    VALUES (v_site_id, 'approved', '2026-01-19T00:00:00.000Z', v_user_id)
    RETURNING id INTO v_request_id;

    -- Item: Mop head Costco - 5 @ $ 8.98
    SELECT id INTO v_product_id FROM products WHERE name = 'Mop head Costco' LIMIT 1;
    IF v_product_id IS NOT NULL THEN
      INSERT INTO purchase_request_items (purchase_request_id, product_id, quantity_requested, unit_price, target_site_id)
      VALUES (v_request_id, v_product_id, 5, 8.98, v_site_id);
    END IF;

  END IF;

END $$;

-- ============================================
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

  -- Purchase 1: Pine Sol -> Polytarp (2 @ $ 14.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Pine Sol' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      14.99,
      '2025-09-16T12:03:03.892Z',
      v_user_id,
      'Imported from Excel - Original Site: Polytarp'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Polytarp - Imported from Excel - Original Site: Polytarp',
      v_user_id,
      '2025-09-16T12:03:03.892Z'
    );

  END IF;

  -- Purchase 2: Mr Clean -> Polytarp (2 @ $ 18.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Mr Clean' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      18.99,
      '2025-09-16T12:03:05.524Z',
      v_user_id,
      'Imported from Excel - Original Site: Polytarp'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Polytarp - Imported from Excel - Original Site: Polytarp',
      v_user_id,
      '2025-09-16T12:03:05.524Z'
    );

  END IF;

  -- Purchase 3: Windex -> Polytarp (2 @ $ 22.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Windex' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      22.99,
      '2025-09-16T12:03:22.372Z',
      v_user_id,
      'Imported from Excel - Original Site: Polytarp'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Polytarp - Imported from Excel - Original Site: Polytarp',
      v_user_id,
      '2025-09-16T12:03:22.372Z'
    );

  END IF;

  -- Purchase 4: Toilet bowl -> Polytarp (6 @ $ 21.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Toilet bowl' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      6,
      21.99,
      '2025-09-16T12:03:28.468Z',
      v_user_id,
      'Imported from Excel - Original Site: Polytarp'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 6, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 6,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      6,
      'Direct purchase from Excel - Polytarp - Imported from Excel - Original Site: Polytarp',
      v_user_id,
      '2025-09-16T12:03:28.468Z'
    );

  END IF;

  -- Purchase 5: Gloves Large -> Polytarp (2 @ $ 13.50)
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Large' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      13.50,
      '2025-09-16T12:03:42.058Z',
      v_user_id,
      'Imported from Excel - Original Site: Polytarp'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Polytarp - Imported from Excel - Original Site: Polytarp',
      v_user_id,
      '2025-09-16T12:03:42.058Z'
    );

  END IF;

  -- Purchase 6: Windex -> WealthSimple (3 @ $ 22.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Windex' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      3,
      22.99,
      '2025-09-16T12:03:54.487Z',
      v_user_id,
      'Imported from Excel - Original Site: WealthSimple'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 3,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      3,
      'Direct purchase from Excel - WealthSimple - Imported from Excel - Original Site: WealthSimple',
      v_user_id,
      '2025-09-16T12:03:54.487Z'
    );

  END IF;

  -- Purchase 7: Toilet bowl -> WealthSimple (8 @ $ 21.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Toilet bowl' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      8,
      21.99,
      '2025-09-16T12:04:03.589Z',
      v_user_id,
      'Imported from Excel - Original Site: WealthSimple'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 8, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 8,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      8,
      'Direct purchase from Excel - WealthSimple - Imported from Excel - Original Site: WealthSimple',
      v_user_id,
      '2025-09-16T12:04:03.589Z'
    );

  END IF;

  -- Purchase 9: Squeegee sponge refill -> Pos Construction (2 @ $ 12.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Squeegee sponge refill' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      12.99,
      '2025-09-16T12:04:26.845Z',
      v_user_id,
      'Imported from Excel - Original Site: Pos Construction'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Pos Construction - Imported from Excel - Original Site: Pos Construction',
      v_user_id,
      '2025-09-16T12:04:26.845Z'
    );

  END IF;

  -- Purchase 10: Fantastik -> Chef's Hall (4 @ $ 14.48)
  SELECT id INTO v_product_id FROM products WHERE name = 'Fantastik' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      4,
      14.48,
      '2025-09-16T12:04:35.515Z',
      v_user_id,
      'Imported from Excel - Original Site: Chef''''s Hall'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 4,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      4,
      'Direct purchase from Excel - Chef''s Hall - Imported from Excel - Original Site: Chef''''s Hall',
      v_user_id,
      '2025-09-16T12:04:35.515Z'
    );

  END IF;

  -- Purchase 11: Mop head (boxes) -> Chef's Hall (4 @ $ 7.15)
  SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      4,
      7.15,
      '2025-09-16T12:04:44.608Z',
      v_user_id,
      'Imported from Excel - Original Site: Chef''''s Hall'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 4,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      4,
      'Direct purchase from Excel - Chef''s Hall - Imported from Excel - Original Site: Chef''''s Hall',
      v_user_id,
      '2025-09-16T12:04:44.608Z'
    );

  END IF;

  -- Purchase 12: Zep purple degreaser -> Chef's Hall (1 @ $ 12.98)
  SELECT id INTO v_product_id FROM products WHERE name = 'Zep purple degreaser' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      12.98,
      '2025-09-16T12:04:47.803Z',
      v_user_id,
      'Imported from Excel - Original Site: Chef''''s Hall'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - Chef''s Hall - Imported from Excel - Original Site: Chef''''s Hall',
      v_user_id,
      '2025-09-16T12:04:47.803Z'
    );

  END IF;

  -- Purchase 13: Kool Splash Aloe Vera Foaming Soap -> Chef's Hall (2 @ $ 17.50)
  SELECT id INTO v_product_id FROM products WHERE name = 'Kool Splash Aloe Vera Foaming Soap' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      17.50,
      '2025-09-16T12:05:08.025Z',
      v_user_id,
      'Imported from Excel - Original Site: Chef''''s Hall'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Chef''s Hall - Imported from Excel - Original Site: Chef''''s Hall',
      v_user_id,
      '2025-09-16T12:05:08.025Z'
    );

  END IF;

  -- Purchase 14: Fantastik -> No Vacancy (4 @ $ 14.48)
  SELECT id INTO v_product_id FROM products WHERE name = 'Fantastik' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      4,
      14.48,
      '2025-09-16T12:05:15.834Z',
      v_user_id,
      'Imported from Excel - Original Site: No Vacancy'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 4,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      4,
      'Direct purchase from Excel - No Vacancy - Imported from Excel - Original Site: No Vacancy',
      v_user_id,
      '2025-09-16T12:05:15.834Z'
    );

  END IF;

  -- Purchase 15: Mop head (boxes) -> No Vacancy (4 @ $ 7.15)
  SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      4,
      7.15,
      '2025-09-16T12:08:00.117Z',
      v_user_id,
      'Imported from Excel - Original Site: No Vacancy'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 4,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      4,
      'Direct purchase from Excel - No Vacancy - Imported from Excel - Original Site: No Vacancy',
      v_user_id,
      '2025-09-16T12:08:00.117Z'
    );

  END IF;

  -- Purchase 16: Zep purple degreaser -> No Vacancy (2 @ $ 12.98)
  SELECT id INTO v_product_id FROM products WHERE name = 'Zep purple degreaser' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      12.98,
      '2025-09-16T12:08:03.956Z',
      v_user_id,
      'Imported from Excel - Original Site: No Vacancy'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - No Vacancy - Imported from Excel - Original Site: No Vacancy',
      v_user_id,
      '2025-09-16T12:08:03.956Z'
    );

  END IF;

  -- Purchase 17: Toilet bowl -> HHR Law (1 @ $ 21.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Toilet bowl' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      21.99,
      '2025-09-16T12:08:17.605Z',
      v_user_id,
      'Imported from Excel - Original Site: HHR Law'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - HHR Law - Imported from Excel - Original Site: HHR Law',
      v_user_id,
      '2025-09-16T12:08:17.605Z'
    );

  END IF;

  -- Purchase 18: Gloves Large -> HHR Law (2 @ $ 13.50)
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Large' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      13.50,
      '2025-09-16T12:08:35.278Z',
      v_user_id,
      'Imported from Excel - Original Site: HHR Law'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - HHR Law - Imported from Excel - Original Site: HHR Law',
      v_user_id,
      '2025-09-16T12:08:35.278Z'
    );

  END IF;

  -- Purchase 19: Febreeze air freshener -> HHR Law (1 @ $ 18.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Febreeze air freshener' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      18.99,
      '2025-09-16T12:08:39.895Z',
      v_user_id,
      'Imported from Excel - Original Site: HHR Law'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - HHR Law - Imported from Excel - Original Site: HHR Law',
      v_user_id,
      '2025-09-16T12:08:39.895Z'
    );

  END IF;

  -- Purchase 20: Garbage Bag 30x38 BLACK -> HHR Law (2 @ $ 24.22)
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 30x38 BLACK' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      24.22,
      '2025-09-16T12:08:43.880Z',
      v_user_id,
      'Imported from Excel - Original Site: HHR Law'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - HHR Law - Imported from Excel - Original Site: HHR Law',
      v_user_id,
      '2025-09-16T12:08:43.880Z'
    );

  END IF;

  -- Purchase 21: Paper Towel Multifold -> HHR Law (3 @ $ 39.98)
  SELECT id INTO v_product_id FROM products WHERE name = 'Paper Towel Multifold' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      3,
      39.98,
      '2025-09-16T12:08:48.047Z',
      v_user_id,
      'Imported from Excel - Original Site: HHR Law'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 3,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      3,
      'Direct purchase from Excel - HHR Law - Imported from Excel - Original Site: HHR Law',
      v_user_id,
      '2025-09-16T12:08:48.047Z'
    );

  END IF;

  -- Purchase 22: Vim spray -> HHR Law (3 @ $ 7.64)
  SELECT id INTO v_product_id FROM products WHERE name = 'Vim spray' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      3,
      7.64,
      '2025-09-16T12:08:54.014Z',
      v_user_id,
      'Imported from Excel - Original Site: HHR Law'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 3,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      3,
      'Direct purchase from Excel - HHR Law - Imported from Excel - Original Site: HHR Law',
      v_user_id,
      '2025-09-16T12:08:54.014Z'
    );

  END IF;

  -- Purchase 23: Garbage Bag 30x38 CLEAR -> HHR Law (1 @ $ 30.23)
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 30x38 CLEAR' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      30.23,
      '2025-09-16T12:08:58.824Z',
      v_user_id,
      'Imported from Excel - Original Site: HHR Law'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - HHR Law - Imported from Excel - Original Site: HHR Law',
      v_user_id,
      '2025-09-16T12:08:58.824Z'
    );

  END IF;

  -- Purchase 24: Mop head (boxes) -> HHR Law (1 @ $ 7.15)
  SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      7.15,
      '2025-09-16T12:09:11.317Z',
      v_user_id,
      'Imported from Excel - Original Site: HHR Law'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - HHR Law - Imported from Excel - Original Site: HHR Law',
      v_user_id,
      '2025-09-16T12:09:11.317Z'
    );

  END IF;

  -- Purchase 25: Toilet Paper Jumbo -> Vena Solutions (2 @ $ 44.97)
  SELECT id INTO v_product_id FROM products WHERE name = 'Toilet Paper Jumbo' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      44.97,
      '2025-09-24T17:37:14.441Z',
      v_user_id,
      'Imported from Excel - Original Site: Vena Solutions'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Vena Solutions - Imported from Excel - Original Site: Vena Solutions',
      v_user_id,
      '2025-09-24T17:37:14.441Z'
    );

  END IF;

  -- Purchase 26: Paper Towel Multifold -> WealthSimple (5 @ $ 39.98)
  SELECT id INTO v_product_id FROM products WHERE name = 'Paper Towel Multifold' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      5,
      39.98,
      '2025-09-24T17:37:47.342Z',
      v_user_id,
      'Imported from Excel - Original Site: WealthSimple'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 5, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 5,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      5,
      'Direct purchase from Excel - WealthSimple - Imported from Excel - Original Site: WealthSimple',
      v_user_id,
      '2025-09-24T17:37:47.342Z'
    );

  END IF;

  -- Purchase 27: Paper Towel Multifold -> Wilcox (2 @ $ 39.98)
  SELECT id INTO v_product_id FROM products WHERE name = 'Paper Towel Multifold' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      39.98,
      '2025-09-24T17:38:07.530Z',
      v_user_id,
      'Imported from Excel - Original Site: Wilcox'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Wilcox - Imported from Excel - Original Site: Wilcox',
      v_user_id,
      '2025-09-24T17:38:07.530Z'
    );

  END IF;

  -- Purchase 28: Mop head (boxes) -> Wilcox (1 @ $ 7.15)
  SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      7.15,
      '2025-09-24T17:38:47.322Z',
      v_user_id,
      'Imported from Excel - Original Site: Wilcox'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - Wilcox - Imported from Excel - Original Site: Wilcox',
      v_user_id,
      '2025-09-24T17:38:47.322Z'
    );

  END IF;

  -- Purchase 29: Kool Splash Aloe Vera Foaming Soap -> No Vacancy (2 @ $ 17.98)
  SELECT id INTO v_product_id FROM products WHERE name = 'Kool Splash Aloe Vera Foaming Soap' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      17.98,
      '2025-09-24T17:39:23.864Z',
      v_user_id,
      'Imported from Excel - Original Site: No Vacancy'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - No Vacancy - Imported from Excel - Original Site: No Vacancy',
      v_user_id,
      '2025-09-24T17:39:23.864Z'
    );

  END IF;

  -- Purchase 30: Gloves Medium -> Polytarp (2 @ $ 9.50)
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Medium' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      9.50,
      '2025-09-24T17:39:51.004Z',
      v_user_id,
      'Imported from Excel - Original Site: Polytarp'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Polytarp - Imported from Excel - Original Site: Polytarp',
      v_user_id,
      '2025-09-24T17:39:51.004Z'
    );

  END IF;

  -- Purchase 31: Gloves Medium -> WealthSimple (12 @ $ 9.50)
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Medium' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      12,
      9.50,
      '2025-09-24T17:40:51.278Z',
      v_user_id,
      'Imported from Excel - Original Site: WealthSimple'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 12, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 12,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      12,
      'Direct purchase from Excel - WealthSimple - Imported from Excel - Original Site: WealthSimple',
      v_user_id,
      '2025-09-24T17:40:51.278Z'
    );

  END IF;

  -- Purchase 32: Gloves Medium -> Wilcox (1 @ $ 9.50)
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Medium' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      9.50,
      '2025-09-24T17:41:27.712Z',
      v_user_id,
      'Imported from Excel - Original Site: Wilcox'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - Wilcox - Imported from Excel - Original Site: Wilcox',
      v_user_id,
      '2025-09-24T17:41:27.712Z'
    );

  END IF;

  -- Purchase 33: Gloves Medium -> Vena Solutions (2 @ $ 9.50)
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Medium' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      9.50,
      '2025-09-24T17:41:41.423Z',
      v_user_id,
      'Imported from Excel - Original Site: Vena Solutions'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Vena Solutions - Imported from Excel - Original Site: Vena Solutions',
      v_user_id,
      '2025-09-24T17:41:41.423Z'
    );

  END IF;

  -- Purchase 34: Cloth -> Pos Construction (8 @ $ 10.75)
  SELECT id INTO v_product_id FROM products WHERE name = 'Cloth' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      8,
      10.75,
      '2025-09-24T17:42:56.238Z',
      v_user_id,
      'Imported from Excel - Original Site: Pos Construction'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 8, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 8,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      8,
      'Direct purchase from Excel - Pos Construction - Imported from Excel - Original Site: Pos Construction',
      v_user_id,
      '2025-09-24T17:42:56.238Z'
    );

  END IF;

  -- Purchase 35: Tide Laundry Detergent -> WealthSimple (3 @ $ 28.98)
  SELECT id INTO v_product_id FROM products WHERE name = 'Tide Laundry Detergent' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      3,
      28.98,
      '2025-09-24T18:12:11.418Z',
      v_user_id,
      'Imported from Excel - Original Site: WealthSimple'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 3,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      3,
      'Direct purchase from Excel - WealthSimple - Imported from Excel - Original Site: WealthSimple',
      v_user_id,
      '2025-09-24T18:12:11.418Z'
    );

  END IF;

  -- Purchase 36: Downy Laundry -> WealthSimple (3 @ $ 15.98)
  SELECT id INTO v_product_id FROM products WHERE name = 'Downy Laundry' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      3,
      15.98,
      '2025-09-24T18:13:42.565Z',
      v_user_id,
      'Imported from Excel - Original Site: WealthSimple'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 3,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      3,
      'Direct purchase from Excel - WealthSimple - Imported from Excel - Original Site: WealthSimple',
      v_user_id,
      '2025-09-24T18:13:42.565Z'
    );

  END IF;

  -- Purchase 37: Pine Sol -> Wilcox (2 @ $ 13.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Pine Sol' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      13.99,
      '2025-09-24T18:18:41.918Z',
      v_user_id,
      'Imported from Excel - Original Site: Wilcox'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Wilcox - Imported from Excel - Original Site: Wilcox',
      v_user_id,
      '2025-09-24T18:18:41.918Z'
    );

  END IF;

  -- Purchase 38: Palmolive Dish Liquid -> WealthSimple (8 @ $ 10.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Palmolive Dish Liquid' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      8,
      10.99,
      '2025-09-24T18:19:24.612Z',
      v_user_id,
      'Imported from Excel - Original Site: WealthSimple'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 8, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 8,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      8,
      'Direct purchase from Excel - WealthSimple - Imported from Excel - Original Site: WealthSimple',
      v_user_id,
      '2025-09-24T18:19:24.612Z'
    );

  END IF;

  -- Purchase 39: Zep purple degreaser -> Wilcox (2 @ $ 13.98)
  SELECT id INTO v_product_id FROM products WHERE name = 'Zep purple degreaser' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      13.98,
      '2025-09-24T18:23:36.769Z',
      v_user_id,
      'Imported from Excel - Original Site: Wilcox'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Wilcox - Imported from Excel - Original Site: Wilcox',
      v_user_id,
      '2025-09-24T18:23:36.769Z'
    );

  END IF;

  -- Purchase 40: Paper Towel Singlefold -> Little Canada (3 @ $ 39.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Paper Towel Singlefold' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      3,
      39.99,
      '2025-09-30T16:57:37.709Z',
      v_user_id,
      'Imported from Excel - Original Site: Little Canada'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 3,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      3,
      'Direct purchase from Excel - Little Canada - Imported from Excel - Original Site: Little Canada',
      v_user_id,
      '2025-09-30T16:57:37.709Z'
    );

  END IF;

  -- Purchase 41: Paper Towel Multifold -> Little Canada (6 @ $ 39.98)
  SELECT id INTO v_product_id FROM products WHERE name = 'Paper Towel Multifold' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      6,
      39.98,
      '2025-09-30T16:57:38.824Z',
      v_user_id,
      'Imported from Excel - Original Site: Little Canada'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 6, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 6,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      6,
      'Direct purchase from Excel - Little Canada - Imported from Excel - Original Site: Little Canada',
      v_user_id,
      '2025-09-30T16:57:38.824Z'
    );

  END IF;

  -- Purchase 42: Mop head (boxes) -> Little Canada (2 @ $ 7.15)
  SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      7.15,
      '2025-09-30T16:57:43.493Z',
      v_user_id,
      'Imported from Excel - Original Site: Little Canada'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Little Canada - Imported from Excel - Original Site: Little Canada',
      v_user_id,
      '2025-09-30T16:57:43.493Z'
    );

  END IF;

  -- Purchase 43: Garbage Bag 35x50 BLACK -> Little Canada (3 @ $ 37.24)
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 35x50 BLACK' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      3,
      37.24,
      '2025-09-30T16:57:46.117Z',
      v_user_id,
      'Imported from Excel - Original Site: Little Canada'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 3,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      3,
      'Direct purchase from Excel - Little Canada - Imported from Excel - Original Site: Little Canada',
      v_user_id,
      '2025-09-30T16:57:46.117Z'
    );

  END IF;

  -- Purchase 44: Garbage Bag 30x38 BLACK -> Little Canada (3 @ $ 24.22)
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 30x38 BLACK' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      3,
      24.22,
      '2025-09-30T16:57:47.789Z',
      v_user_id,
      'Imported from Excel - Original Site: Little Canada'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 3,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      3,
      'Direct purchase from Excel - Little Canada - Imported from Excel - Original Site: Little Canada',
      v_user_id,
      '2025-09-30T16:57:47.789Z'
    );

  END IF;

  -- Purchase 45: Toilet Paper Jumbo -> Little Canada (5 @ $ 44.97)
  SELECT id INTO v_product_id FROM products WHERE name = 'Toilet Paper Jumbo' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      5,
      44.97,
      '2025-09-30T16:57:51.342Z',
      v_user_id,
      'Imported from Excel - Original Site: Little Canada'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 5, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 5,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      5,
      'Direct purchase from Excel - Little Canada - Imported from Excel - Original Site: Little Canada',
      v_user_id,
      '2025-09-30T16:57:51.342Z'
    );

  END IF;

  -- Purchase 46: Gloves Medium -> Little Canada (5 @ $ 9.50)
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Medium' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      5,
      9.50,
      '2025-09-30T16:57:55.685Z',
      v_user_id,
      'Imported from Excel - Original Site: Little Canada'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 5, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 5,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      5,
      'Direct purchase from Excel - Little Canada - Imported from Excel - Original Site: Little Canada',
      v_user_id,
      '2025-09-30T16:57:55.685Z'
    );

  END IF;

  -- Purchase 47: Gloves Large -> Little Canada (5 @ $ 9.50)
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Large' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      5,
      9.50,
      '2025-09-30T16:57:58.760Z',
      v_user_id,
      'Imported from Excel - Original Site: Little Canada'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 5, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 5,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      5,
      'Direct purchase from Excel - Little Canada - Imported from Excel - Original Site: Little Canada',
      v_user_id,
      '2025-09-30T16:57:58.760Z'
    );

  END IF;

  -- Purchase 48: Cloth -> Little Canada (1 @ $ 10.75)
  SELECT id INTO v_product_id FROM products WHERE name = 'Cloth' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      10.75,
      '2025-09-30T16:58:14.161Z',
      v_user_id,
      'Imported from Excel - Original Site: Little Canada'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - Little Canada - Imported from Excel - Original Site: Little Canada',
      v_user_id,
      '2025-09-30T16:58:14.161Z'
    );

  END IF;

  -- Purchase 49: Kool Splash Aloe Vera Foaming Soap -> Little Canada (4 @ $ 17.98)
  SELECT id INTO v_product_id FROM products WHERE name = 'Kool Splash Aloe Vera Foaming Soap' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      4,
      17.98,
      '2025-09-30T16:58:17.409Z',
      v_user_id,
      'Imported from Excel - Original Site: Little Canada'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 4,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      4,
      'Direct purchase from Excel - Little Canada - Imported from Excel - Original Site: Little Canada',
      v_user_id,
      '2025-09-30T16:58:17.409Z'
    );

  END IF;

  -- Purchase 50: Dawn dish washer liquid soap -> Chef's Hall (2 @ $ 34.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Dawn dish washer liquid soap' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      34.99,
      '2025-10-17T13:31:34.577Z',
      v_user_id,
      'Imported from Excel - Original Site: Chef''''s Hall'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Chef''s Hall - Imported from Excel - Original Site: Chef''''s Hall',
      v_user_id,
      '2025-10-17T13:31:34.577Z'
    );

  END IF;

  -- Purchase 51: Dawn dish washer liquid soap -> No Vacancy (2 @ $ 34.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Dawn dish washer liquid soap' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      34.99,
      '2025-10-17T13:32:08.378Z',
      v_user_id,
      'Imported from Excel - Original Site: No Vacancy'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - No Vacancy - Imported from Excel - Original Site: No Vacancy',
      v_user_id,
      '2025-10-17T13:32:08.378Z'
    );

  END IF;

  -- Purchase 52: Mop head Costco -> WealthSimple (2 @ $ 49.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Mop head Costco' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      49.99,
      '2025-10-17T13:32:26.472Z',
      v_user_id,
      'Imported from Excel - Original Site: WealthSimple'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - WealthSimple - Imported from Excel - Original Site: WealthSimple',
      v_user_id,
      '2025-10-17T13:32:26.472Z'
    );

  END IF;

  -- Purchase 53: Lysol All purpose -> Wilcox (2 @ $ 6.97)
  SELECT id INTO v_product_id FROM products WHERE name = 'Lysol All purpose' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      6.97,
      '2025-10-17T13:32:33.863Z',
      v_user_id,
      'Imported from Excel - Original Site: Wilcox'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Wilcox - Imported from Excel - Original Site: Wilcox',
      v_user_id,
      '2025-10-17T13:32:33.863Z'
    );

  END IF;

  -- Purchase 54: Stainless Steel Cleaner -> Wilcox (3 @ $ 8.28)
  SELECT id INTO v_product_id FROM products WHERE name = 'Stainless Steel Cleaner' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      3,
      8.28,
      '2025-10-17T13:32:40.625Z',
      v_user_id,
      'Imported from Excel - Original Site: Wilcox'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 3,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      3,
      'Direct purchase from Excel - Wilcox - Imported from Excel - Original Site: Wilcox',
      v_user_id,
      '2025-10-17T13:32:40.625Z'
    );

  END IF;

  -- Purchase 55: Zep purple degreaser -> No Vacancy (1 @ $ 13.98)
  SELECT id INTO v_product_id FROM products WHERE name = 'Zep purple degreaser' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      13.98,
      '2025-10-20T01:00:55.871Z',
      v_user_id,
      'Imported from Excel - Original Site: No Vacancy'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - No Vacancy - Imported from Excel - Original Site: No Vacancy',
      v_user_id,
      '2025-10-20T01:00:55.871Z'
    );

  END IF;

  -- Purchase 56: Kool Splash Aloe Vera Foaming Soap -> No Vacancy (1 @ $ 17.98)
  SELECT id INTO v_product_id FROM products WHERE name = 'Kool Splash Aloe Vera Foaming Soap' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      17.98,
      '2025-10-20T01:01:03.166Z',
      v_user_id,
      'Imported from Excel - Original Site: No Vacancy'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - No Vacancy - Imported from Excel - Original Site: No Vacancy',
      v_user_id,
      '2025-10-20T01:01:03.166Z'
    );

  END IF;

  -- Purchase 57: Fantastik -> No Vacancy (4 @ $ 14.48)
  SELECT id INTO v_product_id FROM products WHERE name = 'Fantastik' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      4,
      14.48,
      '2025-10-20T01:01:06.676Z',
      v_user_id,
      'Imported from Excel - Original Site: No Vacancy'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 4,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      4,
      'Direct purchase from Excel - No Vacancy - Imported from Excel - Original Site: No Vacancy',
      v_user_id,
      '2025-10-20T01:01:06.676Z'
    );

  END IF;

  -- Purchase 58: Zep purple degreaser -> Chef's Hall (1 @ $ 13.98)
  SELECT id INTO v_product_id FROM products WHERE name = 'Zep purple degreaser' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      13.98,
      '2025-10-20T01:01:14.189Z',
      v_user_id,
      'Imported from Excel - Original Site: Chef''''s Hall'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - Chef''s Hall - Imported from Excel - Original Site: Chef''''s Hall',
      v_user_id,
      '2025-10-20T01:01:14.189Z'
    );

  END IF;

  -- Purchase 59: Kool Splash Aloe Vera Foaming Soap -> Chef's Hall (1 @ $ 17.98)
  SELECT id INTO v_product_id FROM products WHERE name = 'Kool Splash Aloe Vera Foaming Soap' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      17.98,
      '2025-10-20T01:01:15.668Z',
      v_user_id,
      'Imported from Excel - Original Site: Chef''''s Hall'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - Chef''s Hall - Imported from Excel - Original Site: Chef''''s Hall',
      v_user_id,
      '2025-10-20T01:01:15.668Z'
    );

  END IF;

  -- Purchase 60: Fantastik -> Chef's Hall (4 @ $ 14.48)
  SELECT id INTO v_product_id FROM products WHERE name = 'Fantastik' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      4,
      14.48,
      '2025-10-20T01:01:17.583Z',
      v_user_id,
      'Imported from Excel - Original Site: Chef''''s Hall'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 4,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      4,
      'Direct purchase from Excel - Chef''s Hall - Imported from Excel - Original Site: Chef''''s Hall',
      v_user_id,
      '2025-10-20T01:01:17.583Z'
    );

  END IF;

  -- Purchase 61: Pine Sol -> Wilcox (2 @ $ 13.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Pine Sol' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      13.99,
      '2025-10-20T01:03:16.559Z',
      v_user_id,
      'Imported from Excel - Original Site: Wilcox'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Wilcox - Imported from Excel - Original Site: Wilcox',
      v_user_id,
      '2025-10-20T01:03:16.559Z'
    );

  END IF;

  -- Purchase 62: Zep purple degreaser -> Wilcox (1 @ $ 13.98)
  SELECT id INTO v_product_id FROM products WHERE name = 'Zep purple degreaser' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      13.98,
      '2025-10-20T16:54:38.120Z',
      v_user_id,
      'Imported from Excel - Original Site: Wilcox'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - Wilcox - Imported from Excel - Original Site: Wilcox',
      v_user_id,
      '2025-10-20T16:54:38.120Z'
    );

  END IF;

  -- Purchase 63: Vim spray -> Vena Solutions (2 @ $ 7.64)
  SELECT id INTO v_product_id FROM products WHERE name = 'Vim spray' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      7.64,
      '2025-10-20T16:55:27.478Z',
      v_user_id,
      'Imported from Excel - Original Site: Vena Solutions'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Vena Solutions - Imported from Excel - Original Site: Vena Solutions',
      v_user_id,
      '2025-10-20T16:55:27.478Z'
    );

  END IF;

  -- Purchase 64: Pine Sol -> Vena Solutions (2 @ $ 13.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Pine Sol' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      13.99,
      '2025-10-20T17:00:17.558Z',
      v_user_id,
      'Imported from Excel - Original Site: Vena Solutions'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Vena Solutions - Imported from Excel - Original Site: Vena Solutions',
      v_user_id,
      '2025-10-20T17:00:17.558Z'
    );

  END IF;

  -- Purchase 65: Pine Sol -> Polytarp (1 @ $ 13.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Pine Sol' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      13.99,
      '2025-10-20T17:08:59.629Z',
      v_user_id,
      'Imported from Excel - Original Site: Polytarp'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - Polytarp - Imported from Excel - Original Site: Polytarp',
      v_user_id,
      '2025-10-20T17:08:59.629Z'
    );

  END IF;

  -- Purchase 66: Febreeze air freshener -> Polytarp (2 @ $ 18.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Febreeze air freshener' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      18.99,
      '2025-10-20T17:09:07.014Z',
      v_user_id,
      'Imported from Excel - Original Site: Polytarp'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Polytarp - Imported from Excel - Original Site: Polytarp',
      v_user_id,
      '2025-10-20T17:09:07.014Z'
    );

  END IF;

  -- Purchase 67: Urinal screen -> Wilcox (5 @ $ 27.42)
  SELECT id INTO v_product_id FROM products WHERE name = 'Urinal screen' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      5,
      27.42,
      '2026-01-12T14:30:09.435Z',
      v_user_id,
      'Imported from Excel - Original Site: Wilcox'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 5, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 5,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      5,
      'Direct purchase from Excel - Wilcox - Imported from Excel - Original Site: Wilcox',
      v_user_id,
      '2026-01-12T14:30:09.435Z'
    );

  END IF;

  -- Purchase 68: Hygiene sanitary bags -> Wilcox (1 @ $ 25.89)
  SELECT id INTO v_product_id FROM products WHERE name = 'Hygiene sanitary bags' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      25.89,
      '2026-01-12T14:31:43.296Z',
      v_user_id,
      'Imported from Excel - Original Site: Wilcox'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - Wilcox - Imported from Excel - Original Site: Wilcox',
      v_user_id,
      '2026-01-12T14:31:43.296Z'
    );

  END IF;

  -- Purchase 69: Febreeze air freshener -> Wilcox (4 @ $ 18.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Febreeze air freshener' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      4,
      18.99,
      '2026-01-12T14:32:49.048Z',
      v_user_id,
      'Imported from Excel - Original Site: Wilcox'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 4,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      4,
      'Direct purchase from Excel - Wilcox - Imported from Excel - Original Site: Wilcox',
      v_user_id,
      '2026-01-12T14:32:49.048Z'
    );

  END IF;

  -- Purchase 70: Zep purple degreaser -> Wilcox (2 @ $ 13.98)
  SELECT id INTO v_product_id FROM products WHERE name = 'Zep purple degreaser' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      13.98,
      '2026-01-12T14:34:04.161Z',
      v_user_id,
      'Imported from Excel - Original Site: Wilcox'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Wilcox - Imported from Excel - Original Site: Wilcox',
      v_user_id,
      '2026-01-12T14:34:04.161Z'
    );

  END IF;

  -- Purchase 71: Febreeze air freshener -> HHR Law (4 @ $ 18.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Febreeze air freshener' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      4,
      18.99,
      '2026-01-12T14:34:19.247Z',
      v_user_id,
      'Imported from Excel - Original Site: HHR Law'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 4,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      4,
      'Direct purchase from Excel - HHR Law - Imported from Excel - Original Site: HHR Law',
      v_user_id,
      '2026-01-12T14:34:19.247Z'
    );

  END IF;

  -- Purchase 72: Vim spray -> HHR Law (2 @ $ 7.64)
  SELECT id INTO v_product_id FROM products WHERE name = 'Vim spray' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      7.64,
      '2026-01-12T14:34:46.586Z',
      v_user_id,
      'Imported from Excel - Original Site: HHR Law'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - HHR Law - Imported from Excel - Original Site: HHR Law',
      v_user_id,
      '2026-01-12T14:34:46.586Z'
    );

  END IF;

  -- Purchase 73: Neutral Cleaner Safeblend -> HHR Law (2 @ $ 18.68)
  SELECT id INTO v_product_id FROM products WHERE name = 'Neutral Cleaner Safeblend' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      18.68,
      '2026-01-12T14:35:11.339Z',
      v_user_id,
      'Imported from Excel - Original Site: HHR Law'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - HHR Law - Imported from Excel - Original Site: HHR Law',
      v_user_id,
      '2026-01-12T14:35:11.339Z'
    );

  END IF;

  -- Purchase 74: Vim spray -> Chef's Hall (3 @ $ 7.64)
  SELECT id INTO v_product_id FROM products WHERE name = 'Vim spray' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      3,
      7.64,
      '2026-01-12T14:35:25.376Z',
      v_user_id,
      'Imported from Excel - Original Site: Chef''''s Hall'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 3,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      3,
      'Direct purchase from Excel - Chef''s Hall - Imported from Excel - Original Site: Chef''''s Hall',
      v_user_id,
      '2026-01-12T14:35:25.376Z'
    );

  END IF;

  -- Purchase 75: Zep purple degreaser -> Chef's Hall (2 @ $ 13.98)
  SELECT id INTO v_product_id FROM products WHERE name = 'Zep purple degreaser' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      13.98,
      '2026-01-12T14:35:29.432Z',
      v_user_id,
      'Imported from Excel - Original Site: Chef''''s Hall'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Chef''s Hall - Imported from Excel - Original Site: Chef''''s Hall',
      v_user_id,
      '2026-01-12T14:35:29.432Z'
    );

  END IF;

  -- Purchase 76: Dawn dish washer liquid soap -> Chef's Hall (1 @ $ 34.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Dawn dish washer liquid soap' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      34.99,
      '2026-01-12T14:35:32.752Z',
      v_user_id,
      'Imported from Excel - Original Site: Chef''''s Hall'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - Chef''s Hall - Imported from Excel - Original Site: Chef''''s Hall',
      v_user_id,
      '2026-01-12T14:35:32.752Z'
    );

  END IF;

  -- Purchase 77: Mr Clean -> Polytarp (2 @ $ 14.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Mr Clean' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      14.99,
      '2026-01-12T14:35:36.677Z',
      v_user_id,
      'Imported from Excel - Original Site: Polytarp'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Polytarp - Imported from Excel - Original Site: Polytarp',
      v_user_id,
      '2026-01-12T14:35:36.677Z'
    );

  END IF;

  -- Purchase 78: Febreeze air freshener -> Polytarp (6 @ $ 18.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Febreeze air freshener' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      6,
      18.99,
      '2026-01-12T14:35:44.428Z',
      v_user_id,
      'Imported from Excel - Original Site: Polytarp'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 6, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 6,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      6,
      'Direct purchase from Excel - Polytarp - Imported from Excel - Original Site: Polytarp',
      v_user_id,
      '2026-01-12T14:35:44.428Z'
    );

  END IF;

  -- Purchase 79: Toilet bowl -> Polytarp (6 @ $ 14.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Toilet bowl' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      6,
      14.99,
      '2026-01-12T14:35:47.211Z',
      v_user_id,
      'Imported from Excel - Original Site: Polytarp'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 6, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 6,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      6,
      'Direct purchase from Excel - Polytarp - Imported from Excel - Original Site: Polytarp',
      v_user_id,
      '2026-01-12T14:35:47.211Z'
    );

  END IF;

  -- Purchase 80: Pine Sol -> Polytarp (2 @ $ 13.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Pine Sol' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      13.99,
      '2026-01-12T14:35:50.738Z',
      v_user_id,
      'Imported from Excel - Original Site: Polytarp'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Polytarp - Imported from Excel - Original Site: Polytarp',
      v_user_id,
      '2026-01-12T14:35:50.738Z'
    );

  END IF;

  -- Purchase 81: Swiffer -> Sana (1 @ $ 16.98)
  SELECT id INTO v_product_id FROM products WHERE name = 'Swiffer' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      16.98,
      '2026-01-12T14:35:56.774Z',
      v_user_id,
      'Imported from Excel - Original Site: Sana'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - Sana - Imported from Excel - Original Site: Sana',
      v_user_id,
      '2026-01-12T14:35:56.774Z'
    );

  END IF;

  -- Purchase 82: Paper towel Kirkland -> Sana (1 @ $ 26.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Paper towel Kirkland' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      26.99,
      '2026-01-12T14:37:22.365Z',
      v_user_id,
      'Imported from Excel - Original Site: Sana'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - Sana - Imported from Excel - Original Site: Sana',
      v_user_id,
      '2026-01-12T14:37:22.365Z'
    );

  END IF;

  -- Purchase 83: Mop bucket -> Sana (1 @ $ 43.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Mop bucket' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      43.99,
      '2026-01-12T14:37:29.123Z',
      v_user_id,
      'Imported from Excel - Original Site: Sana'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - Sana - Imported from Excel - Original Site: Sana',
      v_user_id,
      '2026-01-12T14:37:29.123Z'
    );

  END IF;

  -- Purchase 84: Swiffer duster -> Sana (1 @ $ 26.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Swiffer duster' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      26.99,
      '2026-01-12T14:37:34.279Z',
      v_user_id,
      'Imported from Excel - Original Site: Sana'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - Sana - Imported from Excel - Original Site: Sana',
      v_user_id,
      '2026-01-12T14:37:34.279Z'
    );

  END IF;

  -- Purchase 85: Mop head Costco -> Sana (5 @ $ 8.98)
  SELECT id INTO v_product_id FROM products WHERE name = 'Mop head Costco' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      5,
      8.98,
      '2026-01-12T14:38:10.229Z',
      v_user_id,
      'Imported from Excel - Original Site: Sana'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 5, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 5,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      5,
      'Direct purchase from Excel - Sana - Imported from Excel - Original Site: Sana',
      v_user_id,
      '2026-01-12T14:38:10.229Z'
    );

  END IF;

  -- Purchase 86: Vim spray -> Chef's Hall (3 @ $ 7.64)
  SELECT id INTO v_product_id FROM products WHERE name = 'Vim spray' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      3,
      7.64,
      '2026-01-12T14:40:24.629Z',
      v_user_id,
      'Imported from Excel - Original Site: Chef''''s Hall'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 3,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      3,
      'Direct purchase from Excel - Chef''s Hall - Imported from Excel - Original Site: Chef''''s Hall',
      v_user_id,
      '2026-01-12T14:40:24.629Z'
    );

  END IF;

  -- Purchase 87: Febreeze air freshener -> Wilcox (4 @ $ 18.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Febreeze air freshener' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      4,
      18.99,
      '2026-01-12T14:43:18.083Z',
      v_user_id,
      'Imported from Excel - Original Site: Wilcox'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 4,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      4,
      'Direct purchase from Excel - Wilcox - Imported from Excel - Original Site: Wilcox',
      v_user_id,
      '2026-01-12T14:43:18.083Z'
    );

  END IF;

  -- Purchase 88: Fantastik -> Chef's Hall (4 @ $ 14.48)
  SELECT id INTO v_product_id FROM products WHERE name = 'Fantastik' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      4,
      14.48,
      '2026-01-12T15:57:19.454Z',
      v_user_id,
      'Imported from Excel - Original Site: Chef''''s Hall'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 4,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      4,
      'Direct purchase from Excel - Chef''s Hall - Imported from Excel - Original Site: Chef''''s Hall',
      v_user_id,
      '2026-01-12T15:57:19.454Z'
    );

  END IF;

  -- Purchase 89: Dawn dish washer liquid soap -> Chef's Hall (1 @ $ 34.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Dawn dish washer liquid soap' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      34.99,
      '2026-01-12T15:57:21.747Z',
      v_user_id,
      'Imported from Excel - Original Site: Chef''''s Hall'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - Chef''s Hall - Imported from Excel - Original Site: Chef''''s Hall',
      v_user_id,
      '2026-01-12T15:57:21.747Z'
    );

  END IF;

  -- Purchase 90: Zep purple degreaser -> Chef's Hall (2 @ $ 13.98)
  SELECT id INTO v_product_id FROM products WHERE name = 'Zep purple degreaser' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      13.98,
      '2026-01-12T15:57:28.856Z',
      v_user_id,
      'Imported from Excel - Original Site: Chef''''s Hall'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Chef''s Hall - Imported from Excel - Original Site: Chef''''s Hall',
      v_user_id,
      '2026-01-12T15:57:28.856Z'
    );

  END IF;

  -- Purchase 91: Mop head (boxes) -> Chef's Hall (4 @ $ 7.15)
  SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      4,
      7.15,
      '2026-01-12T15:57:45.314Z',
      v_user_id,
      'Imported from Excel - Original Site: Chef''''s Hall'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 4,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      4,
      'Direct purchase from Excel - Chef''s Hall - Imported from Excel - Original Site: Chef''''s Hall',
      v_user_id,
      '2026-01-12T15:57:45.314Z'
    );

  END IF;

  -- Purchase 92: Vim spray -> Chef's Hall (4 @ $ 7.64)
  SELECT id INTO v_product_id FROM products WHERE name = 'Vim spray' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      4,
      7.64,
      '2026-01-12T15:57:48.029Z',
      v_user_id,
      'Imported from Excel - Original Site: Chef''''s Hall'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 4,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      4,
      'Direct purchase from Excel - Chef''s Hall - Imported from Excel - Original Site: Chef''''s Hall',
      v_user_id,
      '2026-01-12T15:57:48.029Z'
    );

  END IF;

  -- Purchase 93: Fantastik -> No Vacancy (4 @ $ 14.48)
  SELECT id INTO v_product_id FROM products WHERE name = 'Fantastik' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      4,
      14.48,
      '2026-01-12T15:57:58.544Z',
      v_user_id,
      'Imported from Excel - Original Site: No Vacancy'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 4,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      4,
      'Direct purchase from Excel - No Vacancy - Imported from Excel - Original Site: No Vacancy',
      v_user_id,
      '2026-01-12T15:57:58.544Z'
    );

  END IF;

  -- Purchase 94: Pine Sol -> No Vacancy (1 @ $ 13.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Pine Sol' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      13.99,
      '2026-01-12T15:58:11.039Z',
      v_user_id,
      'Imported from Excel - Original Site: No Vacancy'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - No Vacancy - Imported from Excel - Original Site: No Vacancy',
      v_user_id,
      '2026-01-12T15:58:11.039Z'
    );

  END IF;

  -- Purchase 95: Lysol All purpose -> Wilcox (3 @ $ 6.97)
  SELECT id INTO v_product_id FROM products WHERE name = 'Lysol All purpose' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      3,
      6.97,
      '2026-01-12T15:58:25.843Z',
      v_user_id,
      'Imported from Excel - Original Site: Wilcox'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 3,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      3,
      'Direct purchase from Excel - Wilcox - Imported from Excel - Original Site: Wilcox',
      v_user_id,
      '2026-01-12T15:58:25.843Z'
    );

  END IF;

  -- Purchase 96: Zep purple degreaser -> Wilcox (3 @ $ 13.98)
  SELECT id INTO v_product_id FROM products WHERE name = 'Zep purple degreaser' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      3,
      13.98,
      '2026-01-12T15:58:32.281Z',
      v_user_id,
      'Imported from Excel - Original Site: Wilcox'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 3,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      3,
      'Direct purchase from Excel - Wilcox - Imported from Excel - Original Site: Wilcox',
      v_user_id,
      '2026-01-12T15:58:32.281Z'
    );

  END IF;

  -- Purchase 97: Stainless Steel Cleaner -> Wilcox (3 @ $ 8.28)
  SELECT id INTO v_product_id FROM products WHERE name = 'Stainless Steel Cleaner' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      3,
      8.28,
      '2026-01-12T15:58:36.768Z',
      v_user_id,
      'Imported from Excel - Original Site: Wilcox'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 3,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      3,
      'Direct purchase from Excel - Wilcox - Imported from Excel - Original Site: Wilcox',
      v_user_id,
      '2026-01-12T15:58:36.768Z'
    );

  END IF;

  -- Purchase 98: Lysol All purpose -> Wilcox (2 @ $ 6.97)
  SELECT id INTO v_product_id FROM products WHERE name = 'Lysol All purpose' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      6.97,
      '2026-01-12T17:18:49.475Z',
      v_user_id,
      'Imported from Excel - Original Site: Wilcox'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Wilcox - Imported from Excel - Original Site: Wilcox',
      v_user_id,
      '2026-01-12T17:18:49.475Z'
    );

  END IF;

  -- Purchase 99: Garbage Bag 24x22 BLACK -> Little Canada (1 @ $ 24.09)
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 24x22 BLACK' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      24.09,
      '2026-01-12T17:41:31.192Z',
      v_user_id,
      'Imported from Excel - Original Site: Little Canada'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - Little Canada - Imported from Excel - Original Site: Little Canada',
      v_user_id,
      '2026-01-12T17:41:31.192Z'
    );

  END IF;

  -- Purchase 100: Garbage Bag 30x38 BLACK -> Little Canada (3 @ $ 24.22)
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 30x38 BLACK' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      3,
      24.22,
      '2026-01-12T17:41:33.128Z',
      v_user_id,
      'Imported from Excel - Original Site: Little Canada'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 3,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      3,
      'Direct purchase from Excel - Little Canada - Imported from Excel - Original Site: Little Canada',
      v_user_id,
      '2026-01-12T17:41:33.128Z'
    );

  END IF;

  -- Purchase 101: Mop head (boxes) -> Little Canada (2 @ $ 7.15)
  SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      7.15,
      '2026-01-12T17:41:39.621Z',
      v_user_id,
      'Imported from Excel - Original Site: Little Canada'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Little Canada - Imported from Excel - Original Site: Little Canada',
      v_user_id,
      '2026-01-12T17:41:39.621Z'
    );

  END IF;

  -- Purchase 102: Kool Splash Aloe Vera Foaming Soap -> Little Canada (2 @ $ 17.98)
  SELECT id INTO v_product_id FROM products WHERE name = 'Kool Splash Aloe Vera Foaming Soap' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      17.98,
      '2026-01-12T17:41:40.723Z',
      v_user_id,
      'Imported from Excel - Original Site: Little Canada'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Little Canada - Imported from Excel - Original Site: Little Canada',
      v_user_id,
      '2026-01-12T17:41:40.723Z'
    );

  END IF;

  -- Purchase 103: Paper Towel Singlefold -> Little Canada (3 @ $ 39.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Paper Towel Singlefold' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      3,
      39.99,
      '2026-01-12T17:41:42.281Z',
      v_user_id,
      'Imported from Excel - Original Site: Little Canada'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 3,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      3,
      'Direct purchase from Excel - Little Canada - Imported from Excel - Original Site: Little Canada',
      v_user_id,
      '2026-01-12T17:41:42.281Z'
    );

  END IF;

  -- Purchase 104: Paper Towel Multifold -> Little Canada (7 @ $ 39.98)
  SELECT id INTO v_product_id FROM products WHERE name = 'Paper Towel Multifold' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      7,
      39.98,
      '2026-01-12T17:41:43.455Z',
      v_user_id,
      'Imported from Excel - Original Site: Little Canada'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 7, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 7,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      7,
      'Direct purchase from Excel - Little Canada - Imported from Excel - Original Site: Little Canada',
      v_user_id,
      '2026-01-12T17:41:43.455Z'
    );

  END IF;

  -- Purchase 105: Toilet Paper Jumbo -> Little Canada (8 @ $ 44.97)
  SELECT id INTO v_product_id FROM products WHERE name = 'Toilet Paper Jumbo' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      8,
      44.97,
      '2026-01-12T17:41:45.350Z',
      v_user_id,
      'Imported from Excel - Original Site: Little Canada'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 8, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 8,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      8,
      'Direct purchase from Excel - Little Canada - Imported from Excel - Original Site: Little Canada',
      v_user_id,
      '2026-01-12T17:41:45.350Z'
    );

  END IF;

  -- Purchase 106: Garbage Bag 30x38 BLACK -> Little Canada (2 @ $ 24.22)
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 30x38 BLACK' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      24.22,
      '2026-01-12T17:49:18.154Z',
      v_user_id,
      'Imported from Excel - Original Site: Little Canada'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Little Canada - Imported from Excel - Original Site: Little Canada',
      v_user_id,
      '2026-01-12T17:49:18.154Z'
    );

  END IF;

  -- Purchase 107: Garbage Bag 35x50 BLACK -> Little Canada (2 @ $ 37.24)
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 35x50 BLACK' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      37.24,
      '2026-01-12T17:49:19.533Z',
      v_user_id,
      'Imported from Excel - Original Site: Little Canada'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Little Canada - Imported from Excel - Original Site: Little Canada',
      v_user_id,
      '2026-01-12T17:49:19.533Z'
    );

  END IF;

  -- Purchase 108: Garbage Bag 35x50 CLEAR -> Little Canada (2 @ $ 43.93)
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 35x50 CLEAR' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      43.93,
      '2026-01-12T17:49:20.749Z',
      v_user_id,
      'Imported from Excel - Original Site: Little Canada'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Little Canada - Imported from Excel - Original Site: Little Canada',
      v_user_id,
      '2026-01-12T17:49:20.749Z'
    );

  END IF;

  -- Purchase 109: Toilet Paper Jumbo -> Little Canada (8 @ $ 44.97)
  SELECT id INTO v_product_id FROM products WHERE name = 'Toilet Paper Jumbo' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      8,
      44.97,
      '2026-01-12T17:49:21.858Z',
      v_user_id,
      'Imported from Excel - Original Site: Little Canada'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 8, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 8,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      8,
      'Direct purchase from Excel - Little Canada - Imported from Excel - Original Site: Little Canada',
      v_user_id,
      '2026-01-12T17:49:21.858Z'
    );

  END IF;

  -- Purchase 110: Paper Towel Multifold -> Little Canada (7 @ $ 39.98)
  SELECT id INTO v_product_id FROM products WHERE name = 'Paper Towel Multifold' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      7,
      39.98,
      '2026-01-12T17:49:24.293Z',
      v_user_id,
      'Imported from Excel - Original Site: Little Canada'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 7, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 7,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      7,
      'Direct purchase from Excel - Little Canada - Imported from Excel - Original Site: Little Canada',
      v_user_id,
      '2026-01-12T17:49:24.293Z'
    );

  END IF;

  -- Purchase 111: Paper Towel Singlefold -> Little Canada (7 @ $ 39.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Paper Towel Singlefold' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      7,
      39.99,
      '2026-01-12T17:49:25.360Z',
      v_user_id,
      'Imported from Excel - Original Site: Little Canada'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 7, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 7,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      7,
      'Direct purchase from Excel - Little Canada - Imported from Excel - Original Site: Little Canada',
      v_user_id,
      '2026-01-12T17:49:25.360Z'
    );

  END IF;

  -- Purchase 112: Mop head (boxes) -> Little Canada (1 @ $ 7.15)
  SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      7.15,
      '2026-01-12T17:49:27.504Z',
      v_user_id,
      'Imported from Excel - Original Site: Little Canada'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - Little Canada - Imported from Excel - Original Site: Little Canada',
      v_user_id,
      '2026-01-12T17:49:27.504Z'
    );

  END IF;

  -- Purchase 113: Kool Splash Aloe Vera Foaming Soap -> Little Canada (1 @ $ 17.98)
  SELECT id INTO v_product_id FROM products WHERE name = 'Kool Splash Aloe Vera Foaming Soap' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      17.98,
      '2026-01-12T17:49:28.940Z',
      v_user_id,
      'Imported from Excel - Original Site: Little Canada'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - Little Canada - Imported from Excel - Original Site: Little Canada',
      v_user_id,
      '2026-01-12T17:49:28.940Z'
    );

  END IF;

  -- Purchase 114: Urinal screen -> Little Canada (1 @ $ 27.42)
  SELECT id INTO v_product_id FROM products WHERE name = 'Urinal screen' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      27.42,
      '2026-01-12T17:49:30.436Z',
      v_user_id,
      'Imported from Excel - Original Site: Little Canada'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - Little Canada - Imported from Excel - Original Site: Little Canada',
      v_user_id,
      '2026-01-12T17:49:30.436Z'
    );

  END IF;

  -- Purchase 115: Urinal screen -> Vena Solutions (2 @ $ 27.42)
  SELECT id INTO v_product_id FROM products WHERE name = 'Urinal screen' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      27.42,
      '2026-01-12T17:59:54.429Z',
      v_user_id,
      'Imported from Excel - Original Site: Vena Solutions'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Vena Solutions - Imported from Excel - Original Site: Vena Solutions',
      v_user_id,
      '2026-01-12T17:59:54.429Z'
    );

  END IF;

  -- Purchase 116: Gloves Large -> Vena Solutions (1 @ $ 9.50)
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Large' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      9.50,
      '2026-01-12T18:00:10.373Z',
      v_user_id,
      'Imported from Excel - Original Site: Vena Solutions'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - Vena Solutions - Imported from Excel - Original Site: Vena Solutions',
      v_user_id,
      '2026-01-12T18:00:10.373Z'
    );

  END IF;

  -- Purchase 117: Gloves Medium -> Vena Solutions (1 @ $ 9.50)
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Medium' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      9.50,
      '2026-01-12T18:00:11.317Z',
      v_user_id,
      'Imported from Excel - Original Site: Vena Solutions'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - Vena Solutions - Imported from Excel - Original Site: Vena Solutions',
      v_user_id,
      '2026-01-12T18:00:11.317Z'
    );

  END IF;

  -- Purchase 118: Mop head (boxes) -> Vena Solutions (2 @ $ 7.15)
  SELECT id INTO v_product_id FROM products WHERE name = 'Mop head (boxes)' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      7.15,
      '2026-01-12T18:05:20.056Z',
      v_user_id,
      'Imported from Excel - Original Site: Vena Solutions'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Vena Solutions - Imported from Excel - Original Site: Vena Solutions',
      v_user_id,
      '2026-01-12T18:05:20.056Z'
    );

  END IF;

  -- Purchase 119: Gloves Medium -> Wilcox (2 @ $ 9.50)
  SELECT id INTO v_product_id FROM products WHERE name = 'Gloves Medium' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      9.50,
      '2026-01-12T18:24:51.935Z',
      v_user_id,
      'Imported from Excel - Original Site: Wilcox'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Wilcox - Imported from Excel - Original Site: Wilcox',
      v_user_id,
      '2026-01-12T18:24:51.935Z'
    );

  END IF;

  -- Purchase 120: Pine Sol -> Vena Solutions (1 @ $ 13.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Pine Sol' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      13.99,
      '2026-01-12T18:35:05.885Z',
      v_user_id,
      'Imported from Excel - Original Site: Vena Solutions'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - Vena Solutions - Imported from Excel - Original Site: Vena Solutions',
      v_user_id,
      '2026-01-12T18:35:05.885Z'
    );

  END IF;

  -- Purchase 121: Garbage Bag 30x38 BLACK -> HHR Law (1 @ $ 24.22)
  SELECT id INTO v_product_id FROM products WHERE name = 'Garbage Bag 30x38 BLACK' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      24.22,
      '2026-01-12T18:38:45.669Z',
      v_user_id,
      'Imported from Excel - Original Site: HHR Law'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - HHR Law - Imported from Excel - Original Site: HHR Law',
      v_user_id,
      '2026-01-12T18:38:45.669Z'
    );

  END IF;

  -- Purchase 122: Paper Towel Multifold -> HHR Law (2 @ $ 39.98)
  SELECT id INTO v_product_id FROM products WHERE name = 'Paper Towel Multifold' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      39.98,
      '2026-01-12T18:39:05.612Z',
      v_user_id,
      'Imported from Excel - Original Site: HHR Law'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - HHR Law - Imported from Excel - Original Site: HHR Law',
      v_user_id,
      '2026-01-12T18:39:05.612Z'
    );

  END IF;

  -- Purchase 123: Toilet bowl -> Chef's Hall (5 @ $ 14.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Toilet bowl' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      5,
      14.99,
      '2026-01-12T18:40:11.743Z',
      v_user_id,
      'Imported from Excel - Original Site: Chef''''s Hall'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 5, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 5,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      5,
      'Direct purchase from Excel - Chef''s Hall - Imported from Excel - Original Site: Chef''''s Hall',
      v_user_id,
      '2026-01-12T18:40:11.743Z'
    );

  END IF;

  -- Purchase 124: Fantastik -> Chef's Hall (4 @ $ 14.48)
  SELECT id INTO v_product_id FROM products WHERE name = 'Fantastik' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      4,
      14.48,
      '2026-01-12T18:40:16.269Z',
      v_user_id,
      'Imported from Excel - Original Site: Chef''''s Hall'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 4, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 4,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      4,
      'Direct purchase from Excel - Chef''s Hall - Imported from Excel - Original Site: Chef''''s Hall',
      v_user_id,
      '2026-01-12T18:40:16.269Z'
    );

  END IF;

  -- Purchase 125: Dawn dish washer liquid soap -> Chef's Hall (2 @ $ 34.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Dawn dish washer liquid soap' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      2,
      34.99,
      '2026-01-12T18:40:19.293Z',
      v_user_id,
      'Imported from Excel - Original Site: Chef''''s Hall'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 2, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 2,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      2,
      'Direct purchase from Excel - Chef''s Hall - Imported from Excel - Original Site: Chef''''s Hall',
      v_user_id,
      '2026-01-12T18:40:19.293Z'
    );

  END IF;

  -- Purchase 126: Zep purple degreaser -> Chef's Hall (3 @ $ 13.98)
  SELECT id INTO v_product_id FROM products WHERE name = 'Zep purple degreaser' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      3,
      13.98,
      '2026-01-12T18:40:20.977Z',
      v_user_id,
      'Imported from Excel - Original Site: Chef''''s Hall'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 3,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      3,
      'Direct purchase from Excel - Chef''s Hall - Imported from Excel - Original Site: Chef''''s Hall',
      v_user_id,
      '2026-01-12T18:40:20.977Z'
    );

  END IF;

  -- Purchase 127: Pine Sol -> Wilcox (3 @ $ 13.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Pine Sol' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      3,
      13.99,
      '2026-01-12T18:40:27.971Z',
      v_user_id,
      'Imported from Excel - Original Site: Wilcox'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 3,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      3,
      'Direct purchase from Excel - Wilcox - Imported from Excel - Original Site: Wilcox',
      v_user_id,
      '2026-01-12T18:40:27.971Z'
    );

  END IF;

  -- Purchase 128: Zep purple degreaser -> Wilcox (3 @ $ 13.98)
  SELECT id INTO v_product_id FROM products WHERE name = 'Zep purple degreaser' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      3,
      13.98,
      '2026-01-12T18:40:28.687Z',
      v_user_id,
      'Imported from Excel - Original Site: Wilcox'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 3,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      3,
      'Direct purchase from Excel - Wilcox - Imported from Excel - Original Site: Wilcox',
      v_user_id,
      '2026-01-12T18:40:28.687Z'
    );

  END IF;

  -- Purchase 129: Windex -> Wilcox (1 @ $ 22.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Windex' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      22.99,
      '2026-01-12T18:40:31.008Z',
      v_user_id,
      'Imported from Excel - Original Site: Wilcox'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - Wilcox - Imported from Excel - Original Site: Wilcox',
      v_user_id,
      '2026-01-12T18:40:31.008Z'
    );

  END IF;

  -- Purchase 130: Toilet bowl -> Wilcox (3 @ $ 14.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Toilet bowl' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      3,
      14.99,
      '2026-01-12T18:40:35.557Z',
      v_user_id,
      'Imported from Excel - Original Site: Wilcox'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 3,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      3,
      'Direct purchase from Excel - Wilcox - Imported from Excel - Original Site: Wilcox',
      v_user_id,
      '2026-01-12T18:40:35.557Z'
    );

  END IF;

  -- Purchase 131: Stainless Steel Cleaner -> Wilcox (3 @ $ 8.28)
  SELECT id INTO v_product_id FROM products WHERE name = 'Stainless Steel Cleaner' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      3,
      8.28,
      '2026-01-12T18:40:37.177Z',
      v_user_id,
      'Imported from Excel - Original Site: Wilcox'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 3, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 3,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      3,
      'Direct purchase from Excel - Wilcox - Imported from Excel - Original Site: Wilcox',
      v_user_id,
      '2026-01-12T18:40:37.177Z'
    );

  END IF;

  -- Purchase 132: Windex -> Sana (1 @ $ 22.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Windex' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      22.99,
      '2026-01-12T18:40:44.352Z',
      v_user_id,
      'Imported from Excel - Original Site: Sana'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - Sana - Imported from Excel - Original Site: Sana',
      v_user_id,
      '2026-01-12T18:40:44.352Z'
    );

  END IF;

  -- Purchase 133: Toilet bowl -> Sana (1 @ $ 14.99)
  SELECT id INTO v_product_id FROM products WHERE name = 'Toilet bowl' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      1,
      14.99,
      '2026-01-12T18:40:46.422Z',
      v_user_id,
      'Imported from Excel - Original Site: Sana'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 1, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 1,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      1,
      'Direct purchase from Excel - Sana - Imported from Excel - Original Site: Sana',
      v_user_id,
      '2026-01-12T18:40:46.422Z'
    );

  END IF;

  -- Purchase 134: Mop head Costco -> WealthSimple (5 @ $ 8.98)
  SELECT id INTO v_product_id FROM products WHERE name = 'Mop head Costco' LIMIT 1;
  IF v_product_id IS NOT NULL THEN
    -- Create direct purchase record
    INSERT INTO direct_purchases (product_id, quantity_purchased, unit_price, purchased_at, purchased_by, notes)
    VALUES (
      v_product_id,
      5,
      8.98,
      '2026-01-19T13:43:07.208Z',
      v_user_id,
      'Imported from Excel - Original Site: WealthSimple'
    ) RETURNING id INTO v_purchase_id;

    -- Add to master warehouse inventory (as packages)
    INSERT INTO site_inventory (site_id, product_id, quantity_packages, quantity_loose_units, last_updated)
    VALUES (v_master_site_id, v_product_id, 5, 0, NOW())
    ON CONFLICT (site_id, product_id) DO UPDATE SET
      quantity_packages = site_inventory.quantity_packages + 5,
      last_updated = NOW();

    -- Record stock movement
    INSERT INTO stock_movements (site_id, product_id, movement_type, quantity, notes, created_by, created_at)
    VALUES (
      v_master_site_id,
      v_product_id,
      'IN',
      5,
      'Direct purchase from Excel - WealthSimple - Imported from Excel - Original Site: WealthSimple',
      v_user_id,
      '2026-01-19T13:43:07.208Z'
    );

  END IF;

END $$;

-- ============================================
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
