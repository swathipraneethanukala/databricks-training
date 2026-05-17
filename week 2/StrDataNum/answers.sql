--Question 1----------------
SELECT 
    emp_id,

    -- Name formatting
    INITCAP(emp_name) AS proper_name,

    department,

    -- Total income calculation (NULL safe)
    ROUND(base_salary + COALESCE(bonus, 0)) AS total_income,

    -- Joining year
    EXTRACT(YEAR FROM joining_date) AS joining_year,

    -- Experience classification
    CASE
        WHEN EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM joining_date) > 7
            THEN 'Senior'

        WHEN EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM joining_date)
             BETWEEN 4 AND 7
            THEN 'Mid'

        ELSE 'Junior'
    END AS employee_level

FROM employee_payments;
-------Question 2----------------
SELECT 
    order_id,

    -- Uppercase customer name
    UPPER(customer_name) AS customer_name,

    order_date,

    -- Replace NULL delivery date with today
    COALESCE(delivery_date, CURRENT_DATE) AS final_delivery_date,

    -- Calculate delivery days
    COALESCE(delivery_date, CURRENT_DATE) - order_date AS delivery_days,

    -- Truncate order amount to 1 decimal
    TRUNC(order_amount, 1) AS truncated_amount,

    -- Delivery status classification
    CASE
        WHEN delivery_date IS NULL 
            THEN 'Pending'

        WHEN delivery_date = order_date 
            THEN 'Same-day'

        WHEN (delivery_date - order_date) > 3 
            THEN 'Delayed'

        ELSE 'On-time'
    END AS delivery_status

FROM orders_delivery;
-----------------Question 3-----------------------
SELECT 
    cust_id,

    -- First letter capitalized
    INITCAP(cust_name) AS customer_name,

    city,

    -- Month name of purchase
    TO_CHAR(purchase_date, 'Month') AS purchase_month,

    -- Rounded purchase amount
    ROUND(purchase_amount) AS rounded_amount,

    -- Absolute value 
    ABS(purchase_amount) AS absolute_amount,

    -- Spending classification
    CASE
        WHEN purchase_amount > 15000
            THEN 'High Spender'

        WHEN purchase_amount BETWEEN 8000 AND 15000
            THEN 'Medium Spender'

        ELSE 'Low Spender'
    END AS spending_category

FROM customer_spending;
--------------Question 4---------------
SELECT 
    user_id,

    user_email,

    -- Extract email domain
    SUBSTR(user_email, INSTR(user_email, '@') + 1) AS email_domain,

    start_date,
    end_date,

    -- Subscription duration in months
    MONTHS_BETWEEN(end_date, start_date) AS duration_months,

    -- Format fee with commas
    TO_CHAR(subscription_fee, '99,99,999.99') AS formatted_fee,

    -- Remaining days from today
    end_date - CURRENT_DATE AS remaining_days,

    -- Subscription status
    CASE
        WHEN end_date < CURRENT_DATE
            THEN 'Expired'

        WHEN (end_date - CURRENT_DATE) <= 30
            THEN 'Expiring Soon'

        ELSE 'Active'
    END AS subscription_status

FROM subscriptions;
--------------Question 5------------
SELECT 
    loan_id,

    -- Uppercase customer name
    UPPER(customer_name) AS customer_name,

    loan_amount,
    interest_rate,

    -- Years since loan start
    FLOOR(MONTHS_BETWEEN(CURRENT_DATE, loan_start) / 12) 
        AS years_since_start,

    -- Monthly EMI calculation using POWER function
    ROUND(
        (
            loan_amount *
            (interest_rate / 12 / 100) *
            POWER(1 + (interest_rate / 12 / 100), 12 * 5)
        ) /
        (
            POWER(1 + (interest_rate / 12 / 100), 12 * 5) - 1
        )
    ) AS emi_amount,

    -- Risk categorization
    CASE
        WHEN interest_rate > 9
            THEN 'High Risk'

        WHEN interest_rate BETWEEN 8 AND 9
            THEN 'Medium Risk'

        ELSE 'Low Risk'
    END AS risk_category

FROM loan_details;
-----------Question 6-----------
SELECT 
    emp_id,

    -- Lowercase employee name
    LOWER(emp_name) AS employee_name,

    -- Month name
    TO_CHAR(record_date, 'Month') AS month_name,

    total_days,
    present_days,

    -- Difference between total and present days
    (total_days - present_days) AS absent_days,

    -- Attendance percentage
    ROUND((present_days * 100.0) / total_days) 
        AS attendance_percentage,

    -- Attendance evaluation
    CASE
        WHEN ROUND((present_days * 100.0) / total_days) >= 90
            THEN 'Excellent'

        WHEN ROUND((present_days * 100.0) / total_days) 
             BETWEEN 75 AND 89
            THEN 'Average'

        ELSE 'Poor'
    END AS attendance_status

FROM attendance;
------------------Question 7-----------
SELECT 
    product_id,

    -- Proper case product name
    INITCAP(product_name) AS product_name,

    mrp,
    selling_price,

    -- Discount amount (absolute value)
    ABS(mrp - selling_price) AS discount_amount,

    -- Discount percentage
    ROUND((ABS(mrp - selling_price) * 100) / mrp, 2)
        AS discount_percentage,

    -- Day name of sale
    TO_CHAR(sale_date, 'Day') AS sale_day,

    -- Discount validation
    CASE
        WHEN selling_price < mrp
            THEN 'Valid Discount'

        WHEN selling_price > mrp
            THEN 'Overpriced'

        ELSE 'No Discount'
    END AS discount_status

FROM product_sales;
--------------Question 8-------------
SELECT 
    policy_id,

    -- Uppercase holder name
    UPPER(holder_name) AS holder_name,

    policy_start,
    policy_end,

    -- Policy duration in years
    ROUND(MONTHS_BETWEEN(policy_end, policy_start) / 12, 2)
        AS policy_duration_years,

    -- Remaining days
    (policy_end - CURRENT_DATE) AS remaining_days,

    -- Rounded premium amount
    ROUND(premium_amount) AS rounded_premium,

    -- Policy classification
    CASE
        WHEN policy_end < CURRENT_DATE
            THEN 'Expired'

        WHEN MONTHS_BETWEEN(policy_end, policy_start) / 12 >= 3
            THEN 'Long Term'

        WHEN MONTHS_BETWEEN(policy_end, policy_start) / 12 
             BETWEEN 1 AND 3
            THEN 'Mid Term'

        ELSE 'Short Term'
    END AS policy_status

FROM insurance_policies;
------------Question 9------
SELECT 
    emp_id,

    -- Lowercase employee name
    LOWER(emp_name) AS employee_name,

    current_salary,
    rating,

    -- Years since last hike
    FLOOR(MONTHS_BETWEEN(CURRENT_DATE, last_hike) / 12)
        AS years_since_hike,

    -- Increment amount based on rating
    CASE
        WHEN rating = 5
            THEN current_salary * 0.20

        WHEN rating = 4
            THEN current_salary * 0.10

        WHEN rating = 3
            THEN current_salary * 0.05

        ELSE 0
    END AS increment_amount,

    -- New salary after increment
    ROUND(
        current_salary +
        CASE
            WHEN rating = 5
                THEN current_salary * 0.20

            WHEN rating = 4
                THEN current_salary * 0.10

            WHEN rating = 3
                THEN current_salary * 0.05

            ELSE 0
        END
    ) AS new_salary,

    -- Increment category
    CASE
        WHEN rating = 5
            THEN 'High Increment'

        WHEN rating = 4
            THEN 'Moderate'

        ELSE 'No Increment'
    END AS increment_status

FROM salary_revision;
----------Question 10-----
SELECT
    account_id,
    customer_name,
    
    ABS(balance) AS absolute_balance,
    
    DATEDIFF(CURDATE(),last_transaction) AS days_since_transaction,
    
    CONCAT(UPPER(LEFT(branch,1)),
    LOWER(SUBSTRING(branch,2))) AS branch_name,
    
    SIGN(balance) AS balance_sign,
    
    CASE
        WHEN balance < 0 THEN 'Overdrawn'
        WHEN DATEDIFF(CURDATE(),last_transaction) > 365 THEN 'Dormant'
        ELSE 'Active'
    END AS account_status
FROM bank_accounts;
-------------------------------------------------
--LEVEL 1-------------------------
--Question 1----------
SELECT
    emp_id,
    LOWER(emp_name) AS emp_name,
    
    ROUND(salary - (salary * tax_percent/100)) AS net_salary,
    
    YEAR(last_revision) AS revision_year,
    
    TIMESTAMPDIFF(MONTH,last_revision,CURDATE()) AS months_since_revision,
    
    CASE
        WHEN tax_percent > 20 
             AND TIMESTAMPDIFF(MONTH,last_revision,CURDATE()) > 24
             THEN 'Tax Shock'
             
        WHEN tax_percent BETWEEN 15 AND 20
             THEN 'Review Needed'
             
        ELSE 'Stable'
    END AS status
FROM salary_audit;
------Question 2-----------
SELECT
    emp_code,
    
    CONCAT(UPPER(LEFT(emp_name,1)),
    LOWER(SUBSTRING(emp_name,2))) AS emp_name,
    
    ROUND((bonus/base_salary)*100) AS bonus_percentage,
    
    DAYNAME(bonus_date) AS bonus_day,
    
    ABS(base_salary - bonus) AS salary_bonus_difference,
    
    CASE
        WHEN ((bonus/base_salary)*100) > 30
             AND DAYNAME(bonus_date) IN ('Saturday','Sunday')
             THEN 'Suspicious'
             
        WHEN ((bonus/base_salary)*100) <= 20
             THEN 'Normal'
             
        ELSE 'Audit'
    END AS audit_status
FROM bonus_monitor;
-------Question3-----------
SELECT
    emp_id,
    UPPER(emp_name) AS emp_name,
    
    TIMESTAMPDIFF(YEAR,joining_date,CURDATE()) AS actual_experience,
    
    ABS(declared_experience -
    TIMESTAMPDIFF(YEAR,joining_date,CURDATE())) AS experience_difference,
    
    FLOOR(salary) AS floor_salary,
    
    CASE
        WHEN declared_experience >
             TIMESTAMPDIFF(YEAR,joining_date,CURDATE())
             THEN 'Overstated'
             
        WHEN declared_experience <
             TIMESTAMPDIFF(YEAR,joining_date,CURDATE())
             THEN 'Understated'
             
        ELSE 'Matched'
    END AS experience_status
FROM employee_experience;
---QUESTION 4 --------
SELECT
    emp_id,
    
    RIGHT(emp_name,2) AS last_two_characters,
    
    DAY(credit_date) AS credit_day,
    
    TRUNCATE(salary,0) AS truncated_salary,
    
    MOD(TRUNCATE(salary,0),10) AS salary_mod,
    
    CASE
        WHEN MOD(TRUNCATE(salary,0),10) = DAY(credit_date)
             THEN 'Pattern Match'
             
        ELSE 'No Match'
    END AS pattern_status
FROM salary_digits;
------------QUESTION 5 -------------------
SELECT
    emp_id,
    LOWER(emp_name) AS emp_name,
    
    DAYNAME(payment_date) AS weekday_name,
    
    ROUND(salary) AS rounded_salary,
    
    MOD(ROUND(salary),2) AS salary_mod,
    
    CASE
        WHEN MOD(ROUND(salary),2)=0
             AND DAY(payment_date)%2=1
             THEN 'Violation'
             
        ELSE 'Compliant'
    END AS compliance_status
FROM payroll_control;
-----QUESTION 6 -----------
SELECT
    emp_id,
    
    CONCAT(UPPER(LEFT(emp_name,1)),
    LOWER(SUBSTRING(emp_name,2))) AS emp_name,
    
    TIMESTAMPDIFF(YEAR,last_hike,CURDATE()) AS years_since_hike,
    
    POWER(TIMESTAMPDIFF(YEAR,last_hike,CURDATE()),2) AS power_value,
    
    ROUND(salary * POWER(1.05,
    TIMESTAMPDIFF(YEAR,last_hike,CURDATE()))) AS salary_impact,
    
    CASE
        WHEN TIMESTAMPDIFF(YEAR,last_hike,CURDATE()) > 5
             THEN 'High Inflation Risk'
        WHEN TIMESTAMPDIFF(YEAR,last_hike,CURDATE()) BETWEEN 3 AND 5
             THEN 'Moderate'
        ELSE 'Low'
    END AS inflation_status
FROM inflation_watch;
  -------QUESTION 7 ---------
SELECT
    emp_id,
    UPPER(emp_name) AS emp_name,
    
    YEAR(record_date) AS record_year,
    
    SIGN(salary) AS salary_sign,
    
    ABS(salary) AS absolute_salary,
    
    CASE
        WHEN salary < 0 THEN 'Negative Error'
        WHEN salary = 0 THEN 'Zero Salary'
        ELSE 'Valid'
    END AS integrity_status
FROM salary_integrity;
------QUESTION 8 ----------
SELECT
    emp_id,
    
    LENGTH(emp_name) AS name_length,
    
    TIMESTAMPDIFF(YEAR,join_date,CURDATE()) AS years_service,
    
    ROUND(salary) AS rounded_salary,
    
    CASE
        WHEN LENGTH(emp_name) >
             TIMESTAMPDIFF(YEAR,join_date,CURDATE())
             THEN 'Name Bias'
        ELSE 'Neutral'
    END AS correlation_status
FROM name_salary;
-----QUESTION 9----------
SELECT
    emp_id,
    
    MONTHNAME(paid_date) AS month_name,
    
    CEIL(salary) AS ceil_salary,
    
    LAST_DAY(paid_date) AS month_last_day,
    
    CASE
        WHEN paid_date = LAST_DAY(paid_date)
             THEN 'End Month Spike'
        ELSE 'Regular'
    END AS salary_status
FROM salary_monthly;
--------QUESTION 10 ----------------
SELECT
    emp_id,
    
    LEFT(emp_name,1) AS first_character,
    
    TRUNCATE(salary,0) AS truncated_salary,
    
    (
      FLOOR(TRUNCATE(salary,0)/10000) +
      FLOOR((TRUNCATE(salary,0)%10000)/1000) +
      FLOOR((TRUNCATE(salary,0)%1000)/100) +
      FLOOR((TRUNCATE(salary,0)%100)/10) +
      MOD(TRUNCATE(salary,0),10)
    ) AS digit_sum,
    
    DAY(audit_date) AS audit_day,
    
    CASE
        WHEN (
          FLOOR(TRUNCATE(salary,0)/10000) +
          FLOOR((TRUNCATE(salary,0)%10000)/1000)
        ) > 10
             THEN 'Digit Alert'
        ELSE 'Normal'
    END AS audit_status
FROM digit_audit;
----------LEVEL 2----------
----------QUESTION 1 ---------
SELECT
    emp_id,
    
    CONCAT(UPPER(LEFT(emp_name,1)),
    LOWER(SUBSTRING(emp_name,2))) AS emp_name,
    
    CASE
        WHEN DAYNAME(login_time) IN ('Saturday','Sunday')
             THEN 'Weekend'
        ELSE 'Weekday'
    END AS login_type,
    
    ROUND(TIMESTAMPDIFF(MINUTE,login_time,logout_time)/60,2)
    AS working_hours,
    
    CASE
        WHEN DAYNAME(login_time) NOT IN ('Saturday','Sunday')
             AND TIMESTAMPDIFF(MINUTE,login_time,logout_time)/60 >= 8
             THEN 'Good Performer'
             
        WHEN DAYNAME(login_time) NOT IN ('Saturday','Sunday')
             AND TIMESTAMPDIFF(MINUTE,login_time,logout_time)/60 < 6
             THEN 'Bad Performer'
             
        ELSE 'Weekend Login'
    END AS performance_status
FROM employee_login;
--------------QUESTION 2 – ----------------
SELECT
    emp_id,
    UPPER(emp_name) AS emp_name,
    
    CASE
        WHEN login_date >= CURDATE() - INTERVAL 7 DAY
             THEN 'Within Last 7 Days'
        ELSE 'Old Record'
    END AS attendance_check,
    
    CASE
        WHEN DAYNAME(login_date) IN ('Saturday','Sunday')
             THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    
    TIMESTAMPDIFF(HOUR,login_time,logout_time) AS working_hours,
    
    CASE
        WHEN login_date >= CURDATE() - INTERVAL 7 DAY
             AND TIMESTAMPDIFF(HOUR,login_time,logout_time) >= 8
             THEN 'Active & Productive'
             
        WHEN login_date >= CURDATE() - INTERVAL 7 DAY
             AND TIMESTAMPDIFF(HOUR,login_time,logout_time) < 8
             THEN 'Active but Low Hours'
             
        ELSE 'Absent from Last 7 Days'
    END AS productivity_status
FROM attendance_log;
-------QUESTION 3 –-------------
SELECT
    emp_id,
    
    DAYNAME(work_date) AS day_name,
    
    LOWER(emp_name) AS emp_name,
    
    TIMESTAMPDIFF(HOUR,login_time,logout_time) AS working_hours,
    
    CEIL(TIMESTAMPDIFF(MINUTE,login_time,logout_time)/60)
    AS ceil_hours,
    
    CASE
        WHEN DAYNAME(work_date) IN ('Saturday','Sunday')
             AND TIMESTAMPDIFF(HOUR,login_time,logout_time) >= 8
             THEN 'Weekend Overtime'
             
        WHEN DAYNAME(work_date) IN ('Saturday','Sunday')
             AND TIMESTAMPDIFF(HOUR,login_time,logout_time) < 4
             THEN 'Suspicious Login'
             
        ELSE 'Normal Working Day'
    END AS weekend_status
FROM weekend_monitor;
---------QUESTION 4 ---------
SELECT
    emp_id,
    
    HOUR(login_datetime) AS login_hour,
    
    TIMESTAMPDIFF(MINUTE,login_datetime,logout_datetime)/60
    AS total_working_hours,
    
    TRUNCATE(
      TIMESTAMPDIFF(MINUTE,login_datetime,logout_datetime)/60,1
    ) AS truncated_hours,
    
    DAYNAME(login_datetime) AS weekday_name,
    
    CASE
        WHEN DAYNAME(login_datetime) NOT IN ('Saturday','Sunday')
             AND HOUR(login_datetime) < 9
             AND TIMESTAMPDIFF(HOUR,login_datetime,logout_datetime) >= 8
             THEN 'Disciplined'
             
        WHEN DAYNAME(login_datetime) NOT IN ('Saturday','Sunday')
             AND HOUR(login_datetime) > 10
             THEN 'Late Comer'
             
        ELSE 'Poor Discipline'
    END AS discipline_status
FROM login_discipline;
----QUESTION 5------------
SELECT
    emp_id,
    
    CASE
        WHEN work_date >= CURDATE() - INTERVAL 7 DAY
             THEN 'Recent'
        ELSE 'Old'
    END AS attendance_period,
    
    CASE
        WHEN DAYNAME(work_date) IN ('Saturday','Sunday')
             THEN 'Weekend'
        ELSE 'Weekday'
    END AS workday_type,
    
    TIMESTAMPDIFF(HOUR,login_time,logout_time) AS total_hours,
    
    FLOOR(TIMESTAMPDIFF(MINUTE,login_time,logout_time)/60)
    AS floor_hours,
    
    CASE
        WHEN work_date >= CURDATE() - INTERVAL 7 DAY
             AND DAYNAME(work_date) NOT IN ('Saturday','Sunday')
             AND TIMESTAMPDIFF(HOUR,login_time,logout_time) >= 8
             THEN 'Consistent Performer'
             
        WHEN TIMESTAMPDIFF(HOUR,login_time,logout_time) < 6
             THEN 'Irregular Performer'
             
        ELSE 'Absent / Old Record'
    END AS performance_status
FROM performance_tracker;
