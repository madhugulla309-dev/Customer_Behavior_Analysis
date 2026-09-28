select * from customer_behavior
-- Q3. Which are the top 5 products with the highest average review rating?
select item_purchased,round(avg(review_rating::numeric),2) as avg_rating from customer_behavior
group by item_purchased
order by avg(review_rating) desc
limit 5;

--Q4. Compare the average Purchase Amounts between Standard and Express Shipping. 
select shipping_type, avg(purchase_amount) as avg_shipping from customer_behavior
group by shipping_type
having shipping_type = 'Express' or shipping_type ='Standard';

--Q5. Do subscribed customers spend more? Compare average spend and total 
--revenue between subscribers and non-subscribers.
select subscription_status,count(customer_id)as custemers,
avg(purchase_amount) as purchase,
sum(purchase_amount) as total_revenue
from customer_behavior
group by subscription_status
order by total_revenue desc;

--Q6. Which 5 products have the highest percentage of purchases 
--with discounts applied?
select item_purchased, round(100*sum(case when discount_applied = 'Yes' then 1 else 0 end) / count(*),2) as percentile from customer_behavior
group by item_purchased
order by percentile desc
limit 5;


--Q7. Segment customers into New, Returning, and Loyal based on their total 
-- number of previous purchases, and show the count of each segment.
with customer_info as (
select customer_id,previous_purchases,
case
when previous_purchases = 2 then 'New'
when previous_purchases between 2 and 10 then 'Returning'
else 'Loyal'
end as segment
from customer_behavior
)
select segment,count(*) from customer_info
group by segment;

--Q8. What are the top 3 most purchased products within each category? 
with count_items as (
select category,
item_purchased,
count(customer_id) as total,
row_number() over(partition by category order by count(customer_id) desc) as item_rank
from customer_behavior
group by category,item_purchased
)
select category,item_purchased,total,item_rank from count_items
where item_rank <=3;

--Q9. Are customers who are repeat buyers (more than 5 previous purchases) 
--also likely to subscribe?
select subscription_status,count(customer_id) as total
from customer_behavior
where previous_purchases >5
group by subscription_status

--Q10. What is the revenue contribution of each age group? 
select named_age,sum(purchase_amount) as revenue from customer_behavior
group by named_age
order by revenue desc
