Select * from pizza_sales;

-- 1. KPIs

-- a. Total Revenue

Select Cast(Sum(total_price) as decimal (10,2)) as Total_Revenue 
from pizza_sales;

-- b. Average Order Value

Select CAST(Sum(total_price) / Count(Distinct order_id) AS decimal (10,2)) as AVG_Order_Val
from pizza_sales;

-- c. Total Pizzas Sold

Select Sum(quantity) as Total_Pizzas_Sold
from pizza_sales
Where MONTH(order_date) = 1;

-- d. Total Orders

Select Count(Distinct order_id) as Total_Orders
from pizza_sales;

-- e. Average Pizzas Per Order

Select CAST( Cast(Sum(quantity) as Decimal(10,2)) / 
Cast(Count(Distinct order_id) as Decimal(10,2)) AS Decimal (10,2))
from pizza_sales;

-- 2. Daily Trends

Select DATENAME(DW,order_date) as order_day, Count(distinct order_id) as Total_Orders
from pizza_sales
Group by DATENAME(DW,order_date);

-- 3. Hourly Trends for total order

Select DATEPART(HOUR,order_time) as order_hours, Count(distinct order_id) as Total_Orders
from pizza_sales
Group by DATEPART(HOUR,order_time)
Order by 1 ASC;

-- 4. Percentage of sales by Pizza Category 

Select pizza_category , Cast(SUM(total_price)* 100 / (Select Sum(total_price) from pizza_sales) as decimal (10,2)) as PCT_sales
from pizza_sales
Group by pizza_category 

-- 5. Percentage of sales by Pizza Size

Select pizza_size, Cast(Sum(total_price) * 100 /  (Select SUM(total_price) from pizza_sales) as decimal (10,2)) as PCT_sales
FROM pizza_sales
Group by pizza_size
order by Sum(total_price) desc;

-- 6. Total Pizzas Sold by Pizza Category

Select pizza_category, Sum(quantity) as Pizza_Sold
from pizza_sales
group by pizza_category

-- 7. Top 5 Best Sellers by Pizzas Sold 

Select Top 5 pizza_name , Sum(quantity) as Pizza_Sold
from pizza_sales
group by pizza_name
Order By Sum(quantity) desc;

-- 8. Bottom 5 Worst Sellers by Pizzas Sold 

Select Top 5 pizza_name , Sum(quantity) as Pizza_Sold
from pizza_sales
group by pizza_name
Order By Sum(quantity) ASC;
