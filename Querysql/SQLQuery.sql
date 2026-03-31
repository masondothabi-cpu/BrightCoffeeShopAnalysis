---------------------------------------------------------
---CHECK WHAT IS CONTAINED WITHIN YOUR DATA
---------------------------------------------------------

SELECT * FROM workspace.default.1773682225332_bright_coffee_shop_analysis_case_study_1;
---------------------------------------------------------
----Size of the data
---------------------------------------------------------

SELECT COUNT(*) AS number_raws,
COUNT (DISTINCT transaction_id) AS number_of_sales
FROM workspace.default.1773682225332_bright_coffee_shop_analysis_case_study_1;


--------------------------------------------------------------------------------
---1. Checking Start and End date of sales -- 6 months data (2023-01 to 2023-06)
--------------------------------------------------------------------------------

SELECT MIN(transaction_date) AS start_date,
       MAX(transaction_date) AS End_date 
FROM workspace.default.1773682225332_bright_coffee_shop_analysis_case_study_1;

--------------------------------------------------------------------------
---Exploring product detail, further expand it to unit cost per prod detail
-------------------------------------------------------------------------
SELECT Distinct product_category , product_detail, product_type
      FROM workspace.default.1773682225332_bright_coffee_shop_analysis_case_study_1;
  
---------------------------------------------------------------------
--- Checking product sold, Which products generate most revenue?
-------------------------------------------------------------------

SELECT Distinct product_category,
 SUM (transaction_qty*unit_price ) AS Product_Revenue
 FROM workspace.default.1773682225332_bright_coffee_shop_analysis_case_study_1
 Group By Product_Category;

---------------------------------------------------------------------------
---Checking stores locations (lOWER Manhattan, Hell's kitchen and Astoria)
---------------------------------------------------------------------------

SELECT COUNT (DISTINCT (store_location))
FROM workspace.default.1773682225332_bright_coffee_shop_analysis_case_study_1;

------------------------------------------------------------------------------
-----Checking the cheapest product
------------------------------------------------------------------------------

SELECT MIN(unit_price) AS cheap_product
FROM workspace.default.1773682225332_bright_coffee_shop_analysis_case_study_1;

------------------------------------------------------------------------------
---GROUP BY product_category;
-------------------------------------------------------------------------------

SELECT max(unit_price) AS Expensive_product
FROM workspace.default.1773682225332_bright_coffee_shop_analysis_case_study_1;

---------------------------------------------------------------------------------
 --- Average performance time of each store each day
---------------------------------------------------------------------------------

 SELECT Distinct store_location,
   AVG(transaction_time) AS Store_Performance
   FROM workspace.default.1773682225332_bright_coffee_shop_analysis_case_study_1
   Group By store_location;

---------------------------------------------------------------------------------------
---CHECKING Ttransactions, product and stores
---------------------------------------------------------------------------------------

   SELECT COUNT(*) AS number_raws,
    COUNT (DISTINCT transaction_id) AS number_of_sales,
    COUNT (DISTINCT store_id) AS stores,
    COUNT (DISTINCT product_id) AS product
FROM workspace.default.1773682225332_bright_coffee_shop_analysis_case_study_1;

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

SELECT * FROM workspace.default.1773682225332_bright_coffee_shop_analysis_case_study_1;

SELECT 
transaction_date, 
Dayname(transaction_date) AS Day_name,
Monthname(transaction_date) AS Month_name,
Date_format(transaction_time, 'HH:MM:SS') AS purchase_time,
Dayofmonth(transaction_date) AS day_of_month,

CASE
WHEN Dayname(transaction_date) IN ('Sat','Sat') THEN 'Weekend'
ELSE 'Weekday'
END AS Day_class,

CASE
WHEN date_format(transaction_time, 'HH:MM:SS') BETWEEN '00:00:00' AND '11:59:59' THEN '01. MORNING'
WHEN date_format(transaction_time, 'HH:MM:SS') BETWEEN '12:00:00' AND '16:59:59' THEN '02. AFTERNOON'
WHEN date_format(transaction_time, 'HH:MM:SS') >= '17:00:00' THEN '03. EVENING'
END AS time_buckets,

--- Counts
COUNT(DISTINCT transaction_id) AS number_of_sales,
COUNT(DISTINCT product_id) As number_of_sales,
COUNT(DISTINCT store_id) As number_of_stores,
--- Revenue
SUM(transaction_qty*unit_price) AS revenue_per_day,

CASE 
WHEN revenue_per_day <= 50 THEN '01. LOW SPEND'
WHEN revenue_per_day BETWEEN 51 AND 100 THEN '02. MEDIUM SPEND'
ELSE '03. HIGH SPEND'
END AS Spend_bucket,

---------------------------------------------------------------------
--- Catergorial Data
---------------------------------------------------------------------    
    Store_location,
    Product_category,
    Product_detail
FROM workspace.default.1773682225332_bright_coffee_shop_analysis_case_study_1
GROUP BY transaction_date,
         Day_name,
         day_of_month,
         Store_location,
         product_category,
         product_detail,
         Month_name,
         purchase_time;

-------------------------------------------------------------------------------------
---CATERGORICAL COLUMNS: store_location, product_category, product type
-------------------------------------------------------------------------------------
