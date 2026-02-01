USE GREAT
SELECT * from [Online Retail Data Set]

--to determine the  country generating the highest revenue
select top 1 country,sum(revenue) as Total_revenue from [Online Retail Data Set]Group by country order by Total_revenue Desc

--to determine the country generatying the lowest revenue
select top 1 country,sum(revenue) as Total_revenue from [Online Retail Data Set]Group by country order by Total_revenue Asc 

--to determine the top 3 months with the most revenue
select top 3  Datename(month,invoicedate) as month, sum(revenue) as total_revenue from [Online Retail Data Set] group by datename(month, invoicedate) order by total_revenue desc

-- to determine top 10 customers that generate the most revenue plus their number of orders and number of items bought
select top 10 customerid, sum(revenue) as customer_revenue,COUNT(distinct invoiceno) as number_of_orders, count(*) as number_of_items from [Online Retail Data Set] where customerid is not null group by customerid order by customer_revenue desc 

--to detemine the top 10 countries that has the most demands for products and the revenue generated
select top 10 country,sum(revenue) as Total_revenue, sum(convert(int, quantity)) as total_quantity from [Online Retail Data Set] Group by Country order by Total_revenue desc;


-- to determine the percentage of customers who are repeating their orders and if they order same products or different products
WITH RepeatCustomers AS (
SELECT
customerid,
COUNT(DISTINCT invoiceno) AS order_count,
COUNT(DISTINCT stockcode) AS unique_products
FROM [Online Retail Data Set]
WHERE customerid IS NOT NULL
GROUP BY customerid
HAVING COUNT(DISTINCT invoiceno) > 1
)
SELECT
SUM(CASE WHEN unique_products = 1 THEN 1 ELSE 0 END) AS customers_same_product,
SUM(CASE WHEN unique_products > 1 THEN 1 ELSE 0 END) AS customers_different_products,
COUNT(*) AS total_repeat_customers,
CAST(SUM(CASE WHEN unique_products = 1 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100 AS pct_same_product,
CAST(SUM(CASE WHEN unique_products > 1 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100 AS pct_different_products
FROM RepeatCustomers;

--to determine total number of customers
select count(distinct customerid) as total_customers from [Online Retail Data Set] where CustomerID is not null