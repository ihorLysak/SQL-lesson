CREATE DATABASE movies;

CREATE TABLE files (
	id SERIAL PRIMARY KEY,
	filename VARCHAR(64) NOT NULL,
	MIME_type VARCHAR(64) NOT NULL,
	URL VARCHAR(2083) NOT NULL,
	s3_key VARCHAR(256) NOT NULL,
	createdAt TIMESTAMPTZ NOT NULL DEFAULT NOW(),
	updatedAt TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE countries (
	id SERIAL PRIMARY KEY,
	country VARCHAR(128) NOT NULL,
	createdAt TIMESTAMPTZ NOT NULL DEFAULT NOW(),
	updatedAt TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TYPE GENDER as ENUM ('male', 'female', 'other');

CREATE TABLE persons (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(64) NOT NULL,
	last_name VARCHAR(64) NOT NULL,
	biography TEXT NOT NULL,
	birth_date DATE NOT NULL,
	gender GENDER NOT NULL,
	country_id INT NOT NULL,
	createdAt TIMESTAMPTZ NOT NULL DEFAULT NOW(),
	updatedAt TIMESTAMPTZ NOT NULL DEFAULT NOW(),
	FOREIGN KEY (country_id) REFERENCES countries(id)
);

CREATE TABLE person_photos (
	person_id INT NOT NULL,
	file_id INT NOT NULL,
	is_main BOOLEAN DEFAULT false,
	createdAt TIMESTAMPTZ NOT NULL DEFAULT NOW(),
	updatedAt TIMESTAMPTZ NOT NULL DEFAULT NOW(),
	PRIMARY KEY (person_id, file_id),
	FOREIGN KEY (person_id) REFERENCES persons(id),
	FOREIGN KEY (file_id) REFERENCES files(id)
);

CREATE UNIQUE INDEX unique_main_photo_per_person
ON person_photos (person_id)
WHERE is_main = TRUE;

CREATE TYPE ROLE as ENUM ('leading', 'supporting', 'background');

CREATE TABLE characters (
	id SERIAL PRIMARY KEY,
	character_name VARCHAR(128) NOT NULL,
	description TEXT NOT NULL,
	role ROLE NOT NULL,
	person_id INTEGER,
	createdAt TIMESTAMPTZ NOT NULL DEFAULT NOW(),
	updatedAt TIMESTAMPTZ NOT NULL DEFAULT NOW(),
	FOREIGN KEY (person_id) REFERENCES persons(id)
);

CREATE TABLE genres (
	id SERIAL PRIMARY KEY,
	genre VARCHAR(64) NOT NULL,
	createdAt TIMESTAMPTZ NOT NULL DEFAULT NOW(),
	updatedAt TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE movies (
	id SERIAL PRIMARY KEY,
	title VARCHAR(256) NOT NULL,
	description TEXT NOT NULL,
	budget MONEY NOT NULL,
	release_date DATE NOT NULL,
	duration INTERVAL NOT NULL,
	director_id INTEGER NOT NULL,
	poster_id INTEGER NOT NUll,
	country_id INTEGER NOT NULL,
	createdAt TIMESTAMPTZ NOT NULL DEFAULT NOW(),
	updatedAt TIMESTAMPTZ NOT NULL DEFAULT NOW(),
	FOREIGN KEY (country_id) REFERENCES countries(id),
	FOREIGN KEY (poster_id) REFERENCES files(id),
	FOREIGN KEY (director_id) REFERENCES persons(id)
);

CREATE TABLE movies_genres (
	movie_id INTEGER NOT NULL,
	genre_id INTEGER NOT NULL,
	createdAt TIMESTAMPTZ NOT NULL DEFAULT NOW(),
	updatedAt TIMESTAMPTZ NOT NULL DEFAULT NOW(),
	PRIMARY KEY (movie_id, genre_id),
	FOREIGN KEY (movie_id) REFERENCES movies(id),
	FOREIGN KEY (genre_id) REFERENCES genres(id)
);

CREATE TABLE movie_cast (
	movie_id INTEGER NOT NULL,
	person_id INTEGER NOT NULL,
	createdAt TIMESTAMPTZ NOT NULL DEFAULT NOW(),
	updatedAt TIMESTAMPTZ NOT NULL DEFAULT NOW(),
	PRIMARY KEY (movie_id, person_id),
	FOREIGN KEY (movie_id) REFERENCES movies(id),
	FOREIGN KEY (person_id) REFERENCES persons(id)
);

CREATE TABLE movie_characters (
	movie_id INTEGER NOT NULL,
	character_id INTEGER NOT NULL,
	createdAt TIMESTAMPTZ NOT NULL DEFAULT NOW(),
	updatedAt TIMESTAMPTZ NOT NULL DEFAULT NOW(),
	PRIMARY KEY (movie_id, character_id),
	FOREIGN KEY (movie_id) REFERENCES movies(id),
	FOREIGN KEY (character_id) REFERENCES characters(id)
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(64) NOT NULL,
    first_name VARCHAR(64),
    second_name VARCHAR(64),
    email VARCHAR(320) NOT NULL UNIQUE,
    password VARCHAR(64) NOT NULL,
	avatar_id INTEGER,
    FOREIGN KEY (avatar_id) REFERENCES files(id)
);

CREATE TABLE favorite_movies (
	user_id INTEGER NOT NULL,
	movie_id INTEGER NOT NULL,
	createdAt TIMESTAMPTZ NOT NULL DEFAULT NOW(),
	updatedAt TIMESTAMPTZ NOT NULL DEFAULT NOW(),
	PRIMARY KEY(user_id, movie_id),
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (movie_id) REFERENCES movies(id)
)

