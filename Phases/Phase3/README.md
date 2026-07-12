# SQL to PySpark Phase 3: Final ETL & Pipeline

This folder contains the code for Phase 3 . The goal is to move from isolated queries to an end-to-end data engineering workflow using Extract-Transform-Load (ETL) principles[cite: 1].

## 🎯 Phase 3 Tasks
All tasks are implemented in both **Spark SQL** and **PySpark** using datasets from the Spark Playground[cite: 1].

### 1. Hands-on Ingestion Tasks
* **Read & Inspect:** Ingest CSV datasets, preview rows (`show()`), and check structures (`printSchema()`)[cite: 1].
* **Clean & Filter:** Detect missing values, drop or fill nulls (`dropna()`), and filter out invalid records[cite: 1].

### 2. Business Pipeline Exercises
* **Daily Sales:** Cleans missing transaction entries to calculate total daily revenue[cite: 1].
* **City-wise Revenue:** Joins customer data with sales to find out which cities generate the most money[cite: 1].
* **Repeat Customers:** Groups orders to find loyal customers with more than 2 purchases[cite: 1].
* **Highest Spender Per City:** Uses window functions to identify the single highest-spending customer in each city[cite: 1].
* **Final Reporting Table:** Builds a master data mart tracking customer details, city, total spend, and total order counts[cite: 1].
