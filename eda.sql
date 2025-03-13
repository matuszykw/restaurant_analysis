-- total number of orders
SELECT COUNT(DISTINCT order_id) as total_orders
FROM order_details;

-- first and last date of orders
SELECT
    MIN(order_date) as first_order_date,
    MAX(order_date) as last_order_date
FROM order_details;

-- Average number of orders per day
SELECT ROUND(COUNT(DISTINCT order_id) / COUNT(DISTINCT order_date)) as avg_num_of_orders_per_day
FROM order_details;

-- Most common products
SELECT mi.item_name, mi.category, count(*) as order_count
FROM menu_items mi
JOIN order_details od
    ON mi.menu_item_id = od.item_id
GROUP BY mi.item_name, mi.category
ORDER BY order_count DESC;

-- Most common category
SELECT mi.category, count(*) as order_count
FROM menu_items mi
JOIN order_details od
    ON mi.menu_item_id = od.item_id
GROUP BY mi.category;

-- AOV (Average order value)
WITH order_total AS (
    SELECT
        od.order_id,
        SUM(mi.price) value
    FROM menu_items mi
    JOIN order_details od
        ON mi.menu_item_id = od.item_id
    GROUP BY od.order_id
)
SELECT AVG(value) as AOV
FROM order_total;

-- Most popular Hours
SELECT
    HOUR(order_time) hour,
    COUNT(DISTINCT order_id) order_count
FROM order_details
GROUP BY hour
ORDER BY order_count DESC;

-- Most popular day of week (1-sunday)
SELECT
    dayofweek(order_date) day_of_week,
    count(DISTINCT order_id) order_count
FROM order_details
GROUP BY day_of_week
ORDER BY order_count DESC;

-- Total Sales
SELECT SUM(mi.price)
FROM menu_items mi
JOIN order_details od
    ON mi.menu_item_id = od.item_id;

-- Monthly Sales
SELECT
    MONTH(od.order_date) month,
    SUM(mi.price)
FROM menu_items mi
JOIN order_details od
    ON mi.menu_item_id = od.item_id
GROUP BY month;