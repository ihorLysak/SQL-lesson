--
-- PostgreSQL database dump
--

-- Dumped from database version 14.12 (Homebrew)
-- Dumped by pg_dump version 16.3

-- Started on 2024-07-26 19:37:24 EEST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: ihorlysak
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO ihorlysak;

--
-- TOC entry 846 (class 1247 OID 18738)
-- Name: gender; Type: TYPE; Schema: public; Owner: ihorlysak
--

CREATE TYPE public.gender AS ENUM (
    'male',
    'female',
    'other'
);


ALTER TYPE public.gender OWNER TO ihorlysak;

--
-- TOC entry 855 (class 1247 OID 18779)
-- Name: role; Type: TYPE; Schema: public; Owner: ihorlysak
--

CREATE TYPE public.role AS ENUM (
    'leading',
    'supporting',
    'background'
);


ALTER TYPE public.role OWNER TO ihorlysak;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 18786)
-- Name: characters; Type: TABLE; Schema: public; Owner: ihorlysak
--

CREATE TABLE public.characters (
    id integer NOT NULL,
    character_name character varying(128) NOT NULL,
    description text NOT NULL,
    role public.role NOT NULL,
    person_id integer,
    createdat timestamp with time zone DEFAULT now() NOT NULL,
    updatedat timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.characters OWNER TO ihorlysak;

--
-- TOC entry 216 (class 1259 OID 18785)
-- Name: characters_id_seq; Type: SEQUENCE; Schema: public; Owner: ihorlysak
--

CREATE SEQUENCE public.characters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.characters_id_seq OWNER TO ihorlysak;

--
-- TOC entry 3790 (class 0 OID 0)
-- Dependencies: 216
-- Name: characters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ihorlysak
--

ALTER SEQUENCE public.characters_id_seq OWNED BY public.characters.id;


--
-- TOC entry 212 (class 1259 OID 18729)
-- Name: countries; Type: TABLE; Schema: public; Owner: ihorlysak
--

CREATE TABLE public.countries (
    id integer NOT NULL,
    country character varying(128) NOT NULL,
    createdat timestamp with time zone DEFAULT now() NOT NULL,
    updatedat timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.countries OWNER TO ihorlysak;

--
-- TOC entry 211 (class 1259 OID 18728)
-- Name: countries_id_seq; Type: SEQUENCE; Schema: public; Owner: ihorlysak
--

CREATE SEQUENCE public.countries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.countries_id_seq OWNER TO ihorlysak;

--
-- TOC entry 3791 (class 0 OID 0)
-- Dependencies: 211
-- Name: countries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ihorlysak
--

ALTER SEQUENCE public.countries_id_seq OWNED BY public.countries.id;


--
-- TOC entry 227 (class 1259 OID 18903)
-- Name: favorite_movies; Type: TABLE; Schema: public; Owner: ihorlysak
--

CREATE TABLE public.favorite_movies (
    user_id integer NOT NULL,
    movie_id integer NOT NULL,
    createdat timestamp with time zone DEFAULT now() NOT NULL,
    updatedat timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.favorite_movies OWNER TO ihorlysak;

--
-- TOC entry 210 (class 1259 OID 18718)
-- Name: files; Type: TABLE; Schema: public; Owner: ihorlysak
--

CREATE TABLE public.files (
    id integer NOT NULL,
    filename character varying(64) NOT NULL,
    mime_type character varying(64) NOT NULL,
    url character varying(2083) NOT NULL,
    s3_key character varying(256) NOT NULL,
    createdat timestamp with time zone DEFAULT now() NOT NULL,
    updatedat timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.files OWNER TO ihorlysak;

--
-- TOC entry 209 (class 1259 OID 18717)
-- Name: files_id_seq; Type: SEQUENCE; Schema: public; Owner: ihorlysak
--

CREATE SEQUENCE public.files_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.files_id_seq OWNER TO ihorlysak;

--
-- TOC entry 3792 (class 0 OID 0)
-- Dependencies: 209
-- Name: files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ihorlysak
--

ALTER SEQUENCE public.files_id_seq OWNED BY public.files.id;


--
-- TOC entry 219 (class 1259 OID 18802)
-- Name: genres; Type: TABLE; Schema: public; Owner: ihorlysak
--

CREATE TABLE public.genres (
    id integer NOT NULL,
    genre character varying(64) NOT NULL,
    createdat timestamp with time zone DEFAULT now() NOT NULL,
    updatedat timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.genres OWNER TO ihorlysak;

--
-- TOC entry 218 (class 1259 OID 18801)
-- Name: genres_id_seq; Type: SEQUENCE; Schema: public; Owner: ihorlysak
--

CREATE SEQUENCE public.genres_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.genres_id_seq OWNER TO ihorlysak;

--
-- TOC entry 3793 (class 0 OID 0)
-- Dependencies: 218
-- Name: genres_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ihorlysak
--

ALTER SEQUENCE public.genres_id_seq OWNED BY public.genres.id;


--
-- TOC entry 223 (class 1259 OID 18853)
-- Name: movie_cast; Type: TABLE; Schema: public; Owner: ihorlysak
--

CREATE TABLE public.movie_cast (
    movie_id integer NOT NULL,
    person_id integer NOT NULL,
    createdat timestamp with time zone DEFAULT now() NOT NULL,
    updatedat timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.movie_cast OWNER TO ihorlysak;

--
-- TOC entry 224 (class 1259 OID 18870)
-- Name: movie_characters; Type: TABLE; Schema: public; Owner: ihorlysak
--

CREATE TABLE public.movie_characters (
    movie_id integer NOT NULL,
    character_id integer NOT NULL,
    createdat timestamp with time zone DEFAULT now() NOT NULL,
    updatedat timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.movie_characters OWNER TO ihorlysak;

--
-- TOC entry 221 (class 1259 OID 18811)
-- Name: movies; Type: TABLE; Schema: public; Owner: ihorlysak
--

CREATE TABLE public.movies (
    id integer NOT NULL,
    title character varying(256) NOT NULL,
    description text NOT NULL,
    budget money NOT NULL,
    release_date date NOT NULL,
    duration interval NOT NULL,
    director_id integer NOT NULL,
    poster_id integer NOT NULL,
    country_id integer NOT NULL,
    createdat timestamp with time zone DEFAULT now() NOT NULL,
    updatedat timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.movies OWNER TO ihorlysak;

--
-- TOC entry 222 (class 1259 OID 18836)
-- Name: movies_genres; Type: TABLE; Schema: public; Owner: ihorlysak
--

CREATE TABLE public.movies_genres (
    movie_id integer NOT NULL,
    genre_id integer NOT NULL,
    createdat timestamp with time zone DEFAULT now() NOT NULL,
    updatedat timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.movies_genres OWNER TO ihorlysak;

--
-- TOC entry 220 (class 1259 OID 18810)
-- Name: movies_id_seq; Type: SEQUENCE; Schema: public; Owner: ihorlysak
--

CREATE SEQUENCE public.movies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.movies_id_seq OWNER TO ihorlysak;

--
-- TOC entry 3794 (class 0 OID 0)
-- Dependencies: 220
-- Name: movies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ihorlysak
--

ALTER SEQUENCE public.movies_id_seq OWNED BY public.movies.id;


--
-- TOC entry 215 (class 1259 OID 18761)
-- Name: person_photos; Type: TABLE; Schema: public; Owner: ihorlysak
--

CREATE TABLE public.person_photos (
    person_id integer NOT NULL,
    file_id integer NOT NULL,
    is_main boolean NOT NULL,
    createdat timestamp with time zone DEFAULT now() NOT NULL,
    updatedat timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.person_photos OWNER TO ihorlysak;

--
-- TOC entry 214 (class 1259 OID 18746)
-- Name: persons; Type: TABLE; Schema: public; Owner: ihorlysak
--

CREATE TABLE public.persons (
    id integer NOT NULL,
    first_name character varying(64) NOT NULL,
    last_name character varying(64) NOT NULL,
    biography text NOT NULL,
    birth_date date NOT NULL,
    gender public.gender NOT NULL,
    country_id integer NOT NULL,
    createdat timestamp with time zone DEFAULT now() NOT NULL,
    updatedat timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.persons OWNER TO ihorlysak;

--
-- TOC entry 213 (class 1259 OID 18745)
-- Name: persons_id_seq; Type: SEQUENCE; Schema: public; Owner: ihorlysak
--

CREATE SEQUENCE public.persons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.persons_id_seq OWNER TO ihorlysak;

--
-- TOC entry 3795 (class 0 OID 0)
-- Dependencies: 213
-- Name: persons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ihorlysak
--

ALTER SEQUENCE public.persons_id_seq OWNED BY public.persons.id;


--
-- TOC entry 226 (class 1259 OID 18888)
-- Name: users; Type: TABLE; Schema: public; Owner: ihorlysak
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(64) NOT NULL,
    first_name character varying(64) NOT NULL,
    second_name character varying(64) NOT NULL,
    email character varying(320) NOT NULL,
    password character varying(64) NOT NULL,
    avatar_id integer NOT NULL
);


ALTER TABLE public.users OWNER TO ihorlysak;

--
-- TOC entry 225 (class 1259 OID 18887)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: ihorlysak
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO ihorlysak;

--
-- TOC entry 3796 (class 0 OID 0)
-- Dependencies: 225
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ihorlysak
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3565 (class 2604 OID 18789)
-- Name: characters id; Type: DEFAULT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.characters ALTER COLUMN id SET DEFAULT nextval('public.characters_id_seq'::regclass);


--
-- TOC entry 3557 (class 2604 OID 18732)
-- Name: countries id; Type: DEFAULT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.countries ALTER COLUMN id SET DEFAULT nextval('public.countries_id_seq'::regclass);


--
-- TOC entry 3554 (class 2604 OID 18721)
-- Name: files id; Type: DEFAULT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.files ALTER COLUMN id SET DEFAULT nextval('public.files_id_seq'::regclass);


--
-- TOC entry 3568 (class 2604 OID 18805)
-- Name: genres id; Type: DEFAULT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.genres ALTER COLUMN id SET DEFAULT nextval('public.genres_id_seq'::regclass);


--
-- TOC entry 3571 (class 2604 OID 18814)
-- Name: movies id; Type: DEFAULT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.movies ALTER COLUMN id SET DEFAULT nextval('public.movies_id_seq'::regclass);


--
-- TOC entry 3560 (class 2604 OID 18749)
-- Name: persons id; Type: DEFAULT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.persons ALTER COLUMN id SET DEFAULT nextval('public.persons_id_seq'::regclass);


--
-- TOC entry 3580 (class 2604 OID 18891)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3593 (class 2606 OID 18795)
-- Name: characters characters_pkey; Type: CONSTRAINT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.characters
    ADD CONSTRAINT characters_pkey PRIMARY KEY (id);


--
-- TOC entry 3586 (class 2606 OID 18736)
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);


--
-- TOC entry 3609 (class 2606 OID 18909)
-- Name: favorite_movies favorite_movies_pkey; Type: CONSTRAINT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.favorite_movies
    ADD CONSTRAINT favorite_movies_pkey PRIMARY KEY (user_id, movie_id);


--
-- TOC entry 3584 (class 2606 OID 18727)
-- Name: files files_pkey; Type: CONSTRAINT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);


--
-- TOC entry 3595 (class 2606 OID 18809)
-- Name: genres genres_pkey; Type: CONSTRAINT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (id);


--
-- TOC entry 3601 (class 2606 OID 18859)
-- Name: movie_cast movie_cast_pkey; Type: CONSTRAINT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.movie_cast
    ADD CONSTRAINT movie_cast_pkey PRIMARY KEY (movie_id, person_id);


--
-- TOC entry 3603 (class 2606 OID 18876)
-- Name: movie_characters movie_characters_pkey; Type: CONSTRAINT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.movie_characters
    ADD CONSTRAINT movie_characters_pkey PRIMARY KEY (movie_id, character_id);


--
-- TOC entry 3599 (class 2606 OID 18842)
-- Name: movies_genres movies_genres_pkey; Type: CONSTRAINT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.movies_genres
    ADD CONSTRAINT movies_genres_pkey PRIMARY KEY (movie_id, genre_id);


--
-- TOC entry 3597 (class 2606 OID 18820)
-- Name: movies movies_pkey; Type: CONSTRAINT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (id);


--
-- TOC entry 3590 (class 2606 OID 18767)
-- Name: person_photos person_photos_pkey; Type: CONSTRAINT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.person_photos
    ADD CONSTRAINT person_photos_pkey PRIMARY KEY (person_id, file_id);


--
-- TOC entry 3588 (class 2606 OID 18755)
-- Name: persons persons_pkey; Type: CONSTRAINT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.persons
    ADD CONSTRAINT persons_pkey PRIMARY KEY (id);


--
-- TOC entry 3605 (class 2606 OID 18897)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 3607 (class 2606 OID 18895)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3591 (class 1259 OID 18921)
-- Name: unique_main_photo_per_person; Type: INDEX; Schema: public; Owner: ihorlysak
--

CREATE UNIQUE INDEX unique_main_photo_per_person ON public.person_photos USING btree (person_id) WHERE (is_main = true);


--
-- TOC entry 3613 (class 2606 OID 18796)
-- Name: characters characters_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.characters
    ADD CONSTRAINT characters_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.persons(id);


--
-- TOC entry 3624 (class 2606 OID 18915)
-- Name: favorite_movies favorite_movies_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.favorite_movies
    ADD CONSTRAINT favorite_movies_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movies(id);


--
-- TOC entry 3625 (class 2606 OID 18910)
-- Name: favorite_movies favorite_movies_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.favorite_movies
    ADD CONSTRAINT favorite_movies_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3619 (class 2606 OID 18860)
-- Name: movie_cast movie_cast_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.movie_cast
    ADD CONSTRAINT movie_cast_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movies(id);


--
-- TOC entry 3620 (class 2606 OID 18865)
-- Name: movie_cast movie_cast_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.movie_cast
    ADD CONSTRAINT movie_cast_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.persons(id);


--
-- TOC entry 3621 (class 2606 OID 18882)
-- Name: movie_characters movie_characters_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.movie_characters
    ADD CONSTRAINT movie_characters_character_id_fkey FOREIGN KEY (character_id) REFERENCES public.characters(id);


--
-- TOC entry 3622 (class 2606 OID 18877)
-- Name: movie_characters movie_characters_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.movie_characters
    ADD CONSTRAINT movie_characters_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movies(id);


--
-- TOC entry 3614 (class 2606 OID 18821)
-- Name: movies movies_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.countries(id);


--
-- TOC entry 3615 (class 2606 OID 18831)
-- Name: movies movies_director_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_director_id_fkey FOREIGN KEY (director_id) REFERENCES public.persons(id);


--
-- TOC entry 3617 (class 2606 OID 18848)
-- Name: movies_genres movies_genres_genre_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.movies_genres
    ADD CONSTRAINT movies_genres_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES public.genres(id);


--
-- TOC entry 3618 (class 2606 OID 18843)
-- Name: movies_genres movies_genres_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.movies_genres
    ADD CONSTRAINT movies_genres_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movies(id);


--
-- TOC entry 3616 (class 2606 OID 18826)
-- Name: movies movies_poster_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_poster_id_fkey FOREIGN KEY (poster_id) REFERENCES public.files(id);


--
-- TOC entry 3611 (class 2606 OID 18773)
-- Name: person_photos person_photos_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.person_photos
    ADD CONSTRAINT person_photos_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.files(id);


--
-- TOC entry 3612 (class 2606 OID 18768)
-- Name: person_photos person_photos_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.person_photos
    ADD CONSTRAINT person_photos_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.persons(id);


--
-- TOC entry 3610 (class 2606 OID 18756)
-- Name: persons persons_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.persons
    ADD CONSTRAINT persons_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.countries(id);


--
-- TOC entry 3623 (class 2606 OID 18898)
-- Name: users users_avatar_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ihorlysak
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_avatar_id_fkey FOREIGN KEY (avatar_id) REFERENCES public.files(id);


--
-- TOC entry 3789 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: ihorlysak
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2024-07-26 19:37:24 EEST

--
-- PostgreSQL database dump complete
--

