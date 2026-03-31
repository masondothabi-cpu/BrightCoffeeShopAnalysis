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


--- Catergorial Data
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
