-- Captsone 1
-- Texas Sales Territory Analysis
-- Analyst: Ashraf Salimu
-- Database: sample_sales

SELECT *
FROM store_locations
WHERE State = 'Texas';

--Number of Store in Texas
SELECT COUNT(*) AS Total_Texas_Stores
FROM store_locations
WHERE State = 'Texas';

-- Store Sales Data

SELECT *
FROM store_sales;

-- Texas Sales Sales, Texas store ID's are between 901 and 911
SELECT *
FROM store_sales
WHERE Store_ID BETWEEN 901 AND 911;

-- Identifying sales data time frame
SELECT MIN(Transaction_Date) AS First_Sale_Date, MAX(Transaction_Date) AS Last_Sale_Date
FROM store_sales
WHERE Store_ID BETWEEN 901 AND 911;

-- Texas total sales revenue
SELECT SUM(Sale_Amount) AS Total_Texas_Revenue
FROM store_sales
WHERE Store_ID BETWEEN 901 AND 911
AND Transaction_Date BETWEEN '2022-01-01' AND '2025-12-31';


-- Texas Annual Sales revenue
SELECT year(Transaction_Date) AS Sales_Year, SUM(Sale_Amount) AS Annual_Revenue
FROM store_sales
WHERE Store_ID BETWEEN 901 AND 911
AND Transaction_Date BETWEEN '2022-01-01' AND '2025-12-31'
GROUP BY YEAR(Transaction_Date)
ORDER BY Sales_Year;

-- Revenue by Texas Store
SELECT Store_ID, SUM(Sale_Amount) AS Store_Revenue
FROM store_sales
WHERE Store_ID BETWEEN 901 AND 911
AND Transaction_Date BETWEEN '2022-01-01' AND '2025-12-31'
GROUP BY Store_ID
ORDER BY Store_Revenue DESC;

-- Average Sale amount by Texas store
SELECT Store_ID, COUNT(*) AS Toatal_Transactions, AVG(Sale_Amount) AS Average_sale
FROM store_sales
WHERE Store_ID BETWEEN 901 AND 911
AND Transaction_Date BETWEEN '2022-01-01' AND '2025-12-31'
GROUP BY Store_ID
ORDER BY Average_sale DESC;

-- Annual revenue by Texas Store
SELECT Store_ID, YEAR(Transaction_Date) AS Sales_Year, SUM(Sale_Amount) Annual_Revenue
FROM store_sales
WHERE Store_ID BETWEEN 901 AND 911
AND Transaction_Date BETWEEN '2022-01-01' AND '2025-12-31'
GROUP BY Store_ID, YEAR(Transaction_Date)
ORDER BY Store_ID, Sales_Year;

-- Monthly Texas Sales Revenue
SELECT YEAR(Transaction_Date) AS Sales_Year, MONTH (Transaction_Date) AS Sales_Month, SUM(Sale_Amount) AS Monthly_Revenue
FROM store_sales
WHERE Store_ID BETWEEN 901 AND 911
AND Transaction_Date BETWEEN '2022-01-01' AND '2025-12-31'
GROUP BY YEAR(Transaction_Date), MONTH (Transaction_Date)
ORDER BY Sales_Year, Sales_Month;


--Management Regions
SELECT *
FROM management

-- South Region stores
SELECT *
FROM store_locations
WHERE State IN ('Florida', 'South Carolina', 'Texas')
ORDER BY State, StoreId

-- Total South Region Revenue(2022-2025)
SELECT SUM(Sale_Amount) AS South_Region_Revenue
FROM store_sales
WHERE (Store_ID BETWEEN 719 AND 729
OR Store_ID BETWEEN 852 AND 853 
OR Store_ID BETWEEN 901 AND 911)
AND Transaction_Date BETWEEN '2022-01-01' AND '2025-12-31';

-- South Region revenue by State
SELECT CASE WHEN Store_ID BETWEEN 719 AND 729 THEN 'Florida'
WHEN Store_ID BETWEEN 852 AND 853 THEN 'South Carolina'
WHEN Store_ID BETWEEN 901 AND 911 THEN 'Texas'
END AS State,
SUM(Sale_Amount) AS Total_Revenue
FROM store_sales
WHERE (Store_ID BETWEEN 719 AND 729
OR Store_ID BETWEEN 852 AND 853 
OR Store_ID BETWEEN 901 AND 911)
AND Transaction_Date BETWEEN '2022-01-01' AND '2025-12-31'
GROUP BY State
ORDER BY Total_Revenue DESC;

SELECT *
FROM inventory_categories

-- Monthly Transactions and Average Sales by Product Category
SELECT YEAR(store_sales.Transaction_Date) AS Sales_Year,
   MONTH(store_sales.Transaction_Date) AS Sales_Month,
   inventory_categories.Category,
   COUNT(*) AS Total_Transactions,
   ROUND(AVG(store_sales.Sale_Amount), 2) AS Average_Sale
FROM store_sales
JOIN products
   ON store_sales.Prod_Num = products.ProdNum
JOIN inventory_categories
   ON products.Categoryid = inventory_categories.Categoryid
WHERE store_sales.Store_ID BETWEEN 901 AND 911
AND store_sales.Transaction_Date BETWEEN '2022-01-01' AND '2025-12-31'
GROUP BY
   YEAR(store_sales.Transaction_Date),
   MONTH(store_sales.Transaction_Date),
   inventory_categories.Category
ORDER BY
   Sales_Year,
   Sales_Month,
   inventory_categories.Category; 
   
   
-- Texas Store Sales Ranking (2022-2025)
SELECT store_locations.StoreLocation, store_sales.Store_ID, SUM(store_sales.Sale_Amount) AS Total_Revenue, COUNT(*) AS Total_Transactions,
 AVG(store_sales.Sale_Amount) AS Average_Sale
FROM store_sales
JOIN store_locations 
   ON store_sales.Store_ID = store_locations.StoreId
WHERE store_locations.State = 'Texas'
AND store_sales.Transaction_Date BETWEEN '2022-01-01' AND '2025-12-31'

GROUP BY store_locations.StoreLocation, store_sales.Store_ID
ORDER BY Total_Revenue DESC;

-- Dallas Store Sales Activity
SELECT Store_ID, MIN(Transaction_Date) AS First_Sale, MAX(Transaction_Date) AS Last_Sale, COUNT(*) AS Total_Transactions, SUM(Sale_Amount) AS Total_Revenue
FROM store_sales
WHERE Store_ID = 907
GROUP BY Store_ID;

-- Dallas Annual Sales Perfomance
SELECT  YEAR (Transaction_Date) AS Sales_Year, COUNT(*) AS Total_Transactions, SUM(Sale_Amount) AS Annual_Revenue
FROM store_sales
WHERE Store_ID = 907
GROUP BY YEAR (Transaction_Date)
ORDER BY Sales_Year;