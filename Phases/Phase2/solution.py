# =========================================
# EXERCISE 1: Total order amount for each customer
# =========================================
print("Exercise 1 - PySpark Output:")
ex1_pyspark = sales.groupBy("customer_id") \
    .agg(sum(col("total_amount").cast("double")).alias("total_order_amount")) \
    .orderBy(col("total_order_amount").desc())

ex1_pyspark.show()


# =========================================
# EXERCISE 2: Top 3 customers by total spend
# =========================================
print("Exercise 2 - PySpark Output:")
ex2_pyspark = customers.join(sales, on="customer_id", how="inner") \
    .groupBy("customer_id", "first_name", "last_name") \
    .agg(sum(col("total_amount").cast("double")).alias("total_spend")) \
    .orderBy(col("total_spend").desc()) \
    .limit(3)

ex2_pyspark.show()


# ==========================================
# EXERCISE 3: Customers with no orders
# ==========================================
print("Exercise 3 - PySpark Output:")
# Using a clean left_anti join to represent left excluding joins
ex3_pyspark = customers.join(sales, on="customer_id", how="left_anti") \
    .select("customer_id", "first_name", "last_name")

ex3_pyspark.show()


# ==========================================
# EXERCISE 4: City-wise total revenue
# ==========================================
print("Exercise 4 - PySpark Output:")
ex4_pyspark = customers.join(sales, on="customer_id", how="inner") \
    .groupBy("city") \
    .agg(sum(col("total_amount").cast("double")).alias("total_revenue"))

ex4_pyspark.show()


# ==========================================
# EXERCISE 5: Average order amount per customer
# ==========================================
print("Exercise 5 - PySpark Output:")
ex5_pyspark = sales.groupBy("customer_id") \
    .agg(avg(col("total_amount").cast("double")).alias("avg_order_amount"))

ex5_pyspark.show()


# ==========================================
# EXERCISE 6: Customers with more than one order
# ==========================================
print("Exercise 6 - PySpark Output:")
ex6_pyspark = sales.groupBy("customer_id") \
    .agg(count("sale_id").alias("order_count")) \
    .filter(col("order_count") > 1)

ex6_pyspark.show()


# ==========================================
# EXERCISE 7: Sort customers by total spend descending
# ==========================================
print("Exercise 7 - PySpark Output:")
ex7_pyspark = customers.join(sales, on="customer_id", how="inner") \
    .groupBy("customer_id", "first_name", "last_name") \
    .agg(sum(col("total_amount").cast("double")).alias("total_spend")) \
    .orderBy(col("total_spend").desc())

ex7_pyspark.show()
