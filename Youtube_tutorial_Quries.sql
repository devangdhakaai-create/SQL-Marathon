Baseic 
-- Retrieve the total number of orders placed.
SELECT
COUNT(order_id) AS total_orders
FROM
orders;
Result: The total number of orders placed is 21,350.

Calculate the total revenue generated from pizza sales.
SELECT
ROUND(SUM(order_details.quantity * pizzas.price), 2) AS total_sales
FROM
order_details
JOIN
pizzas ON pizzas.pizza_id = order_details.pizza_id;
Result: The total revenue generated is 817,860.05.

Identify the highest-priced pizza.
SELECT
pizza_types.name,
pizzas.price
FROM
pizza_types
JOIN
pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY
pizzas.price DESC
LIMIT 1;
Result: The highest-priced pizza is the The Greek Pizza with a price of 35.95.

Identify the most common pizza size ordered. 
SELECT
pizzas.size,
COUNT(order_details.order_details_id) AS order_count
FROM
pizzas
JOIN
order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY
pizzas.size
ORDER BY
order_count DESC
LIMIT 1;
Result: The most common pizza size ordered is Large.

List the top 5 most ordered pizza types along with their quantities. 
SELECT
pizza_types.name,
SUM(order_details.quantity) AS quantity
FROM
pizza_types
JOIN
pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN
order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY
pizza_types.name
ORDER BY
quantity DESC
LIMIT 5;
Result:
Classic Deluxe Pizza: 2,453
Barbecue Chicken Pizza: 2,432
Hawaiian Pizza: 2,422
Pepperoni Pizza: 2,418
Thai Chicken Pizza: 2,370

-- Intermediate Queries section:
-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT
pizza_types.category,
SUM(order_details.quantity) AS quantity
FROM
pizza_types
JOIN
pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN
order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY
pizza_types.category
ORDER BY
quantity DESC;
Result:
Classic: 14,888
Supreme: 11,947
Veggie: 11,623
Chicken: 11,050

Determine the distribution of orders by hour of the day.
SELECT
HOUR(order_time) AS hour,
COUNT(order_id) AS order_count
FROM
orders
GROUP BY
HOUR(order_time)
ORDER BY
hour;
Result: The video shows the distribution of orders across different hours, indicating peak times around 12-1 PM and 4-7 PM.

Join relevant tables to find the category-wise distribution of pizzas.
SELECT
category,
COUNT(name) AS pizza_count
FROM
pizza_types
GROUP BY
category
ORDER BY
pizza_count DESC;
Result:
Classic: 8 pizzas
Supreme: 9 pizzas
Veggie: 9 pizzas
Chicken: 6 pizzas