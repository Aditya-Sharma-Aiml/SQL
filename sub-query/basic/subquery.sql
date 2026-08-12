-- Independent Subquery - Scalar Subquery:

SELECT * FROM person.movie;
use person;

-- 1. Find the movie with highest profit(vs order by) 
SELECT * 
FROM movie 
where (gross-budget) =  
		( SELECT MAX(gross-budget) 
        FROM movie);
 
SELECT * 
FROM movie 
ORDER BY gross-budget desc 
limit 1; -- (fast for large dataset)

-- 2. Find how many movies have a rating > the avg of all the movie ratings(Find the 
-- count of above average movies)
SELECT count(*) 
FROM movie 
where score > 
	(SELECT AVG(score) 
	FROM movie);


-- 3. Find the highest rated movie of 2000.
SELECT * 
FROM movie 
WHERE year='2000' 
and score =
	(SELECT max(score) 
	FROM movie 
    WHERE year = '2000');



-- 4. Find the highest rated movie among all movies whose number of votes are > 
-- the dataset avg votes
SELECT * 
FROM movie 
WHERE score =
	(SELECT max(score) 
    FROM movie 
    where votes > 
		(SELECT AVG(votes) 
        FROM movie));



