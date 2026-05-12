-- 1. Use ROW_NUMBER() to assign a row number to employees ordered by salary descending
SELECT 
    employee_id,
    employee_name,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
FROM employees;
-- 2. Use RANK() to rank employees by salary
SELECT 
    employee_id,
    employee_name,
    salary,
    RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;
-- 3. Use DENSE_RANK() to rank employees by salary
SELECT 
    employee_id,
    employee_name,
    salary,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank
FROM employees;
-- 4. Find the top 3 highest-paid employees using a window function
WITH ranked_employees AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn
    FROM employees
)
SELECT *
FROM ranked_employees
WHERE rn <= 3;
-- 5. Rank employees within each department using PARTITION BY
SELECT 
    employee_id,
    employee_name,
    department,
    salary,
    RANK() OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS dept_rank
FROM employees;
-- 6. Display the highest salary in each department using a window function
SELECT 
    employee_id,
    employee_name,
    department,
    salary,
    MAX(salary) OVER (PARTITION BY department) AS highest_salary
FROM employees;
-- 7. Calculate the running total of order amounts ordered by order_date
SELECT 
    order_id,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        ORDER BY order_date
    ) AS running_total
FROM orders;
-- 8. Calculate the cumulative sales amount for each employee
SELECT 
    employee_id,
    order_id,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY employee_id
        ORDER BY order_date
    ) AS cumulative_sales
FROM orders;
-- 9. Use LAG() to show the previous order amount for each customer
SELECT 
    customer_id,
    order_id,
    order_date,
    total_amount,
    LAG(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_order_amount
FROM orders;
-- 10. Use LEAD() to show the next order amount for each customer
SELECT 
    customer_id,
    order_id,
    order_date,
    total_amount,
    LEAD(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS next_order_amount
FROM orders;
-- 11. Find the difference between the current order amount and previous order amount
SELECT 
    customer_id,
    order_id,
    order_date,
    total_amount,
    total_amount - LAG(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS amount_difference
FROM orders;
-- 12. Calculate a moving average of the last 3 orders
SELECT 
    order_id,
    order_date,
    total_amount,
    AVG(total_amount) OVER (
        ORDER BY order_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_avg
FROM orders;
-- 13. Use NTILE(4) to divide employees into salary quartiles
SELECT 
    employee_id,
    employee_name,
    salary,
    NTILE(4) OVER (ORDER BY salary DESC) AS salary_quartile
FROM employees;
-- 14. Find the first order placed by each customer using ROW_NUMBER()
WITH first_orders AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY customer_id
               ORDER BY order_date
           ) AS rn
    FROM orders
)
SELECT *
FROM first_orders
WHERE rn = 1;
-- 15. Find the latest order placed by each customer
WITH latest_orders AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY customer_id
               ORDER BY order_date DESC
           ) AS rn
    FROM orders
)
SELECT *
FROM latest_orders
WHERE rn = 1;
-- 16. Display employee salaries along with department average salary
SELECT 
    employee_id,
    employee_name,
    department,
    salary,
    AVG(salary) OVER (
        PARTITION BY department
    ) AS dept_avg_salary
FROM employees;
-- 17. Find employees earning above their department average salary
WITH emp_avg AS (
    SELECT 
        employee_id,
        employee_name,
        department,
        salary,
        AVG(salary) OVER (
            PARTITION BY department
        ) AS dept_avg
    FROM employees
)
SELECT *
FROM emp_avg
WHERE salary > dept_avg;
-- 18. Use SUM() OVER(PARTITION BY department) to calculate department payroll
SELECT 
    employee_id,
    employee_name,
    department,
    salary,
    SUM(salary) OVER (
        PARTITION BY department
    ) AS department_payroll
FROM employees;
-- 19. Find the percentage contribution of each employee salary within their department
SELECT 
    employee_id,
    employee_name,
    department,
    salary,
    ROUND(
        (salary * 100.0) /
        SUM(salary) OVER (PARTITION BY department),
        2
    ) AS salary_percentage
FROM employees;
-- 20. Use COUNT() OVER() to show total number of employees alongside each row
SELECT 
    employee_id,
    employee_name,
    department,
    COUNT(*) OVER () AS total_employees
FROM employees;
