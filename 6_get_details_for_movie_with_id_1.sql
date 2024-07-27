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
        persons.id AS person_id,
        persons.first_name,
        persons.last_name,
        JSON_BUILD_OBJECT(
            'id', files.id,
            'filename', files.filename,
            'MIME_type', files.MIME_type,
            'URL', files.URL,
            's3_key', files.s3_key
        ) AS main_photo
    FROM persons
    LEFT JOIN person_photos ON persons.id = person_photos.person_id AND person_photos.is_main = TRUE
    LEFT JOIN files ON person_photos.file_id = files.id
),
actors_array AS (
    SELECT
        movie_cast.movie_id,
        JSON_AGG(
            JSON_BUILD_OBJECT(
                'person_id', persons.id,
                'first_name', persons.first_name,
                'last_name', persons.last_name,
                'main_photo', JSON_BUILD_OBJECT(
                    'id', files.id,
                    'filename', files.filename,
                    'MIME_type', files.MIME_type,
                    'URL', files.URL,
                    's3_key', files.s3_key
                )
            )
        ) AS actors
    FROM movie_cast
    JOIN persons ON movie_cast.person_id = persons.id
    LEFT JOIN person_photos ON persons.id = person_photos.person_id AND person_photos.is_main = TRUE
    LEFT JOIN files ON person_photos.file_id = files.id
    GROUP BY movie_cast.movie_id
),
genres_array AS (
    SELECT
        movies_genres.movie_id,
        JSON_AGG(
            JSON_BUILD_OBJECT(
                'genre_id', genres.id,
                'name', genres.genre
            )
        ) AS genres
    FROM movies_genres
    JOIN genres ON movies_genres.genre_id = genres.id
    GROUP BY movies_genres.movie_id
)
SELECT 
    movies.id, 
    movies.title,
    movies.release_date,
    movies.duration,
    movies.description,
    JSON_BUILD_OBJECT(
        'id', filtered_files.id,
        'filename', filtered_files.filename,
        'MIME_type', filtered_files.MIME_type,
        'URL', filtered_files.URL,
        's3_key', filtered_files.s3_key
    ) AS poster,
    JSON_BUILD_OBJECT(
        'person_id', filtered_directors.person_id,
        'first_name', filtered_directors.first_name,
        'last_name', filtered_directors.last_name,
        'main_photo', JSON_BUILD_OBJECT(
            'id', filtered_directors.main_photo->>'id',
            'filename', filtered_directors.main_photo->>'filename',
            'MIME_type', filtered_directors.main_photo->>'MIME_type',
            'URL', filtered_directors.main_photo->>'URL',
            's3_key', filtered_directors.main_photo->>'s3_key'
        )
    ) AS director,
    actors_array.actors,
    genres_array.genres
FROM movies
LEFT JOIN filtered_files ON filtered_files.id = movies.poster_id
LEFT JOIN filtered_directors ON filtered_directors.person_id = movies.director_id
LEFT JOIN actors_array ON actors_array.movie_id = movies.id
LEFT JOIN genres_array ON genres_array.movie_id = movies.id
WHERE movies.id = 1;
