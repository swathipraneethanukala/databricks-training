# Initialize Spark session
from pyspark.sql import SparkSession
spark = SparkSession.builder.appName('Spark Playground').getOrCreate()

# Load the customers.csv dataset
customers = spark.read.format('csv').option('header', 'true').load('/samples/customers.csv')
orders=spark.read.format('csv').option('header', 'true').load('/samples/sales.csv')
from pyspark.sql import functions as F
# Read and clean sales data
sales_df = spark.read.format("csv").option("header", "true").load("/samples/sales.csv") # Example path
clean_sales_df = sales_df.dropna(subset=["sale_id", "sale_date", "total_amount"])

# 1. Calculate daily sales
daily_sales = clean_sales_df.groupBy("sale_date") \
    .agg(
        F.round(F.sum("total_amount"), 2).alias("daily_sales_amount"),
        F.count("sale_id").alias("total_orders")
    ) \
    .orderBy("sale_date")

daily_sales.show()
from pyspark.sql import functions as F
#Clean customers
clean_customers_df = customers.dropna(subset=["customer_id", "city"])

# Join and aggregate city revenue
city_revenue = clean_customers_df.join(sales_df, on="customer_id", how="inner") \
    .groupBy("city") \
    .agg(F.round(F.sum("total_amount"), 2).alias("total_revenue")) \
    .orderBy(F.col("total_revenue").desc())
#2.citywise revenue
city_revenue.show()
# 3.Find repeat customers
repeat_customers = sales_df.groupBy("customer_id") \
    .agg(F.count("sale_id").alias("order_count")) \
    .filter(F.col("order_count") > 2) \
    .orderBy(F.col("order_count").desc())

repeat_customers.show()

#5.Total spend per customer per city
from pyspark.sql.window import Window
customer_spend_df = customers.join(sales_df, on="customer_id", how="inner") \
    .groupBy(
        "city", 
        "customer_id", 
        F.concat_ws(" ", "first_name", "last_name").alias("customer_name")
    ) \
    .agg(F.sum("total_amount").alias("total_spend"))

# Window specification to rank spenders per city
city_window = Window.partitionBy("city").orderBy(F.col("total_spend").desc())

#Filter for top spender
highest_spending_customers = customer_spend_df \
    .withColumn("rank", F.row_number().over(city_window)) \
    .filter(F.col("rank") == 1) \
    .drop("rank")

highest_spending_customers.show()

final_reporting_table = customers.join(sales_df, on="customer_id", how="left") \
    .groupBy(
        "customer_id", 
        F.concat_ws(" ", "first_name", "last_name").alias("customer_name"),
        "city"
    ) \
    .agg(
        F.coalesce(F.sum("total_amount"), F.lit(0)).alias("total_spend"),
        F.count("sale_id").alias("order_count")
    ) \
    .orderBy(F.col("total_spend").desc())

#5.Preview final output
final_reporting_table.show()
