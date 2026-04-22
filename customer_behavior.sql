select 
	gender,
	sum(purchase_amount) as revenue
from customer 
group by gender;


select 
	customer_id,
	purchase_amount
from customer
where discount_applied = 'Yes' AND purchase_amount >= (select AVG(purchase_amount) from customer)


select 
	item_purchased,
	round(AVG(review_rating::numeric),2) as avg_review
from customer
group by item_purchased
order by AVG(review_rating) desc
limit 5;

 
select 
	shipping_type,
	round(AVG(purchase_amount),2) as avg_pur 
from customer 
where shipping_type in ('Express','Standard')
group by shipping_type


select 
	subscription_status,
	COUNT(customer_id) as customers,
	ROUND(AVG(purchase_amount),2) as avg_spend,
	ROUND(SUM(purchase_amount),2) as total_rev
from customer
group by subscription_status
order by total_rev,avg_spend DESC;


select 
	item_purchased,
	round(100*SUM(
	CASE 
		when discount_applied = 'Yes' THEN 1
		else 0
	END
	)/count(*),2) as total_sum
from customer
group by item_purchased
order by total_sum Desc
limit 5

select AVG(previous_purchases) from customer;

with customer_segment as
(
	select
		customer_id,
		previous_purchases,
	case
		when previous_purchases = 1 then 'new'
		when previous_purchases between 2 and 10 then 'returning'
		else 'Loyal'
	end as customer_range
	from customer
)
select 
	customer_range,
	count(*) as num
from customer_segment
group by customer_range



with most_number as(
select 
	item_purchased,
	category,
	count(customer_id) as count_customer,
	row_number() over(partition by category order by count(customer_id) DESC) as item_rank
from customer
group by item_purchased,category
)
select * 
from most_number
where item_rank<=3


select 
	subscription_status,
	count(previous_purchases) as count_customer
from customer
where previous_purchases > 5
group by subscription_status


select 
	age_group,
	count(customer_id) as count_cus,
	sum(purchase_amount) as amount_purchased
from customer
group by age_group
order by amount_purchased desc






