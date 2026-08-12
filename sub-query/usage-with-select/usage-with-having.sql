-- Find genres having avg score > avg score of all the movies
SELECT genre, avg(score) as average_score
FROM person.movie
GROUP BY genre
HAVING average_score > (SELECT AVG(score) FROM person.movie);