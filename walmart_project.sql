-- SELECT * FROM walmart

-- SELECT COUNT(*) FROM walmart

-- SELECT DISTINCT(payment_method),COUNT(*) FROM walmart
-- GROUP BY payment_method

-- SELECT DISTINCT(Branch), COUNT(*) 
-- FROM walmart
-- GROUP BY Branch;

-- DROP TABLE walmart
-- SELECT MAX(quantity) FROM walmart

-- Problems
-- find different payment method and number of transactions, number of quantity sold

-- select distinct(payment_method),COUNT(*),SUM(quantity) as no_of_quantity  FROM walmart
-- GROUP BY payment_method

-- Identify the highest-rated category in each branch, displaying the branch, category

-- SELECT 
--     distinct(category),
--     branch, 
--     rating, 
--     RANK() OVER (PARTITION BY branch ORDER BY rating DESC) AS rank
-- FROM walmart;

-- If I want ot use the subquery then 
-- select * from (
-- select distinct(category),branch,rating,
-- rank() over(partition by branch order by rating desc) as rank from walmart
-- ) as ranked_data
-- where rank = 1


-- Identify the busiest day for each branch based on the number of transactions

-- select payment_method,count(*) from walmart
-- group by payment_method

-- select date, (to_date(date, 'DD/MM/YY')) as formatted_date  from walmart
-- select * from
-- (select branch,date, to_char(to_date(date,'DD/MM/YY'),'day') as day_name,count(*) as no_of_transactions
-- rank() over(partition by branch count(*) desc) as rank
-- from walmart
-- group by branch,date,day_name
-- order by no_of_transactions,day_name desc)
-- where rank = 1

-- SELECT * FROM (
--     SELECT 
--         branch, 
--         date, 
--         TO_CHAR(TO_DATE(date, 'DD/MM/YY'), 'Day') AS day_name, 
--         COUNT(*) AS no_of_transactions,
--         RANK() OVER (PARTITION BY branch ORDER BY COUNT(*) DESC) AS rank
--     FROM walmart
--     GROUP BY branch, date, TO_CHAR(TO_DATE(date, 'DD/MM/YY'), 'Day')
-- ) ranked
-- WHERE rank = 1
-- ORDER BY no_of_transactions DESC, day_name DESC;


-- calculate the total qantity of items sold per payment method, list payment_method and total_quantity.

-- select payment_method,sum(quantity) as no_of_quant_sold from walmart
-- group by payment_method

-- determine the average,minimum and maximum ratings of products for each city,
-- list the city, average_rating, min_rating and max_rating.

-- select category,city,avg(rating) as avg_ratings from walmart
-- where rating>9
-- group by category,city,rating

-- select category,city,max(rating) as max_ratings from walmart
-- -- where rating>9
-- group by category,city,rating


-- select category,city,min(rating) as min_ratings from walmart
-- where rating>9
-- group by category,city,rating


-- select category,city,avg(rating) as avg_ratings,min(rating) as min_rating, max(rating) as max_rating from walmart
-- where rating>9
-- group by category,city


-- calculate the total profit for each category by cosidering the total_profit
-- as (unit_price * quantity * profit_margin). List the category and total_profit
-- ,ordered form highest to lowest_profit


-- select unit_price,quantity,profit_margin,(unit_price::numeric * quantity::numeric * profit_margin::numeric) as total_profit from walmart

-- SELECT 
--     unit_price, 
--     quantity, 
--     profit_margin, 
--     (REPLACE(unit_price, '$', '')::numeric * quantity::numeric * profit_margin::numeric) AS total_profit
-- FROM walmart
-- order by total_profit desc

-- drop table walmart

-- determine the most common payment method for each branch.
-- display branch and the preferred payment method.


-- select * from (select branch,payment_method,count(*) as preferred_payment_method,
-- rank() over(partition by branch order by count(*) desc) as rank
-- from walmart
-- group by branch,payment_method)
-- where rank<2

-- categorize sales into 3 group morning, afternoon, evening
-- find out which of the shift and number of invoices

-- select time,extract(hour from time::TIME) as hour_time,
-- case
-- when extract(hour from time::TIME) between 6 and 12 then 'morning'
-- when extract(hour from time::TIME) between 13 and 18 then 'afternoon'
-- when extract(hour from time::TIME) between 19 and 24 then 'evening'
-- else 'night'
-- end as time_of_day
-- from walmart


-- identify 5 branch with highest decrease ratio in revenue compare to last year(current year 2023 and last year 2022)
-- 2022 sales
-- with revenue_2022 as
-- (SELECT 
--     branch, 
--     SUM(REPLACE(unit_price, '$', '')::NUMERIC * quantity) AS total_revenue
-- FROM walmart
-- where extract(year from to_date(date,'DD/MM/YY')) = 2022
-- GROUP BY branch
-- )

-- revenue_2023 as
-- (SELECT 
--     branch, 
--     SUM(REPLACE(unit_price, '$', '')::NUMERIC * quantity) AS total_revenue
-- FROM walmart
-- where extract(year from to_date(date,'DD/MM/YY')) = 2023
-- GROUP BY branch
-- )

-- select r2.branch,r2.total_revenue,r3.branch,r3.total_revenue
-- from revenue_2022 as r2
-- join revenue_2023 as r3
-- on r2.branch = r3.branch

-- SELECT rt.result_id,rt.student_id,rt.exam_id,e.grade
-- FROM Result_table AS rt
-- JOIN Enrollments AS e
-- ON rt.student_id = e.student_id


-- TO_CHAR(TO_DATE(date, 'DD/MM/YY'), 'Day') AS day_name,
-- 2022 sales
-- with revenue_monthly as
-- with revenue_monthly_2022 as (
-- select branch,date, sum((replace(unit_price,'$','')::numeric * quantity::numeric)) as total_revenue,
-- to_char(to_date(date,'DD/MM/YY'),'month') as month_2022,
-- EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) AS year_2022
-- from walmart
-- where extract(year from to_date(date,'DD/MM/YY')) = 2022
-- -- where extract(month from to_date(date,'DD/MM/YY'))  
-- group by branch,date,month_2022,year_2022),

-- -- 2023
-- revenue_monthly_2023 as (
-- select branch,date,sum(replace(unit_price,'$','')::numeric * quantity::numeric) as total_revenue,
-- to_char(to_date(date,'DD/MM/YY'),'Month') as month_2023,
-- extract(year from to_date(date,'DD/MM/YY'))as year_2023
-- from walmart
-- where extract(year from to_date(date,'DD/MM/YY')) = 2023
-- group by branch,date,month_2023,year_2023)
-- SELECT * FROM revenue_monthly_2023

-- select rm_2.branch,rm_2.date,rm_2.month_2022,
-- rm_2.year_2022,rm_2.total_revenue,rm_3.branch,rm_3.date,rm_3.month_2023,
-- rm_3.year_2023,rm_3.total_revenue,
-- round(
-- (rm_2.total_revenue - rm_3.total_revenue)::numeric/
-- rm_2.total_revenue::numeric * 100,2
-- ) as revenue_ratio
-- from revenue_monthly_2022 as rm_2
-- join revenue_monthly_2023 as rm_3
-- on rm_2.branch = rm_3.branch

-- identify 5 branch with highest decrease ratio in revenue compare to month (current year 2023 and last year 2022)

-- with revenue_monthly_2022 as (
-- select branch,date, sum((replace(unit_price,'$','')::numeric * quantity::numeric)) as total_revenue,
-- to_char(to_date(date,'DD/MM/YY'),'day') as day_name,
-- EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) AS year_2022
-- rank() over(partition by branch order by total_revenue desc) as rank
-- from walmart
-- where extract(year from to_date(date,'DD/MM/YY')) = 2022
-- where extract(month from to_date(date,'DD/MM/YY'))  
-- group by branch,date,day_name,year_2022),

-- 2023
-- revenue_monthly_2023 as (
-- select branch,date,sum(replace(unit_price,'$','')::numeric * quantity::numeric) as total_revenue,
-- to_char(to_date(date,'DD/MM/YY'),'day') as day_name,
-- extract(year from to_date(date,'DD/MM/YY'))as year_2023
-- rank() over(partition by branch order by total_revenue desc) as rank
-- from walmart
-- where extract(year from to_date(date,'DD/MM/YY')) = 2023
-- group by branch,date,day_name,year_2023)

-- select rm_2.branch,rm_2.date,rm_2.day_name,
-- rm_2.year_2022,rm_2.total_revenue,rm_3.branch,rm_3.date,rm_3.day_name,
-- rm_3.year_2023,rm_3.total_revenue,
-- round(
-- (rm_2.total_revenue - rm_3.total_revenue)::numeric/
-- rm_2.total_revenue::numeric * 100,2
-- ) as revenue_ratio
-- from revenue_monthly_2022 as rm_2
-- join revenue_monthly_2023 as rm_3
-- on rm_2.branch = rm_3.branch
-- limit 5
