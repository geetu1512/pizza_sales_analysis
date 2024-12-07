# retrieve the total no. of orders placed

select * from orders;
select count(order_id) as total_orders from orders;

# calculate the total revenue generated from pizza sales
SELECT 
    (orders_details.quantity * pizzas.price) AS total_sales
FROM
    orders_details
        JOIN
    pizzas ON pizzas.pizza_id = orders_details.pizza_id;
    
SELECT * FROM pizzahut.orders_details;

# calculate the total revenue generated from pizza sales
SELECT 
    round((orders_details.quantity * pizzas.price),2) AS total_sales
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;
    
    
# identify the highest price pizza
select pizza_types.name, pizzas.price
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
order by pizzas.price desc limit 1 ;

# identify the most common pizzas size ordered
select pizzas.size , count(orders_details.order_details_id) as order_count
from pizzas join orders_details
on pizzas.pizza_id = orders_details.pizza_id
group by pizzas.size  order by order_count desc;


# list the top 5 most  ordered pizza.types  along with their quantities.
SELECT 
    pizza_types.name, SUM(orders_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5;

#intermediate level questions 
# determine the distributions of orders by hours of the day
 SELECT 
    HOUR(order_time) AS hour, COUNT(order_id) AS order_count
FROM
    orders
GROUP BY HOUR(order_time);


# join relevent tables to find the category wish distribution of pizzas.

 #select category , count(name) from pizza_types
 #group by category;
 
 
 # group the orders by date and calculate the average number of pizzas ordered per day
 select round(avg(quantity),0) as avg_pizza_ordered_per_day from
 (select orders.order_date, sum(orders_details.quantity) as quantity
 from orders join orders_details
 on orders.order_id = orders_details.order_id
 group by orders.order_date) as order_quantity;
 
 
 
 # determine the top 3 most ordered pizza type based on revenue

select pizza_types.name,
sum(orders_details.quantity * pizzas.price) as revenue
from pizza_types join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join orders_details
on orders_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by revenue desc limit 3 ;

