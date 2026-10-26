use airbnb
-- data presenting 
SELECT *
FROM listings
-- How many active listings exist in Barcelona?
SELECT COUNT(*) AS active_listings
FROM listings
WHERE has_availability = 't'
-- Which neighborhoods have the highest concentration of Airbnb properties?
SELECT 
    neighbourhood_cleansed,
    COUNT(*) AS total_listings,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM listings
GROUP BY neighbourhood_cleansed
ORDER BY total_listings DESC;
--What proportion of listings are entire homes, private rooms, or shared rooms 
SELECT room_type,count(*) as total_listings ,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM listings
group by room_type
order by [percentage] desc
/*Pricing Dynamics */
-- tuning data from text to numeric and removing the $ sign
-- What is the typical nightly price for Airbnb listings in Barcelona?
SELECT 
    AVG(CAST(REPLACE(REPLACE(price, '$', ''), ',', '') AS DECIMAL(10,2)))  AS avg_price
FROM listings
WHERE price IS NOT NULL
-- Which neighborhoods command the highest nightly prices?
select neighbourhood_cleansed,
AVG(CAST(REPLACE(REPLACE(price, '$', ''), ',', '') AS DECIMAL(10,2)))  AS avg_price
from listings
group by neighbourhood_cleansed 
order by avg_price desc 
-- What are the highest-priced listings in Barcelona?
select name , id , 
CAST(REPLACE(REPLACE(price, '$', ''), ',', '') AS DECIMAL(10,2)) AS price
from listings
order by price desc
-- How does listing capacity influence nightly price? 
SELECT accommodates, 
       AVG(CAST(REPLACE(REPLACE(price, '$', ''), ',', '') AS DECIMAL(10,2))) AS avg_price
FROM listings
WHERE price IS NOT NULL
GROUP BY accommodates ; 
-- Which neighborhoods have average prices higher than the overall city average? 
SELECT neighbourhood_cleansed , 
AVG(CAST(REPLACE(REPLACE(price, '$', ''), ',', '') AS DECIMAL(10,2)))  AS avg_price
FROM listings
where price is NOT NULL 
group by neighbourhood_cleansed
HAVING AVG(CAST(REPLACE(REPLACE(price,'$',''),',','') AS DECIMAL(10,2))) > 
    (SELECT AVG(CAST(REPLACE(REPLACE(price,'$',''),',','') AS DECIMAL(10,2))) 
     FROM listings WHERE price IS NOT NULL AND price != '')
ORDER BY avg_price DESC;
-- Categorize listings by price level
SELECT name , neighbourhood_cleansed , 
CAST(REPLACE(REPLACE(price, '$', ''), ',', '') AS DECIMAL(10,2)) AS price ,
case
    when CAST(REPLACE(REPLACE(price, '$', ''), ',', '') AS DECIMAL(10,2)) < 50 then 'Budget'
    when CAST(REPLACE(REPLACE(price, '$', ''), ',', '') AS DECIMAL(10,2)) >= 50 and CAST(REPLACE(REPLACE(price, '$', ''), ',', '') AS DECIMAL(10,2)) < 150 then 'Mid-range'
    when CAST(REPLACE(REPLACE(price, '$', ''), ',', '') AS DECIMAL(10,2)) >= 150 and CAST(REPLACE(REPLACE(price, '$', ''), ',', '') AS DECIMAL(10,2)) < 300 then 'Premium'
else 'Luxury' end as price_category 
from listings 
where price is not null 
-- Top 10% most expensive listings 
SELECT * FROM (
    SELECT 
        id, name, neighbourhood_cleansed,
        CAST(REPLACE(REPLACE(price,'$',''),',','') AS DECIMAL(10,2)) AS price,
        NTILE(10) OVER (ORDER BY CAST(REPLACE(REPLACE(price,'$',''),',','') AS DECIMAL(10,2)) DESC) AS price_decile
    FROM listings
    WHERE price IS NOT NULL AND price != ''
) t
WHERE price_decile = 1
--	Do highly rated listings charge more?
SELECT 
    CASE 
        WHEN review_scores_rating >= 4.8 THEN 'Excellent (4.8+)'
        WHEN review_scores_rating >= 4.5 THEN 'Great (4.5-4.8)'
        WHEN review_scores_rating >= 4.0 THEN 'Good (4.0-4.5)'
        ELSE 'Below 4.0'
    END AS rating_category,
    ROUND(AVG(CAST(REPLACE(REPLACE(price,'$',''),',','') AS DECIMAL(10,2))), 2) AS avg_price,
    COUNT(*) AS total_listings
FROM listings
WHERE price IS NOT NULL AND price != ''
  AND review_scores_rating IS NOT NULL
GROUP BY 
    CASE 
        WHEN review_scores_rating >= 4.8 THEN 'Excellent (4.8+)'
        WHEN review_scores_rating >= 4.5 THEN 'Great (4.5-4.8)'
        WHEN review_scores_rating >= 4.0 THEN 'Good (4.0-4.5)'
        ELSE 'Below 4.0'
    END
ORDER BY avg_price DESC;


/* Revenue & Market Performance */ 
--Where is Airbnb generating the most revenue across Barcelona?
select neighbourhood_cleansed,
       SUM(estimated_revenue_l365d) as total_revenue
from listings 
group by neighbourhood_cleansed
order by total_revenue DESC 
-- Which listing type contributes the most revenue? 
select room_type , 
round(SUM(estimated_revenue_l365d), 2) as total_revenue
from listings 
where estimated_revenue_l365d is not null
group by room_type 
-- How much revenue do Airbnb listings generate annually in Barcelona?
select name,
       SUM(estimated_revenue_l365d) as total_revenue
from listings 
group by name
order by total_revenue DESC 
-- Where do hosts earn the most per property? 
select name , neighbourhood_cleansed ,
round(estimated_revenue_l365d, 2) as revenue_last_year
from listings 
where estimated_revenue_l365d is not null
order by revenue_last_year desc
-- 	Rank neighborhoods by average revenue ( window function)
SELECT 
    neighbourhood_cleansed,
    AVG(estimated_revenue_l365d) AS avg_revenue,
    RANK() OVER (ORDER BY AVG(estimated_revenue_l365d) DESC) AS revenue_rank
FROM listings
WHERE estimated_revenue_l365d IS NOT NULL
GROUP BY neighbourhood_cleansed
ORDER BY avg_revenue DESC
-- Top listing in each neighborhood ( using window function+ partition by)
SELECT * FROM (
    SELECT 
        id, name, neighbourhood_cleansed,
        ROUND(estimated_revenue_l365d, 2) AS annual_revenue,
        ROW_NUMBER() OVER(PARTITION BY neighbourhood_cleansed ORDER BY estimated_revenue_l365d DESC) AS rn
    FROM listings
    WHERE estimated_revenue_l365d IS NOT NULL
) t
WHERE rn = 1;
--Which hosts generate revenue above the host average? 
SELECT host_id, 
       AVG(estimated_revenue_l365d) AS avg_revenue
FROM listings
WHERE estimated_revenue_l365d IS NOT NULL
GROUP BY host_id
HAVING AVG(estimated_revenue_l365d) > (SELECT AVG(estimated_revenue_l365d) FROM listings WHERE estimated_revenue_l365d IS NOT NULL)
ORDER BY avg_revenue DESC
-- Which neighborhoods have the highest revenue per listing?
SELECT neighbourhood_cleansed , id , estimated_revenue_l365d ,[name]
FROM listings
GROUP by [name]
order by estimated_revenue_l365d  DESC 
/* Host Behavior & Market Concentration */ 
-- Which hosts operate the largest number of properties? 
SELECT host_id, host_name , COUNT(*) AS total_listings
FROM listings
GROUP BY host_name , host_id
ORDER BY total_listings DESC
--What percentage of listings are owned by professional hosts?
Select 
    case when total_listings >= 10 then 'Professional' else 'regular' end as host_state 
    , sum(total_listings) as listings_count,
    ROUND(SUM(total_listings) * 100.0 / (SELECT COUNT(*) FROM listings), 2) AS market_percentage
from (select  host_id , count(*)as total_listings
      from listings 
      GROUP BY host_id) t
GROUP BY case when total_listings >= 10 then 'Professional' else 'regular' end ; 
-- Identify professional hosts managing multiple properties.
select host_id , host_name ,count(*) as total_listings
from listings
group by host_id , host_name
having count(*) >= 5 
