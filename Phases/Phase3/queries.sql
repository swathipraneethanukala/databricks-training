-- ==========================================
-- BUSINESS PIPELINE EXERCISES (SPARK SQL)
-- ==========================================
-- Make sure to register your views in PySpark first:
-- customers.createOrReplaceTempView("customers")
-- sales_df.createOrReplaceTempView("sales")

-- ------------------------------------------
-- 1. Daily Sales
-- ------------------------------------------
-- Objective: Clean null records from sales data and calculate daily revenue aggregates.
WITH clean_sales AS (
    SELECT * 
    FROM sales 
    WHERE sale_id IS NOT NULL 
      AND sale_date IS NOT NULL 
      AND total_amount IS NOT NULL
)
SELECT 
    sale_date,
    ROUND(SUM(CAST(total_amount AS DOUBLE)), 2) AS daily_sales_amount,
    COUNT(sale_id) AS total_orders
FROM clean_sales
GROUP BY sale_date
ORDER BY sale_date ASC;


-- ------------------------------------------
-- 2. City-wise Revenue
-- ------------------------------------------
-- Objective: Clean customer data and join with sales to evaluate total revenue generated per city.
WITH clean_customers AS (
    SELECT * 
    FROM customers 
    WHERE customer_id IS NOT NULL 
      AND city IS NOT NULL
)
SELECT 
    c.city,
    ROUND(SUM(CAST(s.total_amount AS DOUBLE)), 2) AS total_revenue
FROM clean_customers c
INNER JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.city
ORDER BY total_revenue DESC;


-- ------------------------------------------
-- 3. Find Repeat Customers
-- ------------------------------------------
-- Objective: Filter and identify loyal customers who have placed more than 2 orders.
SELECT 
    customer_id,
    COUNT(sale_id) AS order_count
FROM sales
GROUP BY customer_id
HAVING COUNT(sale_id) > 2
ORDER BY order_count DESC;


-- ------------------------------------------
-- 4. Highest Spending Customer in Each City
-- ------------------------------------------
-- Objective: Rank total spending per customer within each city and return only the top consumer.
WITH customer_spending AS (
    SELECT 
        c.city,
        c.customer_id,
        CONCAT_WS(' ', c.first_name, c.last_name) AS customer_name,
        SUM(CAST(s.total_amount AS DOUBLE)) AS total_spend
    FROM customers c
    INNER JOIN sales s ON c.customer_id = s.customer_id
    GROUP BY c.city, c.customer_id, c.first_name, c.last_name
),
ranked_spending AS (
    SELECT 
        city,
        customer_id,
        customer_name,
        total_spend,
        ROW_NUMBER() OVER (PARTITION BY city ORDER BY total_spend DESC) AS rank
    FROM customer_spending
)
SELECT 
    city,
    customer_id,
    customer_name,
    total_spend
FROM ranked_spending
WHERE rank = 1;


-- ------------------------------------------
-- 5. Final Reporting Table
-- ------------------------------------------
-- Objective: Build a comprehensive master reporting view with customer metadata, order counts, and total spend (defaulting nulls to 0).
SELECT 
    c.customer_id,
    CONCAT_WS(' ', c.first_name, c.last_name) AS customer_name,
    c.city,
    COALESCE(SUM(CAST(s.total_amount AS DOUBLE)), 0) AS total_spend,
    COUNT(s.sale_id) AS order_count
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.city
ORDER BY total_spend DESC;
