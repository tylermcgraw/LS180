-- 1
INSERT INTO calls ("when", duration, contact_id)
  VALUES ('2016-01-18 14:47:00', 632, 6);

-- 2
SELECT calls.when, calls.duration, contacts.first_name
  FROM calls INNER JOIN contacts
  ON calls.contact_id = contacts.id
  WHERE contacts.id <> 6;


-- 3
INSERT INTO contacts VALUES
  (DEFAULT, 'Merve', 'Elk', 6343511126),
  (DEFAULT, 'Sawa', 'Fyodorov', 6125594874);
INSERT INTO calls VALUES
  (DEFAULT, '2016-01-17 11:52:00', 175, 26),
  (DEFAULT, '2016-01-18 21:22:00', 79, 27);


-- 4
ALTER TABLE contacts
  ADD CONSTRAINT number_unique UNIQUE (number);

-- 5
INSERT INTO contacts (first_name, last_name, number) VALUES ('Nivi', 'Petrussen', '6125594874');
-- ERROR:  duplicate key value violates unique constraint "number_unique"
-- DETAIL:  Key (number)=(6125594874) already exists.

-- 6
-- because when is a keyword used by sql (specifically a reserved word)

-- 7
-- _________          ____________
-- | calls | >-0----- | contacts |
-- ---------          ------------