-- 10 questions
select * from tbl_yelp_review limit 10;
select * from tbl_yelp_businesses limit 10;

--1- find number of businesses in each category
with CTE as (
select business_id, trim(A.value) as category
from tbl_yelp_businesses
,lateral split_to_table(categories, ',') A
)
select category, count(*) as no_of_business
from CTE
group by 1
order by 2 desc;

--2- find the top 10 users who have reviewd the most businesses in the "Restaurants" category
select r.user_id, count(distinct r.business_id) as No_of_businesses 
from tbl_yelp_review r
inner join tbl_yelp_businesses b on r.business_id=b.business_id
where b.categories ilike '%restaurant%'
group by user_id
order by 2 desc
limit 10;

--3- Find the most popular categories of businesses (based on the number of reviews).

with CTE as (
select business_id, trim(A.value) as category
from tbl_yelp_businesses
,lateral split_to_table(categories, ',') A
)
select category, count(*) as no_of_reviews
from CTE
inner join tbl_yelp_review r on CTE.business_id=r.business_id
group by category
order by 2 desc;

--4- Find the top 3 most recent reviews for each business.
with cte as (
select r.*, b.name,
row_number() over(partition by r.business_id order by review_date desc) as rn
from tbl_yelp_review r
inner join tbl_yelp_businesses b on r.business_id=b.business_id
)
select * from cte
where rn<=3;

--5- Find the month with the heighest number of reviews.
select month(review_date) as review_month,count(*) as no_of_reviews
from tbl_yelp_review
group by 1
order by 2 desc;

--6- Find the percentage of 5-star reviews for each business.
select b.business_id, b.name, count(*) as total_reviews,
sum(case when r.review_stars=5 then 1 else 0
end ) as star5_review,
star5_review*100/total_reviews as percent_5_star
from tbl_yelp_review r
inner join tbl_yelp_businesses b on r.business_id=b.business_id
group by 1,2;

--7- Find the top 5 most reviewed businesses in each city.
with cte as (
select b.city, b.business_id, b.name, count(*) as total_reviews
from tbl_yelp_review r
inner join tbl_yelp_businesses b on r.business_id=b.business_id
group by 1,2,3
)
select *
from cte
qualify row_number() over(partition by city order by total_reviews desc)<=5;

--8- Find the average rating of businesses that have at least 100 reviews

select b.business_id, b.name, count(*) as total_reviews,
avg(review_stars) as avg_rating
from tbl_yelp_review r
inner join tbl_yelp_businesses b on r.business_id=b.business_id
group by 1, 2
having count(*)>=100;

--9- List the top 10 users who have written the most reviews, along with the businesses they reviewed.
with cte as (
select r.user_id, count(*) as total_reviews
from tbl_yelp_review r
inner join tbl_yelp_businesses b on r.business_id=b.business_id
group by 1
order by 2 desc
limit 10
)

select user_id, business_id
from tbl_yelp_review where user_id in (select user_id from 
cte)
group by 1,2
order by user_id;

--10- Find top 10 businesses with highest positive sentiment reviews
select r.business_id, b.name, count(*) as positive_reviews
from tbl_yelp_review r
inner join tbl_yelp_businesses b on r.business_id=b.business_id
where r.sentiments = 'Positive'
group by 1,2
order by 3 desc
limit 10;