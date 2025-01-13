-- 2
ALTER TABLE films ALTER COLUMN title SET NOT NULL;
ALTER TABLE films ALTER COLUMN year SET NOT NULL;
ALTER TABLE films ALTER COLUMN genre SET NOT NULL;
ALTER TABLE films ALTER COLUMN director SET NOT NULL;
ALTER TABLE films ALTER COLUMN duration SET NOT NULL;

-- 4
ALTER TABLE films ADD CONSTRAINT title_unique UNIQUE (title);

-- 6
ALTER TABLE films DROP CONSTRAINT title_unique;

-- 7
ALTER TABLE films ADD CONSTRAINT title_length CHECK (length(title) > 0);

-- 8
INSERT INTO films (title) VALUES ('a');

-- 10
ALTER TABLE films ADD CONSTRAINT year_20thc CHECK (year BETWEEN 1900 AND 2100);

-- 13
ALTER TABLE films ADD CONSTRAINT director_length_and_space_check CHECK (length(director) >= 3 AND director LIKE '% %');

-- 15
UPDATE films SET director = 'Johnny' WHERE title = 'Die Hard';

-- 16
-- ALTER COLUMN (NOT NULL), ADD CONSTRAINT (CHECK), data type

-- 17
CREATE TABLE test(
  test int DEFAULT 9
);
ALTER TABLE test ADD CONSTRAINT test_lt_5 CHECK (test < 5);
INSERT INTO test (test);