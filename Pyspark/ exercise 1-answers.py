data = [
    (1, "Sravan", 25, "Hyderabad", "Data Engineer", 55000, "2023-01-15", "IT"),
    (2, "Ravi", 28, "Bangalore", "Software Engineer", 72000, "2022-11-10", "IT"),
    (3, "Priya", 24, "Chennai", "Analyst", 48000, "2023-03-12", "Analytics"),
    (4, "Kiran", 30, "Pune", "Manager", 85000, "2021-09-20", "Management"),
    (5, "Sneha", 27, "Mumbai", "HR", 45000, "2020-05-18", "HR"),
    (6, "Arjun", 26, "Delhi", "Developer", 61000, "2022-07-25", "IT"),
    (7, "Meena", 29, "Hyderabad", "Tester", 53000, "2021-12-11", "QA"),
    (8, "Rahul", 31, "Bangalore", "Architect", 98000, "2019-10-14", "IT"),
    (9, "Pooja", 23, "Chennai", "Support", 40000, "2023-04-19", "Support"),
    (10, "Vikas", 32, "Pune", "Lead", 91000, "2018-06-30", "IT"),

    (11, "Anjali", 26, "Mumbai", "Recruiter", 47000, "2022-02-15", "HR"),
    (12, "Ramesh", 35, "Delhi", "Manager", 105000, "2017-03-11", "Management"),
    (13, "Divya", 24, "Hyderabad", "Analyst", 51000, "2023-06-01", "Analytics"),
    (14, "Suresh", 29, "Chennai", "Developer", 68000, "2021-01-21", "IT"),
    (15, "Lavanya", 27, "Pune", "Tester", 54000, "2020-08-08", "QA"),
    (16, "Mahesh", 33, "Bangalore", "Consultant", 87000, "2019-11-19", "Consulting"),
    (17, "Keerthi", 25, "Mumbai", "HR", 43000, "2022-09-14", "HR"),
    (18, "Naresh", 28, "Delhi", "Engineer", 62000, "2021-05-17", "IT"),
    (19, "Swathi", 26, "Hyderabad", "Developer", 64000, "2022-12-05", "IT"),
    (20, "Ajay", 34, "Chennai", "Lead", 93000, "2018-04-22", "IT"),

    (21, "Bhavana", 22, "Pune", "Intern", 25000, "2024-01-10", "Training"),
    (22, "Nikhil", 30, "Mumbai", "Architect", 99000, "2019-07-09", "IT"),
    (23, "Harsha", 27, "Delhi", "Analyst", 52000, "2022-03-13", "Analytics"),
    (24, "Deepika", 29, "Hyderabad", "Manager", 81000, "2020-10-29", "Management"),
    (25, "Tarun", 31, "Bangalore", "Developer", 71000, "2021-11-01", "IT"),
    (26, "Neha", 24, "Chennai", "Tester", 50000, "2023-02-18", "QA"),
    (27, "Rohit", 28, "Pune", "Support", 42000, "2022-06-25", "Support"),
    (28, "Sanjana", 26, "Mumbai", "Recruiter", 46000, "2021-07-07", "HR"),
    (29, "Manoj", 35, "Delhi", "Director", 120000, "2016-12-15", "Management"),
    (30, "Asha", 23, "Hyderabad", "Intern", 27000, "2024-02-05", "Training"),

    (31, "Vinay", 29, "Bangalore", "Engineer", 67000, "2020-09-19", "IT"),
    (32, "Kavya", 25, "Chennai", "Analyst", 49000, "2023-05-28", "Analytics"),
    (33, "Gopi", 32, "Pune", "Lead", 88000, "2019-01-11", "IT"),
    (34, "Ishita", 27, "Mumbai", "Developer", 69000, "2021-04-04", "IT"),
    (35, "Pradeep", 30, "Delhi", "Consultant", 82000, "2020-03-23", "Consulting"),
    (36, "Sowmya", 24, "Hyderabad", "Tester", 51000, "2022-08-18", "QA"),
    (37, "Chandu", 26, "Bangalore", "Support", 41000, "2023-01-30", "Support"),
    (38, "Nandini", 28, "Chennai", "HR", 44000, "2021-06-16", "HR"),
    (39, "Teja", 31, "Pune", "Architect", 101000, "2018-02-12", "IT"),
    (40, "Madhavi", 29, "Mumbai", "Manager", 83000, "2019-09-27", "Management"),

    (41, "Karthik", 27, "Delhi", "Developer", 73000, "2020-11-05", "IT"),
    (42, "Shilpa", 25, "Hyderabad", "Analyst", 53000, "2023-03-17", "Analytics"),
    (43, "Yash", 33, "Bangalore", "Director", 125000, "2017-08-08", "Management"),
    (44, "Reshma", 26, "Chennai", "Tester", 55000, "2022-10-20", "QA"),
    (45, "Abhi", 24, "Pune", "Intern", 26000, "2024-03-11", "Training"),
    (46, "Nikitha", 28, "Mumbai", "Developer", 70000, "2021-02-14", "IT"),
    (47, "Lokesh", 30, "Delhi", "Lead", 92000, "2019-05-26", "IT"),
    (48, "Anu", 23, "Hyderabad", "Support", 39000, "2023-07-01", "Support"),
    (49, "Sandeep", 34, "Bangalore", "Manager", 97000, "2018-08-15", "Management"),
    (50, "Pallavi", 27, "Chennai", "Engineer", 65000, "2020-12-09", "IT")
]

columns = [
    "emp_id",
    "emp_name",
    "age",
    "city",
    "designation",
    "salary",
    "joining_date",
    "department"
]

df = spark.createDataFrame(data, columns)

df.display()
# 1. Select only emp_name and salary
select_q1 = df.select("emp_name", "salary")

# 2. Select emp_id, emp_name, and department
select_q2 = df.select("emp_id", "emp_name", "department")

# 3. Select city, designation, and salary
select_q3 = df.select("city", "designation", "salary")

# 4. Select all employees from only IT department with selected columns
select_q4 = df.filter(col("department") == "IT").select("emp_id", "emp_name", "department", "salary")

# 5. Select emp_name, joining_date, and salary
select_q5 = df.select("emp_name", "joining_date", "salary")

# 6. Select first 5 columns from dataframe
select_q6 = df.select(df.columns[:5])

# 7. Select employees whose salary column only
select_q7 = df.select("salary")

# 8. Select emp_name and city for employees from Hyderabad
select_q8 = df.filter(col("city") == "Hyderabad").select("emp_name", "city")

# 9. Select designation and department
select_q9 = df.select("designation", "department")

# 10. Select all columns except joining_date
select_q10 = df.drop("joining_date")


# 1. Display emp_name as employee_name
df.select(col("emp_name").alias("employee_name")).show()

# 2. Display salary as monthly_salary
df.select(col("salary").alias("monthly_salary")).show()

# 3. Display department as dept
df.select(col("department").alias("dept")).show()

# 4. Display joining_date as doj
df.select(col("joining_date").alias("doj")).show()

# 5. Select emp_name as name and city as location [cite: 11]
df.select(col("emp_name").alias("name"), col("city").alias("location")).show()

# 6. Display designation as job_role
df.select(col("designation").alias("job_role")).show()

# 7. Display age as employee_age [cite: 11]
df.select(col("age").alias("employee_age")).show()

# 8. Select multiple columns using aliases [cite: 12]
df.select(col("emp_id").alias("id"), col("emp_name").alias("name"), col("salary").alias("income")).show()

# 9. Display salary as emp_salary and department as emp_dept
df.select(col("salary").alias("emp_salary"), col("department").alias("emp_dept")).show()

# 10. Display city as work_location [cite: 12]
df.select(col("city").alias("work_location")).show()


# 1. Filter employees whose salary is greater than 70000
df.filter(col("salary") > 70000).show()

# 2. Filter employees from Hyderabad 
df.filter(col("city") == "Hyderabad").show()

# 3. Filter employees whose age is less than 25 [cite: 14]
df.filter(col("age") < 25).show()

# 4. Filter employees from IT department
df.filter(col("department") == "IT").show()

# 5. Filter employees whose designation is Developer [cite: 14]
df.filter(col("designation") == "Developer").show()

# 6. Filter employees whose salary is between 50000 and 80000 [cite: 15]
df.filter(col("salary").between(50000, 80000)).show()

# 7. Filter employees whose city is Bangalore
df.filter(col("city") == "Bangalore").show()

# 8. Filter employees who joined after 2022-01-01 [cite: 15]
df.filter(col("joining_date") > "2022-01-01").show()

# 9. Filter employees whose age is greater than 30 [cite: 16]
df.filter(col("age") > 30).show()

# 10. Filter employees whose salary is less than 50000
df.filter(col("salary") < 50000).show()

# 11. Filter employees from Chennai and salary greater than 60000 [cite: 16]
df.filter((col("city") == "Chennai") & (col("salary") > 60000)).show()

# 12. Filter employees from Mumbai or Pune
df.filter((col("city") == "Mumbai") | (col("city") == "Pune")).show()

# 13. Filter employees whose name starts with 'S' [cite: 17]
df.filter(col("emp_name").startswith("S")).show()

# 14. Filter employees whose name ends with 'a'
df.filter(col("emp_name").endswith("a")).show()

# 15. Filter employees whose department is HR [cite: 17]
df.filter(col("department") == "HR").show()

# 16. Filter employees whose designation contains 'Engineer' [cite: 18]
df.filter(col("designation").contains("Engineer")).show()

# 17. Filter employees whose city is not Hyderabad
df.filter(col("city") != "Hyderabad").show()

# 18. Filter employees aged between 25 and 30 [cite: 19]
df.filter(col("age").between(25, 30)).show()

# 19. Filter employees with salary greater than 90000
df.filter(col("salary") > 90000).show()

# 20. Filter employees from Support department [cite: 19]
df.filter(col("department") == "Support").show()


# 1. Rename emp_name to employee_name
df.withColumnRenamed("emp_name", "employee_name").show()

# 2. Rename department to dept
df.withColumnRenamed("department", "dept").show()

# 3. Rename joining_date to doj
df.withColumnRenamed("joining_date", "doj").show()

# 4. Rename salary to monthly_salary
df.withColumnRenamed("salary", "monthly_salary").show()

# 5. Rename designation to job_role
df.withColumnRenamed("designation", "job_role").show()

# 6. Rename city to work_location [cite: 21]
df.withColumnRenamed("city", "work_location").show()

# 7. Rename age to employee_age
df.withColumnRenamed("age", "employee_age").show()

# 8. Rename multiple columns one by one [cite: 21]
df.withColumnRenamed("emp_id", "employee_id").withColumnRenamed("emp_name", "employee_name").show()

# 9. Rename emp_id to employee_id
df.withColumnRenamed("emp_id", "employee_id").show()

# 10. Rename department to business_unit 
df.withColumnRenamed("department", "business_unit").show()

# 1. Create bonus column as 10% of salary
df.withColumn("bonus", col("salary") * 0.10).show()

# 2. Create annual_salary column
df.withColumn("annual_salary", col("salary") * 12).show()

# 3. Create tax column as 5% of salary [cite: 23]
df.withColumn("tax", col("salary") * 0.05).show()

# 4. Create updated_salary by adding 5000
df.withColumn("updated_salary", col("salary") + 5000).show()

# 5. Create salary_category column: High, Medium, Low
df.withColumn("salary_category", 
              when(col("salary") > 80000, "High")
              .when(col("salary") >= 50000, "Medium")
              .otherwise("Low")).show()

# 6. Create age_group column: Young, Adult [cite: 23]
df.withColumn("age_group", when(col("age") < 30, "Young").otherwise("Adult")).show()

# 7. Create location column by combining city and department
df.withColumn("location", concat(col("city"), lit(" - "), col("department"))).show()

# 8. Create increment_salary column with 15% hike [cite: 24]
df.withColumn("increment_salary", col("salary") * 1.15).show()

# 9. Create experience_status column based on joining year
df.withColumn("experience_status", when(year(col("joining_date")) < 2021, "Experienced").otherwise("Newcomer")).show()

# 10. Create name_length column using employee name [cite: 24]
df.withColumn("name_length", length(col("emp_name"))).show()

# 11. Create is_high_salary column using condition [cite: 25]
df.withColumn("is_high_salary", col("salary") > 80000).show()

# 12. Create joining_year column from joining_date
df.withColumn("joining_year", year(col("joining_date"))).show()

# 13. Create salary_after_tax column
df.withColumn("salary_after_tax", col("salary") * 0.95).show()

# 14. Create department_code column [cite: 25]
df.withColumn("department_code", concat(lit("DEPT_"), col("department"))).show()

# 15. Create double_salary column
df.withColumn("double_salary", col("salary") * 2).show()


# 1. Convert salary to string datatype
df.withColumn("salary", col("salary").cast("string")).show()

# 2. Convert age to double datatype
df.withColumn("age", col("age").cast("double")).show()

# 3. Convert joining_date to date datatype
df.withColumn("joining_date", col("joining_date").cast("date")).show()

# 4. Convert emp_id to string datatype 
df.withColumn("emp_id", col("emp_id").cast("string")).show()

# 5. Convert salary to integer datatype [cite: 27]
df.withColumn("salary", col("salary").cast("integer")).show()

# 6. Convert age to string datatype
df.withColumn("age", col("age").cast("string")).show()

# 7. Convert joining_date to timestamp datatype [cite: 27]
df.withColumn("joining_date", col("joining_date").cast("timestamp")).show()

# 8. Convert salary to float datatype
df.withColumn("salary", col("salary").cast("float")).show()

# 9. Convert emp_id to long datatype 
df.withColumn("emp_id", col("emp_id").cast("long")).show()

# 10. Convert multiple columns into different datatypes
df.withColumn("age", col("age").cast("double")).withColumn("salary", col("salary").cast("float")).show()



# 1. Sort employees by salary ascending
df.orderBy(col("salary").asc()).show()

# 2. Sort employees by salary descending [cite: 29]
df.orderBy(col("salary").desc()).show()

# 3. Sort employees by age descending
df.orderBy(col("age").desc()).show()

# 4. Sort employees by emp_name ascending [cite: 29]
df.orderBy(col("emp_name").asc()).show()

# 5. Sort employees by city and salary descending [cite: 30]
df.orderBy(col("city").asc(), col("salary").desc()).show()

# 6. Sort employees by joining_date
df.orderBy(col("joining_date").asc()).show()

# 7. Sort employees by department
df.orderBy(col("department").asc()).show()

# 8. Sort employees by designation descending [cite: 30]
df.orderBy(col("designation").desc()).show()

# 9. Sort employees first by city then age [cite: 31]
df.orderBy(col("city").asc(), col("age").asc()).show()

# 10. Sort employees by salary and limit top 10
df.orderBy(col("salary").desc()).limit(10).show()

# 11. Sort employees by emp_id descending [cite: 31]
df.orderBy(col("emp_id").desc()).show()

# 12. Sort employees from IT department by salary descending [cite: 32]
df.filter(col("department") == "IT").orderBy(col("salary").desc()).show()

# 13. Sort employees by joining_date descending
df.orderBy(col("joining_date").desc()).show()

# 14. Sort employees alphabetically by emp_name [cite: 32]
df.orderBy(col("emp_name").asc()).show()

# 15. Sort employees by multiple columns 
df.orderBy(col("department").asc(), col("designation").asc(), col("salary").desc()).show()                                                                                       



# 1. Display first 5 records
df.limit(5).show()

# 2. Display top 10 employees
df.limit(10).show()

# 3. Display first 3 employees from IT department 
df.filter(col("department") == "IT").limit(3).show()

# 4. Display top 5 highest salary employees [cite: 34]
df.orderBy(col("salary").desc()).limit(5).show()

# 5. Display lowest 5 salary employees
df.orderBy(col("salary").asc()).limit(5).show()

# 6. Display first 7 rows after sorting by age [cite: 34]
df.orderBy(col("age").asc()).limit(7).show()

# 7. Display first 2 employees from Hyderabad [cite: 35]
df.filter(col("city") == "Hyderabad").limit(2).show()

# 8. Display first 15 records from dataframe
df.limit(15).show()

# 9. Display top 5 youngest employees [cite: 35]
df.orderBy(col("age").asc()).limit(5).show()

# 10. Display first 8 employees after filtering salary > 60000 [cite: 36]
df.filter(col("salary") > 60000).limit(8).show()
