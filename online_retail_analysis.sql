-- ========================================================
-- ONLINE RETAIL E-COMMERCE ANALYSIS PROJECT
-- Author: Fathima Wafa K P
-- Purpose: Clean and analyze transactional retail data
-- ========================================================

-- STEP 1: Database Initialization
CREATE DATABASE IF NOT EXISTS ecommerce_project;
USE ecommerce_project;

-- STEP 2: Data Cleaning & Formatting (Creating the Clean View)
-- This creates a dynamic view to fix date formats and remove null customer records.
CREATE OR REPLACE VIEW clean_online_retail AS
SELECT 
    InvoiceNo,
    StockCode,
    Description,
    CAST(Quantity AS SIGNED) AS Quantity,
    STR_TO_DATE(InvoiceDate, '%d-%m-%Y %H:%i') AS InvoiceDateTime,
    CAST(UnitPrice AS DECIMAL(10,2)) AS UnitPrice,
    CustomerID,
    Country
FROM online_retail
WHERE 
    CustomerID IS NOT NULL 
    AND CustomerID != ''
    AND Description IS NOT NULL 
    AND Description != ''
    AND CAST(Quantity AS SIGNED) > 0
    AND CAST(UnitPrice AS DECIMAL(10,2)) > 0;
    
    -- STEP 3: Business Analysis - Total and Monthly Revenue Trends
-- Calculates revenue and unique order counts grouped by year and month.
SELECT 
    DATE_FORMAT(InvoiceDateTime, '%Y-%m') AS SalesMonth,
    ROUND(SUM(Quantity * UnitPrice), 2) AS MonthlyRevenue,
    COUNT(DISTINCT InvoiceNo) AS TotalOrders
FROM clean_online_retail
GROUP BY DATE_FORMAT(InvoiceDateTime, '%Y-%m')
ORDER BY SalesMonth;


-- STEP 4: Product Performance - Top 10 Products by Total Sales
-- Identifies the highest revenue-generating products in the store.
SELECT 
    Description,
    SUM(Quantity) AS TotalQuantitySold,
    ROUND(SUM(Quantity * UnitPrice), 2) AS TotalSalesRevenue
FROM clean_online_retail
GROUP BY Description
ORDER BY TotalSalesRevenue DESC
LIMIT 10;


-- STEP 5: Geographic Analysis - Top 10 Countries by Total Revenue
-- Calculates total revenue, total orders, and average order value for each country.
SELECT 
    Country,
    ROUND(SUM(Quantity * UnitPrice), 2) AS TotalRevenue,
    COUNT(DISTINCT InvoiceNo) AS TotalOrders,
    ROUND(SUM(Quantity * UnitPrice) / COUNT(DISTINCT InvoiceNo), 2) AS AvgOrderValue
FROM clean_online_retail
GROUP BY Country
ORDER BY TotalRevenue DESC
LIMIT 10;


-- STEP 6: Customer Loyalty Analysis - Repeat Customers & Purchase Frequency
-- Identifies customer retention metrics: how many times customers return to buy.
SELECT 
    CustomerID,
    Country,
    COUNT(DISTINCT InvoiceNo) AS TotalPurchases,
    ROUND(SUM(Quantity * UnitPrice), 2) AS TotalSpent,
    CASE 
        WHEN COUNT(DISTINCT InvoiceNo) > 1 THEN 'Repeat Customer'
        ELSE 'One-Time Customer'
    END AS CustomerType
FROM clean_online_retail
GROUP BY CustomerID, Country
ORDER BY TotalPurchases DESC;


-- STEP 7: Executive Summary - Overall Retention Rate
-- Aggregates the customer data to calculate the total percentage of repeat buyers.
SELECT 
    CustomerType,
    COUNT(CustomerID) AS TotalUniqueCustomers,
    ROUND(COUNT(CustomerID) * 100.0 / SUM(COUNT(CustomerID)) OVER(), 2) AS PercentageOfCustomerBase
FROM (
    -- This is our subquery from Step 6 that groups transactions into customer categories
    SELECT 
        CustomerID,
        CASE 
            WHEN COUNT(DISTINCT InvoiceNo) > 1 THEN 'Repeat Customer'
            ELSE 'One-Time Customer'
        END AS CustomerType
    FROM clean_online_retail
    GROUP BY CustomerID
) AS customer_groups
GROUP BY CustomerType;


-- STEP 8: High-Value Customer Analysis - Ranking Customers by Spending
-- Uses a window function to rank individual customers based on their total monetary contribution.
SELECT 
    CustomerID,
    Country,
    ROUND(SUM(Quantity * UnitPrice), 2) AS TotalCustomerSpending,
    RANK() OVER (ORDER BY SUM(Quantity * UnitPrice) DESC) AS CustomerSpendRank
FROM clean_online_retail
GROUP BY CustomerID, Country;