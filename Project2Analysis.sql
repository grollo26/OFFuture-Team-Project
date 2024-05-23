-- Q32 Sales by year
-- Using extract to get the year from the order date, then grouping the orders by year and working out total sales for each year
SELECT
	EXTRACT(YEAR FROM order_date) order_year,
	round(Sum(sales)::decimal,2)
FROM
	student.groupby_offuture_v2
GROUP BY
	order_year
ORDER BY
	order_year

-- Q34 Sales by month
-- See Q34, but this time grouping by year and month
SELECT
	EXTRACT(YEAR FROM order_date) order_year,
	EXTRACT(MONTH  FROM order_date) order_month,
	round(Sum(sales)::decimal,2)
FROM
	student.groupby_offuture_v2
GROUP BY
	order_year,
	order_month
ORDER BY
	order_year,
	order_month
	
-- Q12 Sales by quarter
-- See Q32 and Q34, grouping by year and quarter
SELECT
	EXTRACT(YEAR FROM order_date) order_year,
	EXTRACT(QUARTER  FROM order_date) order_quarter,
	round(Sum(sales)::decimal,2)
FROM
	student.groupby_offuture_v2
GROUP BY
	order_year,
	order_quarter
ORDER BY
	order_year,
	order_quarter
	
-- Q13 Profit by year
SELECT
	EXTRACT(YEAR FROM order_date) order_year,
	round(Sum(profit)::decimal,2)
FROM
	student.groupby_offuture_v2
GROUP BY
	order_year
ORDER BY
	order_year
	
-- Q14 Profit by month
SELECT
	EXTRACT(YEAR FROM order_date) order_year,
	EXTRACT(MONTH  FROM order_date) order_month,
	round(Sum(profit)::decimal,2)
FROM
	student.groupby_offuture_v2
GROUP BY
	order_year,
	order_month
ORDER BY
	order_year,
	order_month
	
-- Q15 Profit by quarter
SELECT
	EXTRACT(YEAR FROM order_date) order_year,
	EXTRACT(QUARTER  FROM order_date) order_quarter,
	round(Sum(profit)::decimal,2)
FROM
	student.groupby_offuture_v2
GROUP BY
	order_year,
	order_quarter
ORDER BY
	order_year,
	order_quarter
	
-- Q16 Most sold products
-- Grouping by product name and finding which products sold the most
SELECT 
	product_name ,
	sum(quantity) total_quantity 
FROM 
	student.groupby_offuture_v2 
GROUP BY 
	product_name 
Order BY 
	total_quantity DESC
LIMIT 15

-- Q17 Most profitable products
-- See Q16, this time with profit rather than sales
SELECT 
        product_name ,
        sum(profit) total_profit 
FROM 
        student.groupby_offuture_v2 
GROUP BY 
        product_name 
Order BY 
        total_profit DESC 
LIMIT 15 ; 

-- Q18 Least sold products
SELECT 
        product_name ,
        sum(quantity) total_quantity 
FROM 
        student.groupby_offuture_v2 
GROUP BY 
        product_name 
Order BY 
        total_quantity DESC
LIMIT 15 ;

-- Q19 least profitable products         
SELECT 
	product_name ,
	sum(profit) total_profit 
FROM 
	student.groupby_offuture_v2 
GROUP BY 
	product_name 
Order BY 
	total_profit ASC 
LIMIT 15 ; 

-- Q20 Sales by city
select
	city,
	round(Sum(sales)::decimal,2) sales_by_city
FROM
	student.groupby_offuture_v2
GROUP BY
	city
ORDER BY
	sales_by_city desc,
	city ASC

-- Q21 Sales by region
SELECT
	market,
	region,
	round(Sum(sales)::decimal,2)
FROM
	student.groupby_offuture_v2
GROUP BY
	market,
	region
ORDER BY
	market,
	region ASC
	
	
-- Q22 Unprofitable products
-- Selecting products which made a loss overall
SELECT 
	product_name ,
	sum(profit) total_profit 
FROM 
	student.groupby_offuture_v2 
GROUP BY 
	product_name 
HAVING 
	sum(profit) < -0
Order BY 
	total_profit ASC 
	
-- Q23 Unprofitable countries
-- Selecting countries in which the company made an overall loss 
SELECT 
	country ,
	sum(profit) total_profit 
FROM 
	student.groupby_offuture_v2 
GROUP BY 
	country 
HAVING 
	sum(profit) < -0
Order BY 
	total_profit ASC 
	
-- Q24 Sales by segment
select
	segment,
	round(Sum(sales)::decimal,2)
FROM
	student.groupby_offuture_v2
GROUP BY
	segment
ORDER BY
	segment ASC
	
-- Q25 Sales by country
select
	country,
	round(Sum(sales)::decimal,2) total_sales,
	avg(profit)
FROM
	student.groupby_offuture_v2
GROUP BY
	country
ORDER BY
	round(Sum(sales)::decimal,2) DESC
	
--- Q26 Sales by category
SELECT 
	category,
	round(Sum(sales)::decimal,2) total_sales,
	round(Sum(profit)::decimal,2) total_profit
FROM
	student.groupby_offuture_v2 gov 
GROUP BY
	category
ORDER BY total_sales

--- Q26 Sales by sub-category
SELECT 
	category,
	subcategory,
	round(Sum(sales)::decimal,2) total_sales,
	round(Sum(profit)::decimal,2) total_profit
FROM
	student.groupby_offuture_v2 gov 
GROUP BY
	category,
	subcategory 
ORDER BY total_sales desc
	
--- Q27 Counts of key figures
select 
	round(Sum(sales)::decimal,2) total_sales,
	round(Sum(profit)::decimal,2) total_profit,
	count(distinct(customer_id)) number_of_customers,
	count(distinct(country)) countries_serviced,
	count(distinct(product_id)) number_of_products
from student.groupby_offuture go2

-- Q28 Most discounted products
--- Finding products which had the largest average discount
SELECT  
	product_name  ,
	AVG(discount) average_discount,
	sum(profit) profit_made,
	sum(quantity) n_sold,
	count(row_id) n_orders
FROM
	student.groupby_offuture_v2  
GROUP BY 
	product_name 
ORDER BY 
	avg(discount) DESC
	
-- Q29 Most discounted countries
SELECT 
	country,
	avg(discount)
FROM
	student.groupby_offuture_v2 
GROUP BY
	country
ORDER BY 
	avg(discount) DESC
	
-- Q32 Finding unprofitable product 
SELECT  
	category ,
	subcategory,
	sum(profit)
FROM
	student.groupby_offuture_v2 
GROUP BY 
	category, subcategory
ORDER BY 
	sum(profit) DESC
	
-- Q31 Are tables a loss leader?
-- Finding the total profit made from the other purchases of those who bought tables, since the table subcategory was identified as one which made an overall loss
select 
	segment,
	avg(profit)
from 	student.groupby_offuture_v2
where customer_id in 
	(SELECT  
	customer_id
	from student.groupby_offuture_v2 go2 
	WHERE subcategory = 'Tables') -- List of people who bought products in the table subcategory
GROUP BY
	segment

-- Q33 finding the minimum, maximum and average length for each text column
SELECT 
	min(length(order_id)) order_id_min,
	max(length(order_id)) order_id_max,
	avg(length(order_id)) order_id_avg
FROM 
	student.groupby_offuture_v2 gjov 

SELECT 
	min(length(ship_mode)),
	max(length(ship_mode)),
	avg(length(ship_mode))
FROM 
	student.groupby_offuture_v2 gjov 
	
SELECT 
	min(length(customer_id)),
	max(length(customer_id)),
	avg(length(customer_id))
FROM 
	student.groupby_offuture_v2 gjov 
	
SELECT 
	min(length(customer_name)),
	max(length(customer_name)),
	avg(length(customer_name))
FROM 
	student.groupby_offuture_v2 gjov 
	
SELECT 
	min(length(segment)),
	max(length(segment)),
	avg(length(segment))
FROM 
	student.groupby_offuture_v2 gjov 
	
SELECT 
	min(length(city)),
	max(length(city)),
	avg(length(city))
FROM 
	student.groupby_offuture_v2 gjov 
	
SELECT 
	min(length(country)),
	max(length(country)),
	avg(length(country))
FROM 
	student.groupby_offuture_v2 gjov 
	
SELECT 
	min(length(state)),
	max(length(state)),
	avg(length(state))
FROM 
	student.groupby_offuture_v2 gjov 

SELECT 
	min(length(market)),
	max(length(market)),
	avg(length(market))
FROM 
	student.groupby_offuture_v2 gjov 
	
SELECT 
	min(length(region)),
	max(length(region)),
	avg(length(region))
FROM 
	student.groupby_offuture_v2 gjov 

SELECT 
	min(length(product_id)),
	max(length(product_id)),
	avg(length(product_id))
FROM 
	student.groupby_offuture_v2 gjov 
	
SELECT 
	min(length(category)),
	max(length(category)),
	avg(length(category))
FROM 
	student.groupby_offuture_v2 gjov 

SELECT 
	min(length(subcategory)),
	max(length(subcategory)),
	avg(length(subcategory))
FROM 
	student.groupby_offuture_v2 gjov 
	
SELECT 
	min(length(product_name)),
	max(length(product_name)),
	avg(length(product_name))
FROM 
	student.groupby_offuture_v2 gjov 
	
SELECT 
	min(length(order_priority)),
	max(length(order_priority)),
	avg(length(order_priority))
FROM 
	student.groupby_offuture_v2 gjov 
	
SELECT count(customer_id) FROM student.groupby_offuture_v2 gov 