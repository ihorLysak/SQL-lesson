SELECT 
    persons.id, 
    CONCAT(persons.first_name, persons.last_name) as full_name,
    ROUND(AVG(movies.budget::numeric), 0) as avg_budget
FROM movies
JOIN persons ON movies.director_id = persons.id
GROUP BY 
    persons.id,
	full_name
