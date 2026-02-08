create database Pizza_DB;

use Pizza_DB;

select * from pizza_sales;


# KPI Requirements For Cross Check
# Total Revenue
select round(sum(total_price),2) as Total_revenue from pizza_sales;

# Average order 
select round(sum(total_price) /count(distinct order_id) ,2) from pizza_sales;


# Total quantity
select sum(quantity ) as Total_Pizza_Sold from pizza_sales;

# Total Orders
select count(order_id) as Total_Order from pizza_sales;

# Average Order
select round(sum(quantity)/count(distinct order_id),2) as Avg_Pizza_Per_Order from pizza_sales;


# Charts Requirements
# Daily Trend For Total Order
select dayname(order_date) as Order_Day ,count(distinct order_id) as Total_Order
from pizza_sales
group by Order_Day 
order by field(
Order_Day,
'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'
);


describe pizza_sales;

SET SQL_SAFE_UPDATES = 0;

update pizza_sales
set order_date =str_to_date(order_date,"%d-%m-%Y");

SET SQL_SAFE_UPDATES =1;

# Monthly Trend for Toatl Order
select monthname(order_date) as Month_Order,
count(distinct order_id) as Total_Order
from pizza_sales
group by Month_Order;

select * from pizza_sales;

# Percentage of Sales by Category
select pizza_category ,round(sum(total_price),2) as Total_Sales, round(sum(total_price) * 100/(select sum(total_price) from pizza_sales),2) as percentage_of_sales
from pizza_sales
group by pizza_category;

# Percentage of Sales by Size 
select pizza_size , round(round(sum(total_price),2) * 100/ (select round(sum(total_price),2) from pizza_sales),2) as PCT
from pizza_sales
group by pizza_size;


# Top 5 by Best Sellers by revenue ,total quantity ,total order
select pizza_name,sum(total_price) as Total_revenue,
sum(quantity) as Total_Quantity ,
count(distinct order_id) as Total_Order
from pizza_sales
group by pizza_name
order by Total_revenue,Total_Quantity,Total_Order desc
limit 5 ;