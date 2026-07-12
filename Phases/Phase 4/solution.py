# Initialize Spark session
from pyspark.sql import SparkSession
import pyspark.sql.functions as F
spark = SparkSession.builder.appName('Spark Playground').getOrCreate()

# Load the customers.csv dataset
from pyspark.sql.functions import col
from pyspark.sql.types import DoubleType
customers = spark.read.format('csv').option('header', 'true').load('/samples/customers.csv')
orders=spark.read.format('csv').option('header', 'true').load('/samples/sales.csv')
# Ensure total_amount is treated as a number
sales_numeric_df = orders.withColumn("total_amount", col("total_amount").cast(DoubleType()))
# Calculate the total spend per customer
total_spend_df = sales_numeric_df.groupBy("customer_id").agg(
    F.sum("total_amount").alias("total_spend")
)
#View the raw total spend results
total_spend_df.show(5)
from pyspark.sql.functions import col, when
# 1.Implementing conditional logic
segmented_df = total_spend_df.withColumn(
    "segment",
    when(col("total_spend") > 10000, "Gold")
    .when((col("total_spend") >= 5000) & (col("total_spend") <= 10000), "Silver")
    .otherwise("Bronze")
)
segmented_df.show()
#2. Group Data by Segment and Count Customers
segment_counts = segmented_df.groupby("segment").count()
segment_counts.show()

# 3.Find the exact spending splits for 3 equal-sized tiers
splits = total_spend_df.approxQuantile("total_spend", [0.33, 0.66], 0.0)

# Apply these dynamic splits using conditional logic
quantile_segmented_df = total_spend_df.withColumn(
    "quantile_segment",
    when(col("total_spend") <= splits[0], "Low Spend")
    .when((col("total_spend") > splits[0]) & (col("total_spend") <= splits[1]), "Medium Spend")
    .otherwise("High Spend")
)
quantile_segmented_df.show(5)
