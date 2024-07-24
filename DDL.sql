CREATE TABLE files (
	id SERIAL PRIMARY KEY,
	filename VARCHAR(64) NOT NULL,
	MIME_type VARCHAR(64) NOT NULL,
	URL VARCHAR(2083) NOT NULL,
	s3_key VARCHAR(256) NOT NULL
);

CREATE TABLE countries (
	id SERIAL PRIMARY KEY,
	country VARCHAR(128) NOT NULL
);

CREATE TYPE GENDER as ENUM ('male', 'female', 'other');

CREATE TABLE persons (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(64) NOT NULL,
	last_name VARCHAR(64) NOT NULL,
	biography TEXT NOT NULL,
	birth_date DATE NOT NULL,
	gender GENDER NOT NULL,
	country INTEGER NOT NULL,
	FOREIGN KEY (country) REFERENCES countries(id)
);

CREATE TABLE person_photos (
	person_id INT,
	file_id INT,
	is_main BOOLEAN,
	FOREIGN KEY (person_id) REFERENCES persons(id),
	FOREIGN KEY (file_id) REFERENCES files(id)
);

CREATE TYPE ROLE as ENUM ('leading', 'supporting', 'background');

CREATE TABLE characters (
	id SERIAL PRIMARY KEY,
	character_name VARCHAR(128) NOT NULL,
	description TEXT NOT NULL,
	role ROLE NOT NULL,
	actor INTEGER,
	FOREIGN KEY (actor) REFERENCES persons(id)
);

CREATE TABLE genres (
	id SERIAL PRIMARY KEY,
	genre VARCHAR(64)
);

CREATE TABLE movies (
	id SERIAL PRIMARY KEY,
	title VARCHAR(256) NOT NULL,
	description TEXT NOT NULL,
	budget MONEY NOT NULL,
	release_date DATE NOT NULL,
	duration INTERVAL NOT NULL,
	director INTEGER NOT NULL,
	poster INTEGER NOT NUll,
	country INTEGER NOT NULL,
	FOREIGN KEY (country) REFERENCES countries(id),
	FOREIGN KEY (poster) REFERENCES files(id),
	FOREIGN KEY (director) REFERENCES persons(id)
);

CREATE TABLE movies_genres (
	movie_id INTEGER NOT NULL,
	genre_id INTEGER NOT NULL,
	FOREIGN KEY (movie_id) REFERENCES movies(id),
	FOREIGN KEY (genre_id) REFERENCES genres(id)
);

CREATE TABLE movie_cast (
	movie_id INTEGER NOT NULL,
	character_id INTEGER NOT NULL,
	FOREIGN KEY (movie_id) REFERENCES movies(id),
	FOREIGN KEY (character_id) REFERENCES characters(id)
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(64) NOT NULL,
    first_name VARCHAR(64) NOT NULL,
    second_name VARCHAR(64) NOT NULL,
    email VARCHAR(320) NOT NULL UNIQUE,
    password VARCHAR(64) NOT NULL,
	avatar INTEGER NOT NULL,
    FOREIGN KEY (avatar) REFERENCES files(id)
);

CREATE TABLE favorite_movies (
	user_id INTEGER NOT NULL,
	movie_id INTEGER NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (movie_id) REFERENCES movies(id)
)

