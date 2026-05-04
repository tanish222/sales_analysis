-- Q1. Preview the first 10 rows
select * from analysis_table
limit 10;

-- Q2. Filter order from West region with sales > $500
select region, sales from analysis_table
where region = 'West'
and sales > 500
order by sales desc;

--Q3. Total Sales And Profit by Region
select region,
	COUNT(order_id) as total_order,
	ROUND(sum(sales)::numeric, 2) as total_sales,
	ROUND(sum(profit)::numeric,2) as total_profit,
	ROUND(avg(profit_margin)::numeric, 2) as avg_margin_profit
from analysis_table
group by region
order by total_sales desc

--Q4. Sales by Category

select category,
	ROUND(sum(sales)::numeric,2) as total_sales,
	ROUND(sum(profit)::numeric,2) as total_profit,
	COUNT(*) as order_count
from analysis_table
group by category
order by total_sales desc

--Q5. Monthly Revenue Trend
select order_year,order_month,
	round(sum(sales)::numeric,2) as monthly_sales,
	round(sum(profit)::numeric,2) as monthly_profit,
	count(distinct order_id) as orders
from analysis_table
group by order_year, order_month
order by order_year, order_month;

--Q6. Year-over-Year total sales
select order_year,
	round(sum(sales)::numeric,2) as total_sales,
	round(sum(profit)::numeric,2) as total_profit
from analysis_table
group by order_year
order by order_year;

--Q7. Top 15 Customers by Lifetime Value
select customer_name, segment,
	count(DISTINCT order_id) as order_count,
	round(sum(sales)::numeric, 2) as lifetime_value,
	round(avg(sales)::numeric, 2) as avg_order_value
from analysis_table
group by customer_name, segment
having count(distinct order_id) >= 2
order by lifetime_value desc
limit 15;

--Q8. Discount Tier Impact on Profit Margin
select 
	case
		when discount = 0 then '0 - No Discount'
		when discount <= 0.2 then '1 - Low (1-20%)'
		when discount <= 0.4 then '2 - Medium (21-40%)'
		else '3- High (41%+)'
	end as discount_tier,
	count(*) as orders,
	round(avg(profit_margin)::numeric, 2) as profit_margin,
	round(sum(profit)::numeric,2) as total_profit
from analysis_table
group by discount_tier
order by discount_tier;

