-- Usage with SELECT:

-- 1. Get the percentage of votes for each movie compared to the total number of votes.
SELECT name, 
(votes / (select sum(votes) 
		from person.movie))*100  AS percentage
FROM person.movie;

-- 2. Display all movie names ,genre, score and avg(score) of genre (corelated sub-query)
SELECT name, genre, score, 
(SELECT  avg(score) FROM person.movie m2 WHERE m1.genre=m2.genre) as avg_score
from person.movie m1;