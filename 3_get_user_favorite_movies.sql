SELECT 
    users.id, 
    users.username, 
    ARRAY_AGG(movies.title)
FROM movies
JOIN favorite_movies ON favorite_movies.movie_id = movies.id
JOIN users ON favorite_movies.user_id = users.id
GROUP BY
    users.id,
    users.username;