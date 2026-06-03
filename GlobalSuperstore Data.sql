CREATE DATABASE superstore_db;
USE superstore_db;
CREATE TABLE global_superstore2 (
    Row_ID INT,
    Order_ID VARCHAR(50),
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode VARCHAR(50),
    Customer_ID VARCHAR(50),
    Customer_Name VARCHAR(100),
    Segment VARCHAR(50),
    Country VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50),
    Postal_Code VARCHAR(20),
    Market VARCHAR(50),
    Region VARCHAR(50),
    Product_ID VARCHAR(50),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Product_Name VARCHAR(255),
    Sales DECIMAL(10,2),
    Quantity INT,
    Discount DECIMAL(4,2),
    Profit DECIMAL(10,2)
);

-- NULL check
SELECT * FROM global_superstore2
WHERE Sales IS NULL OR Profit IS NULL;
-- Date format check
SELECT 'Order Date', 'Ship Date' FROM global_superstore2;
-- Duplicate check
SELECT 'Order ID', COUNT(*)
FROM global_superstore2
GROUP BY 'Order ID'
HAVING COUNT(*) > 1;

SELECT COUNT(*) global_superstore2;

SELECT * FROM global_superstore2;

DESCRIBE global_superstore2;

-- Total Sales
SELECT SUM(Sales) AS Total_Sales
FROM global_superstore2;

-- Toatal Profit
SELECT SUM(Profit) AS Total_Profit
FROM global_superstore2;

-- Total Quantity
SELECT SUM(Quantity) AS Total_Quantity
FROM global_superstore2;

-- Avg Quantity
SELECT AVG(Quantity) AS Avg_Quantity
FROM global_superstore2;

-- Total Customers
SELECT COUNT(DISTINCT 'Customer ID') AS Total_Customers
FROM global_superstore2;

-- Avg Discount
SELECT AVG(Discount) AS Avg_Discount
FROM global_superstore2;

-- Total Shipment
SELECT COUNT(DISTINCT 'Order ID') AS Total_Shipments
FROM global_superstore2;

-- Bar Chart(Profit by Category)
SELECT 
    Category,
    SUM(Profit) AS Total_Profit
FROM global_superstore2
GROUP BY Category
ORDER BY Total_Profit DESC;

-- Line Chart(Sales and Profit over Years)
SELECT 
    YEAR('Order Date') AS Year,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM global_superstore2
GROUP BY YEAR('Order Date')
ORDER BY Year;

-- Map (Country-wise Sales)
SELECT 
    Country,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM global_superstore2
GROUP BY Country;

-- Pie Chart → Profit by Order Priority
SELECT 
    'Order Priority',
    SUM(Profit) AS Total_Profit
FROM global_superstore2
GROUP BY 'OrderPriority';

-- Tree Map → Sales by Sub-Category
SELECT 
    'Sub Category',
    SUM(Sales) AS Total_Sales
FROM global_superstore2
GROUP BY 'Sub Category';

-- Ribbon Chart → Market & Category by Shipping Cost
SELECT 
    Market,
    Category,
    SUM(
        CASE 
            WHEN 'Ship Mode' = 'Standard Class' THEN Sales * 0.05
            WHEN 'Ship Mode' = 'Second Class' THEN Sales * 0.10
            WHEN 'Ship Mode' = 'First Class' THEN Sales * 0.15
            WHEN 'Ship Mode' = 'Same Day' THEN Sales * 0.20
        END
    ) AS 'Shipping Cost'
FROM global_superstore2
GROUP BY Market, Category;

-- KPI → Actual vs Target Sales
SELECT 
    YEAR(`Order Date`) AS Year,
    SUM(Sales) AS Actual_Sales,
    SUM(Sales) * 1.1 AS Target_Sales   -- 10% growth target
FROM global_superstore2
GROUP BY YEAR('Order Date');

-- Matrix Table
SELECT 
    Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    SUM(
        CASE 
            WHEN 'Ship Mode' = 'Standard Class' THEN Sales * 0.05
            WHEN 'Ship Mode' = 'Second Class' THEN Sales * 0.10
            WHEN 'Ship Mode' = 'First Class' THEN Sales * 0.15
            WHEN 'Ship Mode' = 'Same Day' THEN Sales * 0.20
        END
    ) AS 'Shipping Cost'
FROM global_superstore2
GROUP BY Category;

-- Slicers
SELECT *
FROM global_superstore2
WHERE Category = 'Furniture'
  AND Market = 'Asia Pacific'
  AND Segment = 'Consumer'
  AND YEAR('Order Date') = 2022;