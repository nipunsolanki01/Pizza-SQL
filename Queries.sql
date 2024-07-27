
#Creating a project on pizza system
## We have imported the tables form csv files and now will perform our queries

create database pizzahut;
use pizzahut;

#We will import data as the data is too much we are creating it first
create table orders
(
	order_id int not null ,
    order_date date not null ,
    order_time time not null ,
    primary key (order_id)
);


create table order_details
(
	order_details_id int not null ,
	order_id int not null ,
    pizza_id text not null ,
    quantity int not null ,
    primary key (order_details_id)
);

select * from order_details; 

# Questions

# 1. Retrieve the total number of orders placed.
 select count(order_id) AS toal_orders from orders;
 
 
 # 2. Calculate the total revenue generated from pizza sales.
 select * from pizzas;
 select * from order_details;
 
 with cte(price , pizza_id , quantity) as
 (
	select price , order_details.pizza_id , quantity
	from pizzas 
	join order_details
	on pizzas.pizza_id=order_details.pizza_id
 )
 
 select sum(price*quantity) 
 from cte;
 
 # or
 select round(sum(order_details.quantity * pizzas.price) , 2) AS total_price
 from order_details 
 join pizzas
 on order_details.pizza_id = pizzas.pizza_id;



# 3. Identify the highest-priced pizza.



select name , price 
from pizza_types as pt
join pizzas as p
on pt.pizza_type_id = p.pizza_type_id
order by 2 desc limit 1;

#or 

select name  
from pizza_types
where pizza_type_id = (
select pizza_type_id
from pizzas 
where price  = (select max(price) from pizzas)
);
 
 
 # 4. Identify the most common pizza size ordered.
 
 select size  , count(*) as number 
 from order_details as od
 join pizzas as p
 on od.pizza_id = p.pizza_id
 group by  size 
 order by 2 desc 
 limit 1;
 
 
 # 5. List the top 5 most ordered pizza types along with their quantities.
 
 select pizza_id ,  sum(quantity) as qty
 from order_details
 group by pizza_id 
 order by qty desc
 limit 5;
 
 #or
 
 select pt.name , sum(od.quantity) as qty
 from pizza_types as pt
 join pizzas as p
 on pt.pizza_type_id = p.pizza_type_id
 join order_details as od
 on od.pizza_id = p.pizza_id
 group by pt.name
 order by qty desc
 limit 5;
 
 
 
 
 # 6 . Join the necessary tables to find the total quantity of each pizza category ordered.
 
select * from pizzas;
select * from pizza_types;
select * from order_details;

select pt.category , sum(quantity)
from pizza_types as pt
join pizzas as p
on pt.pizza_type_id = p.pizza_type_id 
join order_details as od
on od.pizza_id = p.pizza_id
group by pt.category;


# 7 . Determine the distribution of orders by hour of the day.

select hour(order_time) as hours , count(order_id) from orders
group by hours
order by hours;

# 8. Join relevant tables to find the category-wise distribution of pizzas ( har category ke andar kitne pizzas hain)

select category , count(*) 
from pizza_types 
group by category ;
 
 
 # 9 . Group the orders by date and calculate the average number of pizzas ordered per day.
 
 WITH cte(`date` , sum) AS
 (
	select order_date , sum(quantity)  
	from orders 
	join order_details
	on orders.order_id = order_details.order_id
	group by order_date
)

Select round(avg(sum) , 0 ) as average from cte;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 