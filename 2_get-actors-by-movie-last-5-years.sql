SELECT 
	movies.id, 
	movies.title, 
	COUNT(movie_cast.person_id)
FROM movies
JOIN movie_cast ON movie_cast.movie_id = movies.id
WHERE movies.release_date >= CURRENT_DATE - INTERVAL '5 years'
GROUP BY
	movies.id,
	movies.title;
