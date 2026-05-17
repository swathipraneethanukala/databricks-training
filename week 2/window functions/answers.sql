----------1. Assign a unique row number to all employees based on salary (highest first)
SELECT emp_id, emp_name, department, salary,
ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
FROM employees;
----------2. Assign row numbers to employees within each department based on salary descending
SELECT emp_id, emp_name, department, salary,
ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS row_num
FROM employees;
-------------3. Assign row numbers based on employee joining date (latest first)
SELECT emp_id, emp_name, join_date,
ROW_NUMBER() OVER (ORDER BY join_date DESC) AS row_num
FROM employees;
------------4. Assign row numbers within each department based on earliest joining date
SELECT emp_id, emp_name, department, join_date,
ROW_NUMBER() OVER (PARTITION BY department ORDER BY join_date ASC) AS row_num
FROM employees;
----------5. Assign row numbers to orders based on order date
SELECT order_id, customer_name, order_date,
ROW_NUMBER() OVER (ORDER BY order_date) AS row_num
FROM orders;
----------6. Assign row numbers to orders within each city based on order amount (highest first)
SELECT order_id, customer_name, city, amount,
ROW_NUMBER() OVER (PARTITION BY city ORDER BY amount DESC) AS row_num
FROM orders;
------------7. Assign row numbers to employees based on salary (lowest first)
SELECT emp_id, emp_name, salary,
ROW_NUMBER() OVER (ORDER BY salary ASC) AS row_num
FROM employees;
----------8. Assign row numbers within department for employees based on name alphabetically
SELECT emp_id, emp_name, department,
ROW_NUMBER() OVER (PARTITION BY department ORDER BY emp_name ASC) AS row_num
FROM employees;
-------------RANK() Questions----------------
----------9. Rank all employees based on salary (highest first)
SELECT emp_id, emp_name, salary,
RANK() OVER (ORDER BY salary DESC) AS rank_num
FROM employees;
----------10. Rank employees within each department based on salary
SELECT emp_id, emp_name, department, salary,
RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank_num
FROM employees;
---------11. Rank employees based on joining date (latest gets rank 1)
SELECT emp_id, emp_name, join_date,
RANK() OVER (ORDER BY join_date DESC) AS rank_num
FROM employees;
----------12. Rank orders based on order amount (highest first)
SELECT order_id, customer_name, amount,
RANK() OVER (ORDER BY amount DESC) AS rank_num
FROM orders;
--------13. Rank orders within each city based on order amount
SELECT order_id, customer_name, city, amount,
RANK() OVER (PARTITION BY city ORDER BY amount DESC) AS rank_num
FROM orders;
-----------14. Rank employees within department based on salary (lowest first)
SELECT emp_id, emp_name, department, salary,
RANK() OVER (PARTITION BY department ORDER BY salary ASC) AS rank_num
FROM employees;
--------15. Rank employees based on name alphabetically
SELECT emp_id, emp_name,
RANK() OVER (ORDER BY emp_name ASC) AS rank_num
FROM employees;
----------16. Rank orders within each city based on order date
SELECT order_id, customer_name, city, order_date,
RANK() OVER (PARTITION BY city ORDER BY order_date ASC) AS rank_num
FROM orders;
----------DENSE_RANK() Questions------------------
------------17. Assign dense rank to employees based on salary (highest first)
SELECT emp_id, emp_name, salary,
DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank_num
FROM employees;
---------18. Assign dense rank within each department based on salary
SELECT emp_id, emp_name, department, salary,
DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dense_rank_num
FROM employees;
-----------19. Assign dense rank to employees based on joining date
SELECT emp_id, emp_name, join_date,
DENSE_RANK() OVER (ORDER BY join_date DESC) AS dense_rank_num
FROM employees;
----------20. Assign dense rank to orders based on order amount
SELECT order_id, customer_name, amount,
DENSE_RANK() OVER (ORDER BY amount DESC) AS dense_rank_num
FROM orders;
--------21. Assign dense rank within each city based on order amount
SELECT order_id, customer_name, city, amount,
DENSE_RANK() OVER (PARTITION BY city ORDER BY amount DESC) AS dense_rank_num
FROM orders;
-----------22. Assign dense rank to employees based on salary (lowest first)
SELECT emp_id, emp_name, salary,
DENSE_RANK() OVER (ORDER BY salary ASC) AS dense_rank_num
FROM employees;
-----------23. Assign dense rank within department based on joining date
SELECT emp_id, emp_name, department, join_date,
DENSE_RANK() OVER (PARTITION BY department ORDER BY join_date ASC) AS dense_rank_num
FROM employees;
----------24. Assign dense rank to orders based on order date
SELECT order_id, customer_name, order_date,
DENSE_RANK() OVER (ORDER BY order_date ASC) AS dense_rank_num
FROM orders;
