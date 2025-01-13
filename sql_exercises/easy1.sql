-- 1
CREATE DATABASE animals;

-- 2
CREATE TABLE birds(
  id serial PRIMARY KEY,
  name varchar(25),
  age int,
  species varchar(15)
);

-- 3
INSERT INTO birds
  VALUES (1, 'Charlie', 3, 'Finch'),
  (2, 'Allie', 5, 'Owl'),
  (3, 'Jennifer', 3, 'Magpie'),
  (4, 'Jamie', 4, 'Owl'),
  (5, 'Roy', 8, 'Crow');

-- 4
SELECT * FROM birds;

-- 5
SELECT * FROM birds WHERE age < 5;

-- 6
UPDATE birds SET species = 'Raven' WHERE species = 'Crow';

-- 7
DELETE FROM birds WHERE age = 3 AND species = 'Finch';

-- 8
ALTER TABLE birds
  ADD CONSTRAINT check_age CHECK (age > 0);

-- 9
DROP TABLE birds;

-- 10
DROP DATABASE animals;