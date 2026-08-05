-- Independent Subquery - Table Subquery(Multi Col Multi Row)
SELECT * FROM person.movie;


-- 1. Find the most profitable movie of each year.
SELECT * 
FROM PERSON.MOVIE 
WHERE (year, gross-budget) IN
	(
	SELECT year, MAX(gross-budget) FROM person.movie 
	GROUP BY year
	);
    
-- 2. Find the highest rated movie of each genre votes cutoff of 25000.
SELECT *  
FROM person.movie 
WHERE (score, genre) 
IN (
	 SELECT max(score), genre
	 FROM person.movie 
	 WHERE votes > 25000
	 GROUP BY genre
     )
AND votes > 25000;


-- 3. Find the highest grossing movies of top 5 actor/director combo in terms of 
-- total gross income
WITH TOP_DUO AS
		(
		SELECT star, director, max(gross)
		FROM person.movie
		GROUP BY star, director
		ORDER BY SUM(gross) DESC LIMIT 5
        )
SELECT * 
FROM person.movie 
WHERE (star, director, gross) IN 
(SELECT * FROM TOP_DUO);