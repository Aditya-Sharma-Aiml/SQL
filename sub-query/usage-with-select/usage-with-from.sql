-- 1. Display average rating of all the restaurants
SELECT r_name, average_rating
FROM (
	SELECT r_id, avg(restaurant_rating) as average_rating
	FROM zomato.orders 
	GROUP BY r_id
)t1
JOIN zomato.restaurants t2 
ON t1.r_id=t2.r_id;
