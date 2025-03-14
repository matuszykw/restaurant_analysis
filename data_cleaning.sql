SELECT order_details_id, count(*)
FROM order_details
GROUP BY order_details_id
HAVING count(*) > 1;
-- no duplicates

SELECT *
FROM order_details
WHERE order_id IS NULL OR item_id IS NULL;
-- 137 rows with item_id = NULL
DELETE FROM order_details
WHERE order_id IS NULL OR item_id IS NULL;

SELECT *
FROM menu_items
WHERE item_name IS NULL OR price IS NULL;
-- no null values

SELECT *
FROM order_details
WHERE order_time < '06:00:00' OR order_time > '23:59:59';

ALTER TABLE order_details ADD COLUMN item_price DECIMAL(10,2);

UPDATE order_details od
JOIN menu_items mi ON od.item_id = mi.menu_item_id
SET od.item_price = mi.price;