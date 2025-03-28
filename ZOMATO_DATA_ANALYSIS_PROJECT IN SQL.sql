--ZOMATO_DATA_ANALYSIS--

select* from [dbo].[Zomato_data_cleaned]

-- 1. Retrieve all restaurant names and their ratings
SELECT name, rate FROM [dbo].[Zomato_data_cleaned];

SELECT name,
    CASE
        WHEN [online_order] = 1 THEN 'Yes'
        WHEN  [online_order]= 0 THEN 'No'
        ELSE NULL -- Handle unexpected values or NULLs
    END AS online_order_accepted
FROM [dbo].[Zomato_data_cleaned];


-- 2. Get restaurants that accept online orders
SELECT name, online_order 
FROM [dbo].[Zomato_data_cleaned]
WHERE online_order = 1;

-- 3. Find restaurants with a rating above 4.0
SELECT name, rate FROM [dbo].[Zomato_data_cleaned] WHERE rate > 4.0 ORDER BY rate DESC;

-- 4. Count the number of restaurants in each category
SELECT listed_in_type, COUNT(*) AS total_restaurants 
FROM  [dbo].[Zomato_data_cleaned]
GROUP BY listed_in_type;

-- 5. Find the average cost for two people
SELECT AVG(approx_cost) AS avg_cost 
FROM [dbo].[Zomato_data_cleaned];

-- 6. Find the top 5 most reviewed restaurants
SELECT TOP 5 name, votes 
FROM [dbo].[Zomato_data_cleaned]
ORDER BY votes DESC;

-- 7. Get restaurants with a rating higher than the average rating
SELECT name, rate
FROM [dbo].[Zomato_data_cleaned]
WHERE rate > (SELECT AVG(rate) FROM [dbo].[Zomato_data_cleaned]);

-- 8. Rank restaurants by rating within each category
SELECT name, listed_in_type, rate,
       RANK() OVER (PARTITION BY listed_in_type ORDER BY rate DESC) AS rank
FROM [dbo].[Zomato_data_cleaned];

-- 9. Find the restaurant with the highest rating in each category
SELECT name, listed_in_type, MAX(rate)as maximum_rate
FROM [dbo].[Zomato_data_cleaned] 
GROUP BY name,listed_in_type;

-- 10. Calculate the percentage of restaurants offering online orders
SELECT (COUNT(CASE WHEN online_order = '1' THEN 'yes' END) * 100.0 / COUNT(*)) AS percentage_online_orders 
FROM [dbo].[Zomato_data_cleaned];


