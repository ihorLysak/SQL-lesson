WITH filtered_files AS (
    SELECT
        id,
        filename,
        MIME_type,
        URL,
        s3_key
    FROM files
),
filtered_directors AS (
    SELECT
        id,
        first_name,
        last_name
    FROM persons
),
movies_with_required_genres AS (
    SELECT DISTINCT
        movies.id
    FROM
        movies
    JOIN
        movies_genres ON movies.id = movies_genres.movie_id
    WHERE
        movies_genres.genre_id IN (1, 2)
)
SELECT
    movies.id,
    movies.title,
    movies.release_date,
    movies.duration,
    movies.description,
    ROW_TO_JSON(filtered_files) AS poster,
    ROW_TO_JSON(filtered_directors) AS director
FROM movies
LEFT JOIN filtered_files ON filtered_files.id = movies.poster_id
LEFT JOIN filtered_directors ON filtered_directors.id = movies.director_id
INNER JOIN movies_with_required_genres ON movies.id = movies_with_required_genres.id 
WHERE movies.country_id = 1
	AND movies.release_date >= 'Jan-01-2022'
	AND movies.duration >= '2:15:00'
