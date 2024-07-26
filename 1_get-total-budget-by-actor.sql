SELECT  
	persons.id, 
	persons.first_name, 
	persons.last_name, 
	SUM(movies.budget)
FROM  persons
INNER JOIN movie_cast ON movie_cast.person_id = persons.id
INNER JOIN movies ON movie_cast.movie_id = movies.id
GROUP BY 
	persons.id,
	persons.first_name,
	persons.last_name;
