

SELECT * FROM pizza_sales

--Total Revenue
SELECT SUM(total_price) AS Total_Revenue from pizza_sales

--Average Order Value
SELECT SUM(total_price)/ COUNT(DISTINCT order_id) AS Avg_order_value from pizza_sales

--Total Pizzas Sold
SELECT SUM(quantity) AS Total_Pizza_Sold from pizza_sales

--Total orders
SELECT COUNT(DISTINCT order_id)  AS Total_orders from pizza_sales

--Average Pizza per Order
SELECT CAST(CAST ( SUM(quantity) AS DECIMAL (10,2)) /
CAST(COUNT (DISTINCT order_id) AS DECIMAL (10,2)) AS DECIMAL (10,2)) Avg_pizza_per_order from pizza_sales 

-- Daily Trend for total orders
SELECT DATENAME(DW, order_date) as order_day, COUNT(DISTINCT order_id) AS Total_orders
from pizza_sales
GROUP BY DATENAME(DW, order_date)

-- Hourly Trend of total orders
select DATEPART(HOUR, order_time)  AS order_hours, COUNT(DISTINCT order_id) AS Total_orders
from pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)

--percentage of sales by pizza category
SELECT pizza_category, sum(total_price) as Total_sales, sum(total_price)*100/(SELECT sum(total_price) from pizza_sales WHERE MONTH(order_date)=3) AS Percent_Total_Sales
from pizza_sales 
GROUP BY pizza_category

--Percentage of sales by pizza size
SELECT pizza_size, CAST (sum(total_price) as decimal(10,2)) as Total_sales, cast(sum(total_price) * 100 /
(SELECT sum(total_price) from pizza_sales)AS decimal (10,2)) AS PTS
from pizza_sales 
GROUP BY pizza_size
ORDER BY PTS DESC

--Total pizza sold
SELECT pizza_category, sum(quantity) as Total_Pizzas_Sold
from pizza_sales
Group by pizza_category

--Top 5 best seller pizzas
SELECT TOP 5 pizza_name, sum(quantity) as Total_Pizzas_Sold
from pizza_sales
Group BY pizza_name
ORDER BY sum(quantity) DESC

--Top 5 worst selling pizzas
SELECT TOP 5 pizza_name, sum(quantity) as Total_Pizzas_Sold
from pizza_sales
Group BY pizza_name
ORDER BY sum(quantity)