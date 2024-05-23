--Q01 Table creation
CREATE TABLE student.groupby_offuture_v2 (
	row_id int,
	order_id varchar(40),
	order_date varchar(20),
	ship_date varchar(20),
	ship_mode varchar(40),
	customer_id varchar(40),
	customer_name varchar(40),
	segment varchar(40),
	city varchar(50),
	state varchar(50),
	country varchar(50),
	postal_code int,
	market varchar(20),
	region varchar(40),
	product_id varchar(40),
	category varchar(40),
	subcategory varchar(40),
	product_name varchar(150),
	sales float,
	quantity int,
	discount float,
	profit float,
	shipping_cost float,
	order_priority varchar(30)
	);

SELECT * FROM student.groupby_offuture_v2 gov LIMIT 100

-- Q02 Row Count
SELECT count(row_id) FROM student.groupby_offuture_v2 ;

-- Q03 Column count
SELECT 
	count(*)
FROM 
	information_schema.COLUMNS
WHERE 
	table_name = 'groupby_offuture_v2';
	
-- Q04 Distinct row count
SELECT count(DISTINCT(row_id)) FROM student.groupby_offuture_v2 go2 

-- Q05 Sum of row sums
SELECT 
	ROUND(sum((case when row_id is null then 0 else row_id end)+
	(CASE WHEN postal_code is null then 0 else postal_code end)+
	(CASE WHEN sales is null then 0 else sales end)+
	(CASE WHEN quantity is null then 0 else quantity end)+
	(CASE WHEN discount is null then 0 else discount end)+
	(CASE WHEN profit is null then 0 else profit end)+
	(CASE WHEN shipping_cost is null then 0 else shipping_cost end))::decimal,3)
from student.groupby_offuture_v2 go2

-- Q06 Sum of column sums
select
	round((sum(row_id) + sum(postal_code)+ sum(sales) + sum(quantity) + sum(discount)+ sum(profit) + sum(shipping_cost))::decimal,3)
from student.groupby_offuture_v2 go2


--Q07 Date format correction

--Converting text into date structure
SELECT 
	ship_date,
	to_date(ship_date, 'dd-mm-yyyy')
FROM
	student.groupby_offuture_v2
	
UPDATE
	student.groupby_offuture_v2
SET 
	order_date = to_date(order_date, 'dd-mm-yyyy'),
	ship_date = to_date(ship_date, 'dd-mm-yyyy')

-- Altering the table to cast those columns into dates
ALTER TABLE student.groupby_offuture_v2
ALTER COLUMN order_date
TYPE date
USING order_date::date

ALTER TABLE student.groupby_offuture_v2
ALTER COLUMN ship_date
TYPE date
USING ship_date::date


--Q08 Column min, max and sum
-- finding the min (numeric columns casted to decimals in order to round them)
select
	round(MIN(row_id):: decimal , 3) id, 
	MIN(order_date),
	MIN(ship_date),
	round(MIN(postal_code):: decimal, 3) postal_code, 
	round(MIN(sales):: decimal ,3) sales  ,  
	round(MIN(quantity):: decimal, 3) quantity ,   
	round(MIN(discount):: decimal ,3) discount  ,
	round(MIN(profit)::decimal, 3) profit  , 
	round(MIN(shipping_cost):: decimal, 3) shopping_cost
from student.groupby_offuture_v2 go2;

-- finding the max (numeric columns casted to decimals in order to round them)
select
	round(MAX(row_id):: decimal , 3) id, 
	MAX(order_date),
	MAX(ship_date),
	round(MAX(postal_code):: decimal, 3) postal_code, 
	round(MAX(sales):: decimal ,3) sales  ,  
	round(MAX(quantity):: decimal, 3) quantity ,   
	round(MAX(discount):: decimal ,3) discount  ,
	round(MAX(profit)::decimal, 3) profit  , 
	round(MAX(shipping_cost):: decimal, 3) shopping_cost
from student.groupby_offuture_v2 go2;

-- finding the sum (numeric columns casted to decimals in order to round them)
select
	round(sum(row_id):: decimal , 3) id, 
	round(sum(postal_code):: decimal, 3) postal_code, 
	round(sum(sales):: decimal ,3) sales  ,  
	round(sum(quantity):: decimal, 3) quantity ,   
	round(sum(discount):: decimal ,3) discount  ,
	round(sum(profit)::decimal, 3) profit  , 
	round(sum(shipping_cost):: decimal, 3) shopping_cost
from student.groupby_offuture_v2 go2 ;


-- Q09 Count of nulls per column
-- For each column we find the total number of rows minus the number of entries in that column to find the nulls
SELECT
(COUNT(*) - COUNT(row_id)) row_id_nulls,
(COUNT(*) - COUNT(order_id)) order_id_nulls,
(COUNT(*) - COUNT(order_date)) order_date_nulls,
(COUNT(*) - COUNT(ship_date)) ship_date_nulls,
(COUNT(*) - COUNT(ship_mode)) ship_mode_nulls,
(COUNT(*) - COUNT(customer_id)) customer_id_nulls,
(COUNT(*) - COUNT(customer_name)) customer_name_nulls,
(COUNT(*) - COUNT(segment)) segment_nulls,
(COUNT(*) - COUNT(city)) city_nulls,
(COUNT(*) - COUNT(state)) state_nulls,
(COUNT(*) - COUNT(country)) country_nulls,
(COUNT(*) - COUNT(postal_code)) postal_code_nulls,
(COUNT(*) - COUNT(market)) market_nulls,
(COUNT(*) - COUNT(region)) region_nulls,
(COUNT(*) - COUNT(product_id)) product_id_nulls,
(COUNT(*) - COUNT(category)) ategory_nulls,
(COUNT(*) - COUNT(subcategory)) sub_category_nulls,
(COUNT(*) - COUNT(product_name)) product_name_nulls,
(COUNT(*) - COUNT(sales)) sales_nulls,
(COUNT(*) - COUNT(quantity)) quantity_nulls,
(COUNT(*) - COUNT(discount)) discount_nulls,
(COUNT(*) - COUNT(profit)) profit_nulls,
(COUNT(*) - COUNT(shipping_cost) shipping_cost_nulls,
(COUNT(*) - COUNT(order_priority)) order_priority_nulls
FROM
student.groupby_offuture;

-- Q10 Checking number of characters in row 16, to compare with source data
SELECT 
    LENGTH(
        CONCAT(
            row_id::text,
            order_id::text,
            --order_date::text,
            --ship_date::text,
            ship_mode,
            customer_id,
            customer_name,
            segment,
            city,
            state,
            country,
            postal_code::text,
            market,
            region,
            product_id,
            category,
            subcategory,
            product_name,
            sales::text,
            quantity::text,
            discount::text,
            profit::text,
            shipping_cost::text,
            order_priority
        )
    ) AS TotalCharacterCount
FROM 
    student.groupby_offuture_v2
WHERE 
    row_id = 16;
   
 --- Q11 Counting total number of decimal places
  -- Per column
SELECT 
  SUM(length(substring(cast(sales as text) from '\..*$')) - 1) as sum_of_sales_decimal_places,
  SUM(length(substring(cast(discount as text) from '\..*$')) - 1) as sum_discount_decimal_places,
  SUM(length(substring(cast(profit as text) from '\..*$')) - 1) as sum_profit_decimal_places,
  SUM(length(substring(cast(shipping_cost as text) from '\..*$')) - 1 )as sum_shipping_cost_decimal_places
FROM 
	student.groupby_offuture_v2 gjov;

-- In whole document
SELECT 
	sum(sales_decimal_places)+sum(discount_decimal_places) +sum(profit_decimal_places) + sum(shipping_cost_decimal_places)
FROM 
(SELECT 
  length(substring(cast(sales as text) from '\..*$')) - 1 as sales_decimal_places,
  length(substring(cast(discount as text) from '\..*$')) - 1 as discount_decimal_places,
  length(substring(cast(profit as text) from '\..*$')) - 1 as profit_decimal_places,
  length(substring(cast(shipping_cost as text) from '\..*$')) - 1 as shipping_cost_decimal_places
FROM 
  student.groupby_offuture_v2 gjov) dec_places
   
SELECT * FROM student.groupby_offuture_v2 gov WHERE row_id = 16

SELECT 
* 
FROM 
student.groupby_offuture_v2
WHERE 
product_name = 'Xerox 199'














