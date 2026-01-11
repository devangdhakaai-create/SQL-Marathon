# SQL-Marathon

SQL Pizza Sales Data Analysis Project

Overview
This project involves an end-to-end data analysis of pizza sales using SQL. The primary goal is to demonstrate practical SQL skills, from data import and preparation to executing complex queries for deriving valuable business insights. This project showcases how SQL can be used to analyze sales trends, customer preferences, and operational efficiency within a business context.

Objective
The main objectives of this project are:

To import and manage CSV datasets within a MySQL environment.
To perform various data analysis tasks using SQL queries.
To extract meaningful insights from raw sales data to aid business decisions.
To showcase SQL proficiency for data analysis roles.
Dataset
The dataset used for this project is a Pizza Sales dataset, provided in CSV format and structured into four main tables:

orders: Contains information about each order (Order ID, Date, Time).
order_details: Details of items in each order (Order Detail ID, Order ID, Pizza ID, Quantity).
pizzas: Information about individual pizzas (Pizza ID, Pizza Type ID, Size, Price).
pizza_types: Details about pizza types (Pizza Type ID, Name, Category, Ingredients).
The dataset was initially in CSV format and was imported into MySQL for analysis.

Tools and Technologies
Database Management System: MySQL
SQL Client: MySQL Workbench
Language: SQL (Structured Query Language)
Key Analyses and Queries
This project covers a comprehensive range of SQL queries, demonstrating various concepts such as JOIN operations, GROUP BY clauses, aggregate functions (COUNT, SUM, AVG), ORDER BY, LIMIT, and more advanced SQL techniques.

Basic Queries
Retrieve the total number of orders placed.

SELECT COUNT(order_id) AS Total_Orders FROM orders;
Calculate the total revenue generated from pizza sales.

SELECT ROUND(SUM(order_details.quantity * pizzas.price), 2) AS Total_Revenue FROM order_details JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id;
Identify the highest-priced pizza.

SELECT pizza_types.name, pizzas.price FROM pizza_types JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id ORDER BY pizzas.price DESC LIMIT 1;
Identify the most common pizza size ordered.

SELECT pizzas.size, COUNT(order_details.order_details_id) AS Order_Count FROM pizzas JOIN order_details ON pizzas.pizza_id = order_details.pizza_id GROUP BY pizzas.size ORDER BY Order_Count DESC LIMIT 1;
List the top 5 most ordered pizza types along with their quantities.

SELECT pizza_types.name, SUM(order_details.quantity) AS Quantity FROM pizza_types JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id JOIN order_details ON order_details.pizza_id = pizzas.pizza_id GROUP BY pizza_types.name ORDER BY Quantity DESC LIMIT 5;
Intermediate Queries
Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT pizza_types.category, SUM(order_details.quantity) AS Quantity FROM pizza_types JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id JOIN order_details ON order_details.pizza_id = pizzas.pizza_id GROUP BY pizza_types.category ORDER BY Quantity DESC;
Determine the distribution of orders by hour of the day.

SELECT HOUR(order_time) AS Hour, COUNT(order_id) AS Order_Count FROM orders GROUP BY Hour ORDER BY Hour;
Join relevant tables to find the category-wise distribution of pizzas.

SELECT category, COUNT(name) AS Pizza_Count FROM pizza_types GROUP BY category;
Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT orders.order_date, SUM(order_details.quantity) AS Quantity_Ordered FROM orders JOIN order_details ON orders.order_id = order_details.order_id GROUP BY orders.order_date ORDER BY orders.order_date;
Determine the top 3 most ordered pizza types based on revenue.

(Note: This query would involve joining order_details and pizzas, calculating quantity * price, grouping by pizza type name, summing the revenue, and ordering to get the top 3.)
SELECT pt.name AS Pizza_Type, SUM(od.quantity * p.price) AS Total_Revenue FROM order_details od JOIN pizzas p ON od.pizza_id = p.pizza_id JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id GROUP BY pt.name ORDER BY Total_Revenue DESC LIMIT 3;
Advanced Queries
Calculate the percentage contribution of each pizza type to total revenue.

(Note: This query requires calculating total revenue for each pizza type and dividing by the overall total revenue, often using subqueries or CTEs.)
WITH PizzaRevenue AS ( SELECT pt.name AS Pizza_Type, SUM(od.quantity * p.price) AS Revenue FROM order_details od JOIN pizzas p ON od.pizza_id = p.pizza_id JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id GROUP BY pt.name ), TotalOverallRevenue AS ( SELECT SUM(od.quantity * p.price) AS TotalRevenue FROM order_details od JOIN pizzas p ON od.pizza_id = p.pizza_id ) SELECT pr.Pizza_Type, pr.Revenue, (pr.Revenue / tor.TotalRevenue) * 100 AS Percentage_Contribution FROM PizzaRevenue pr, TotalOverallRevenue tor ORDER BY Percentage_Contribution DESC;
Analyze the cumulative revenue generated over time.

(Note: This query typically uses window functions (e.g., SUM() OVER()) to calculate a running total of revenue by date.)
SELECT order_date, SUM(DailyRevenue) OVER (ORDER BY order_date) AS Cumulative_Revenue FROM ( SELECT o.order_date, SUM(od.quantity * p.price) AS DailyRevenue FROM orders o JOIN order_details od ON o.order_id = od.order_id JOIN pizzas p ON od.pizza_id = p.pizza_id GROUP BY o.order_date ) AS DailySales ORDER BY order_date;
Determine the top 3 most ordered pizza types based on revenue for each pizza category.

(Note: This query requires using window functions like ROW_NUMBER() or RANK() partitioned by category to find the top items within each group.)
WITH RankedPizzaRevenue AS ( SELECT pt.category, pt.name AS Pizza_Type, SUM(od.quantity * p.price) AS Total_Revenue, ROW_NUMBER() OVER (PARTITION BY pt.category ORDER BY SUM(od.quantity * p.price) DESC) AS rn FROM order_details od JOIN pizzas p ON od.pizza_id = p.pizza_id JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id GROUP BY pt.category, pt.name ) SELECT category, Pizza_Type, Total_Revenue FROM RankedPizzaRevenue WHERE rn <= 3 ORDER BY category, Total_Revenue DESC;
How to Run the Project
Clone the Repository:
bash
git clone

(Replace `` with your actual GitHub repository URL.)

Download Dataset: The CSV files for the dataset can be found [here]https://github.com/Ayushi0214/pizza-sales---SQL.

Import into MySQL:

Create a new database (e.g., pizza_hut) in MySQL Workbench.
Use the "Table Data Import Wizard" to import each CSV file (orders, order_details, pizzas, pizza_types) into the respective tables. For larger tables like orders and order_details, it's recommended to create the table schema manually with appropriate data types (e.g., DATE, TIME, INT, VARCHAR) before importing, as demonstrated in the video.
Execute Queries: Once the data is imported, you can run the SQL queries provided in the project files (or copy them from this README) in your MySQL Workbench.

Insights and Findings
Through this project, insights into pizza sales performance can be gained, such as:

Identification of peak order times (e.g., afternoon and evening hours).
Understanding of customer preferences for pizza sizes and types.
Calculation of overall business metrics like total revenue and order count.
Analysis of category popularity, showing which types of pizzas are most frequently ordered.
Detailed breakdown of revenue contribution by individual pizza types and categories.
Insights into sales trends over time for strategic planning.