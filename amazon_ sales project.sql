# Amazon E-Commerce Sales Data Analysis Project

use sara; 

drop table if exists amazon;

-- Table creation 

create table amazon (
order_id int primary key auto_increment,
user_id	varchar(20),
product_id	varchar(20),
category	varchar(20),
subcategory	varchar(20),
brand	varchar(20),
price	decimal(10,2),
discount	decimal(10,2),
final_price	decimal(10,2),
rating	decimal(5,2) null,
review_count int null,
stock	int,
seller_id	varchar(20),
seller_rating	decimal(5,2) null,
purchase_date	date,
purchase_time	time,
shipping_time_days	int,
location	varchar(20),
device	varchar(20) null,
payment_method	varchar(20),
is_returned	varchar(10) null,
delivery_status varchar(20) null
); 

describe amazon; 

-- Data exploration

select * from amazon
limit 10;

select distinct brand from amazon;

select distinct subcategory from amazon;

select sum(final_price) as total_sales, 
avg(final_price) as avg_sales, delivery_status
from amazon
where delivery_status = 'delivered';
 
select avg(rating) as avg_rating from amazon; 
 
select * from amazon; 
 
select count(*) from amazon;
 
 -- data cleaning and transformation
 
select is_returned from amazon
group by  is_returned;
 
select * from amazon
where price is null or 
final_price is null;
 
alter table amazon
add column purchase_year year;
 
update amazon
set purchase_year = year(purchase_date)
where order_id != '';
 

 -- Business questions
 
 -- Q1. Which category earns the most revenue? Show the total final_price per category, highest first. 
 
 select category, sum(final_price) as total_revenue from amazon
 group by category
 order by sum(final_price) desc;
 
-- Q2. Which payment method has the highest percentage of returned orders? 

select r.payment_method, r.return_orders, t.total_orders,
round((r.return_orders*100/t.total_orders),2) as RO_perct
from
(
select payment_method, count(delivery_status) as return_orders 
from amazon
where delivery_status = 'returned'
group by payment_method 
) r
join (
select payment_method, count(*) as total_orders 
from amazon 
group by payment_method 
) t on r.payment_method = t.payment_method
order by RO_perct desc;

-- Q3. At which hour of the day do customers place the most orders?

select hour(purchase_time), count(hour(purchase_time)) as order_place_time from amazon
group by hour(purchase_time)
order by order_place_time desc;

-- Q4. Label each order as Low (under 1000), Medium (1000 to 10000) or High (above 10000), and count the orders in each band.

select  case 
when final_price < 1000 then 'low'
when final_price between 1000 and 10000 then 'medium'
else 'high'
end as price_band, count(*) as total_order
from amazon
group by price_band;

-- Q5. Show the number of orders and the total revenue for each month of 2025.

select monthname(purchase_date) as months, count(*) as total_orders, sum(final_price) as total_revenue
 from amazon
where purchase_year = 2025
group by monthname(purchase_date)
order by total_revenue desc;

-- Q6. List the orders whose final_price is higher than the overall average. How many are there?

select order_id, final_price, count(*) over () as total_count 
from amazon
where final_price > (
select  avg(final_price) as avg_revenue from amazon
);

-- Q7. Which sellers have an average seller_rating below 3 and more than 3 orders? 

select seller_id, count(seller_id) as total_order, 
round(avg(seller_rating),2) as avg_rating 
from amazon 
group by seller_id
having  count(seller_id) > 3 and round(avg(seller_rating),2) < 3;

-- Q8. Show the orders where final_price is higher than the average of their own category. 

select a.order_id, a.category, a.final_price, t.avg_price from amazon a
join (
select category, avg(final_price) as avg_price from amazon 
group by category ) t on a.category = t.category
where a.final_price > t.avg_price;

-- Q9. For each category, which brand has the highest total revenue? 

select category, brand, total_revenue from (
select category, brand, sum(final_price) as total_revenue,
rank () over (partition by category  order by sum(final_price) desc) as rank_by_cat
from amazon 
group by category, brand
) t where rank_by_cat = 1;


-- Q10. For each customer with more than one order, show their most recent order (date and time).

select user_id, purchase_date, rnk, purchase_time
from (
select user_id, purchase_date, purchase_time,
rank () over(partition by user_id order by purchase_date desc, purchase_time desc) as rnk,
count(*) over( partition By user_id) as order_count
from amazon
) t
where rnk = 1 and order_count > 1;

-- Q11. Of all returned orders, what percentage came from each payment method, and how many returned orders is that?

select a.payment_method, count(a.delivery_status) as total_cnt,
round(t.total_order*100/sum(t.total_order) over(),2) as percnt
from amazon a 
join 
(
select payment_method, delivery_status, count(*) as total_order from amazon 
where delivery_status = 'returned'
group by payment_method
) t on t.payment_method = a.payment_method
where a.delivery_status = 'returned'
group by a.payment_method;

---




