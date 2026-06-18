# 🛒 E-Commerce Sales Performance Analysis

## ℹ️ Description:

* This project focuses on cleaning and analyzing a large online retail database using SQL.
* It shows core database operations including data cleaning, handling missing values, changing date formats, and running advanced business queries using real-world e-commerce data.

\---

## 📖 Table of Contents:

* Project Overview
* Data Source Description
* Tools and Technologies
* Key Insights
* Recommendations
* How to Use
* Author

\---

## 📘 Project Overview:

* Cleaned and analyzed a transactional retail dataset using SQL by creating a filtered view to fix data types.
* Performed data operations and queries using aggregations, subqueries, and window functions to find sales trends and customer behaviors.

\---

## 📂 Data Source:

* The database consists of one main flat table named `online\_retail` which contains:

  * Invoice Number (`InvoiceNo`)
  * Product Code (`StockCode`)
  * Product Description (`Description`)
  * Quantity Sold (`Quantity`)
  * Invoice Date and Time (`InvoiceDate`)
  * Unit Price (`UnitPrice`)
  * Customer ID (`CustomerID`)
  * Country (`Country`)

\---

## 🛠️ Tools \& Technologies:

The following tools and technologies were used in this project:

### SQL (MySQL)

* Database management and running queries using MySQL Workbench.
* Using SQL Views for clean data filtering.

### Advanced SQL Concepts

* `STR\_TO\_DATE()` for converting text strings into true dates.
* `CAST()` for changing text types into integers and decimals.
* `GROUP BY` and `ORDER BY` clauses for data aggregation.
* Window functions like `RANK() OVER()` and `SUM() OVER()` for customer tracking.

\---

## 🔍 Key Insights

* **Best-Selling Product:** The absolute top revenue-generating item is the **"REGENCY CAKESTAND 3 TIER"**, bringing in over £164,000 in sales.
* **Sales Seasonality:** Business sales peak massively in **November** due to holiday shopping surges, reaching over £1.1 Million, while **April** is one of the slowest months.
* **Core Market:** The **United Kingdom** is the biggest market by a huge margin, contributing over 80% of total company revenue.
* **Customer Loyalty:** Out of all unique shoppers, over **74% are Repeat Customers** who buy from the store multiple times.
* **VIP Shoppers:** Using window functions, **Customer ID 14646** was identified as the highest-ranking shopper, spending an amazing £279,489.

\---

## 💡 Recommendations

* **Stock Management:** Increase inventory levels for top items like the 3-Tier Cakestand well before the November holiday rush to prevent running out of stock.
* **Target Marketing:** Focus special discount offers and loyalty rewards on the 26% one-time buyers to convert them into repeat customers.
* **International Growth:** Create targeted promotions for secondary markets like the Netherlands and Germany, as they show very high average order values.

\---

## ▶️ How to Use

* Create the database schema (`ecommerce\_project`).
* Import the raw transactional dataset into the `online\_retail` table.
* Execute the SQL Master Script step-by-step in MySQL Workbench.
* Read the generated results grids to analyze business insights.

\---

## 👩‍💻 Author

* \[Fathima Wafa K P]

