-- 2
SELECT * FROM films;

-- 3
SELECT * FROM films WHERE length(title) < 12;

-- 4
ALTER TABLE films
  ADD COLUMN director varchar(255),
  ADD COLUMN duration int;

-- 5
UPDATE films SET director = 'John McTiernan', duration = 132 WHERE title = 'Die Hard';
UPDATE films SET director = 'Michael Curtiz', duration = 102 WHERE title = 'Casablanca';
UPDATE films SET director = 'Francis Ford Coppola', duration = 113 WHERE title = 'The Conversation';

-- 6
INSERT INTO films VALUES
  ('1984', 1956, 'scifi', 'Michael Anderson', 90),
  ('Tinker Tailor Soldier Spy', 2011, 'espionage', 'Tomas Alfredson', 127),
  ('The Birdcage', 1996, 'comedy', 'Mike Nichols', 118);

-- 7
SELECT title, extract("year" from current_date) - "year" AS age_in_years FROM films ORDER BY "year" DESC;

-- 8
SELECT title, duration FROM films WHERE duration > 120 ORDER BY duration DESC;

-- 9
SELECT title AS longest_film FROM films ORDER BY duration DESC LIMIT 1;