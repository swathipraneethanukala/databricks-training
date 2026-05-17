# SQL Practice 

Thisfolder  contains SQL practice questions and solutions for:

- String, Date & Numeric Functions
- Joins
- NULL Functions
- REGEX (Regular Expressions)
- Window functions

---

# 1. String, Date & Numeric Functions (StrDataNum)

## Topics Covered

### String Functions
- UPPER()
- LOWER()
- CONCAT()
- LEFT()
- RIGHT()
- SUBSTRING()

### Date Functions
- CURDATE()
- DATEDIFF()
- TIMESTAMPDIFF()
- YEAR()
- MONTHNAME()
- DAYNAME()

### Numeric Functions
- ROUND()
- TRUNCATE()
- ABS()
- MOD()
- POWER()
- FLOOR()
- CEIL()

### CASE Statements
Used for:
- Employee Classification
- Loan Risk Analysis
- Attendance Evaluation
- Subscription Validation

## Example

```sql
SELECT
    UPPER(emp_name),
    ROUND(salary),
    
    CASE
        WHEN salary > 70000 THEN 'High'
        ELSE 'Normal'
    END
FROM employees;
```

---

# 2. SQL JOINS

## Topics Covered

- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- FULL OUTER JOIN
- SELF JOIN

## Example

```sql
SELECT
    e.emp_name,
    d.dept_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id;
```

---

# 3. NULL Functions

## Topics Covered

- IS NULL
- IS NOT NULL
- IFNULL()
- COALESCE()
- NULLIF()

## Example

```sql
SELECT
    name,
    COALESCE(salary, bonus, 0) AS income
FROM Employees;
```

---

# 4. REGEX (Regular Expressions)

## Topics Covered

- REGEXP_SUBSTR()
- Number Extraction
- Email Extraction
- Phone Number Extraction
- Domain Extraction

## Common Regex Symbols

| Symbol | Meaning |
|--------|----------|
| ^ | Start |
| $ | End |
| [0-9] | Digits |
| [A-Za-z] | Alphabets |
| + | One or More |

## Example

```sql
SELECT
    REGEXP_SUBSTR(email,'^[^@]+')
FROM regex_practice;
```

---
# 5. SQL Window Functions

This repository contains practice SQL queries for Window Functions.

Topics covered:
- ROW_NUMBER()
- RANK()
- DENSE_RANK()

---

# Table Used

```sql
CREATE TABLE employees (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    join_date DATE
);
```

---

# 1. ROW_NUMBER()

## What it does

Gives a unique number to each row.

## Syntax

```sql
ROW_NUMBER() OVER (
    ORDER BY column_name
)
```



## Practiced Topics

- Salary wise row numbers
- Department wise row numbers
- Joining date wise numbering
- Alphabetical ordering

---

# 2. RANK()

## What it does

Gives rank to rows.

If values are same:
- Same rank is given
- Next rank is skipped

## Example

| Salary | Rank |
|--------|------|
| 5000 | 1 |
| 5000 | 1 |
| 4000 | 3 |

## Syntax

```sql
RANK() OVER (
    ORDER BY column_name
)
```



## Practiced Topics

- Salary ranking
- Department ranking
- Date ranking
- Highest and lowest ranking

---

# 3. DENSE_RANK()

## What it does

Same as RANK().

Difference:
- No ranks are skipped.

## Example

| Salary | Dense Rank |
|--------|-------------|
| 5000 | 1 |
| 5000 | 1 |
| 4000 | 2 |

## Syntax

```sql
DENSE_RANK() OVER (
    ORDER BY column_name
)
```



## Practiced Topics

- Salary dense ranking
- Department dense ranking
- Date dense ranking

---

