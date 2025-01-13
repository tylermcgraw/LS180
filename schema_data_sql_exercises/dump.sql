--
-- PostgreSQL database dump
--

-- Dumped from database version 14.15 (Homebrew)
-- Dumped by pg_dump version 14.15 (Homebrew)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: weather; Type: TABLE; Schema: public; Owner: tylermcgraw
--

CREATE TABLE public.weather (
    date date NOT NULL,
    low integer NOT NULL,
    high integer NOT NULL,
    rainfall integer DEFAULT 0
);


ALTER TABLE public.weather OWNER TO tylermcgraw;

--
-- Data for Name: weather; Type: TABLE DATA; Schema: public; Owner: tylermcgraw
--

INSERT INTO public.weather VALUES ('2016-03-07', 29, 32, 0);
INSERT INTO public.weather VALUES ('2016-03-08', 23, 31, 0);
INSERT INTO public.weather VALUES ('2016-03-09', 17, 28, 0);
INSERT INTO public.weather VALUES ('2016-03-01', 34, 43, 3);
INSERT INTO public.weather VALUES ('2016-03-02', 32, 44, 3);
INSERT INTO public.weather VALUES ('2016-03-03', 31, 47, 4);
INSERT INTO public.weather VALUES ('2016-03-04', 33, 42, 2);
INSERT INTO public.weather VALUES ('2016-03-05', 39, 46, 7);
INSERT INTO public.weather VALUES ('2016-03-06', 32, 43, 2);


--
-- PostgreSQL database dump complete
--

