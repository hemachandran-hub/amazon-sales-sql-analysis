# Amazon E-Commerce Sales Data Analysis Project

An end-to-end data exploration, cleaning, and business intelligence project built using **MySQL Workbench**. This repository features structured database schema design, data validation, advanced SQL transformations, and complex analytical queries to extract actionable insights from an Amazon e-commerce sales dataset.

---

## 🛠️ Tech Stack & Tools
* **Database Management System:** MySQL / MySQL Workbench
* **Language:** SQL (DDL, DML, Window Functions, Joins, Aggregations)
* **Version Control:** Git & GitHub

---

## 📂 Project Workflow & Structure

### 1. Schema Design & Table Creation (`DDL`)
* Designed a relational table structure (`amazon`) optimized for transactional sales data.
* Implemented primary keys, auto-increment fields, precise decimal allocations for currency/ratings, and standard date-time formats.

### 2. Data Exploration & Quality Checks
* Audited raw records to inspect unique product brands, categories, and subcategories.
* Validated core revenue streams and calculated baseline metrics (total sales, average order value, average ratings).
* Identified and verified missing value patterns to maintain dataset integrity.

### 3. Data Cleaning & Transformation (`DML`)
* Inspected delivery and return statuses (`is_returned`, `delivery_status`).
* Added a derived column (`purchase_year`) using date manipulation functions to isolate yearly trends.

---

## 📊 Key Business Questions & Analytical Solutions

This project addresses several core analytical business problems using advanced SQL techniques:

* **Q1: Revenue by Category** — Evaluates total revenue generated per category, sorted in descending order (`SUM`, `GROUP BY`, `ORDER BY`).
* **Q2: Return Rates by Payment Method** — Computes the percentage of returned orders across different payment mechanisms using nested inline views and joins.
* **Q3: Peak Order Hours** — Extracts time-based patterns to identify the exact hour of the day customers place the highest volume of orders.
* **Q4: Order Value Segmentation** — Categorizes transactions into `Low`, `Medium`, and `High` price bands using conditional logic (`CASE` statements).
* **Q5: Monthly Performance (2025)** — Aggregates order counts and total revenues month-by-month for the year 2025.
* **Q6: Benchmarking Against Average** — Filters high-value orders surpassing the overall catalog average utilizing subqueries and window functions (`COUNT(*) OVER ()`).
* **Q7: Seller Performance Filtering** — Isolates low-rated sellers (`avg_rating < 3`) with significant order volumes (`> 3`) using group-level filtering (`HAVING`).
* **Q8: Intra-Category Price Comparison** — Identifies individual orders priced higher than their respective category averages via correlated dataset joins.
* **Q9: Top Revenue Brand per Category** — Utilizes window ranking functions (`RANK() OVER (PARTITION BY ... ORDER BY ... DESC)`) to find the top-performing brand in every product category.
* **Q10: Repeat Customer Latest Orders** — Tracks the most recent purchase date and time for customers with multiple orders using partitioning window logic.
* **Q11: Return Distribution Proportions** — Calculates precise proportional percentages of returned items mapped against specific payment methodologies.

---

## 🚀 How to Run the Project
1. Open **MySQL Workbench** or your preferred MySQL client.
2. Execute the table creation block from `amazon project.sql` to initialize the database schema and structure.
3. Import your Amazon e-commerce dataset into the `amazon` table.
4. Run the exploratory and business query blocks sequentially to review outputs and analytics.

---
