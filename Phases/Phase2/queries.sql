-- ==============================================================================
-- Datasets Used: customers_view, sales_view
-- ==============================================================================

-- EXERCISE 1: Total order amount for each customer
SELECT
    customer_id,
    SUM(CAST(total_amount AS DOUBLE)) AS total_order_amount
FROM sales_view
GROUP BY customer_id
ORDER BY total_order_amount DESC;

-- EXERCISE 2: Top 3 customers by total spend
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(CAST(s.total_amount AS DOUBLE)) AS total_spend
FROM customers_view c
JOIN sales_view s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spend DESC
LIMIT 3;

-- EXERCISE 3: Customers with no orders
SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM customers_view c
LEFT JOIN sales_view s ON c.customer_id = s.customer_id
WHERE s.customer_id IS NULL;

-- EXERCISE 4: City-wise total revenue
SELECT
    c.city,
    SUM(CAST(s.total_amount AS DOUBLE)) AS total_revenue
FROM customers_view c
JOIN sales_view s ON c.customer_id = s.customer_id
GROUP BY c.city;

-- EXERCISE 5: Average order amount per customer
SELECT
    customer_id,
    AVG(CAST(total_amount AS DOUBLE)) AS avg_order_amount
FROM sales_view
GROUP BY customer_id;

-- EXERCISE 6: Customers with more than one order
SELECT
    customer_id,
    COUNT(sale_id) AS order_count
FROM sales_view
GROUP BY customer_id
HAVING COUNT(sale_id) > 1;

-- EXERCISE 7: Sort customers by total spend descending
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(CAST(s.total_amount AS DOUBLE)) AS total_spend
FROM customers_view c
JOIN sales_view s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spend DESC;
