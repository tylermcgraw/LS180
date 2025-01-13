-- 1
\i ~/launch_school/ls180/schema_data_sql_exercises/group_by_data_dump.sql

-- 2
INSERT INTO films (title, year, genre, director, duration)
  VALUES ('The Bourne Identity', 2002, 'espionage', 'Doug Liman', 118);
INSERT INTO films (title, year, genre, director, duration)
  VALUES ('Wayne''s World', 1992, 'comedy', 'Penelope Spheeris', 95);

-- 3
SELECT DISTINCT genre FROM films;

-- 4
SELECT genre FROM films GROUP BY genre;

-- 5
SELECT round(avg(duration)) FROM films;

-- 6
SELECT round(avg(duration)), genre FROM films GROUP BY genre;

-- 7
SELECT (year / 10 * 10) AS decade, round(avg(duration)) AS avg_duration FROM films GROUP BY decade ORDER BY decade;

-- 8
SELECT * FROM films WHERE director LIKE 'John %';

-- 9
SELECT genre, count(genre) FROM films GROUP BY genre ORDER BY count DESC;

-- 10
SELECT (year / 10 * 10) AS decade, genre, string_agg(title, ', ') AS films FROM films GROUP BY genre, decade ORDER BY decade;

-- 11
SELECT genre, sum(duration) as total_duration FROM films GROUP BY genre ORDER BY total_duration;