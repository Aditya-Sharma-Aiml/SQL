-- Independent Subquery - Row Subquery(One Col Multi Rows)
use zomato;

-- 1. Find all users who never ordered.
SELECT * 
FROM users 
WHERE user_id 
NOT IN (
	SELECT DISTINCT user_id
	FROM orders );
    
-- 2. Find all the movies made by top 3 directors(in terms of total gross income).
WITH TOP_DIRECTORS AS (SELECT director
						FROM person.movie 
						GROUP BY director
						ORDER BY SUM(gross) DESC
						LIMIT 3)
SELECT * 
FROM person.movie 
WHERE director 
IN (SELECT * 
	FROM TOP_DIRECTORS
	);


-- 3. Find all movies of all those actors whose filmography's avg rating > 8.5(take 25000 votes as cutoff)
SELECT * 
FROM person.movie 
WHERE star IN(
			SELECT  star 
            FROM person.movie 
            WHERE votes > 25000
			GROUP BY star
			having AVG(score) > 8.5
            );