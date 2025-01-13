-- 1
CREATE DATABASE residents;

-- 2
\i ...

-- 3
SELECT state, count(state) FROM people GROUP BY state ORDER BY count(state) DESC LIMIT 10;

-- 4
SELECT substring(email from '%@#"%' for '#') AS domain, count(id) FROM people GROUP BY domain ORDER BY count DESC LIMIT 10;

-- 5
DELETE FROM people WHERE id = 3399;

-- 6
DELETE FROM people WHERE state = 'CA';

-- 7
UPDATE people SET given_name = UPPER(given_name) WHERE email LIKE '%teleworm.us';

-- 8
DELETE FROM people;