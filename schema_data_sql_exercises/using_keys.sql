-- 1
CREATE SEQUENCE counter;

-- 2
SELECT nextval('counter');

-- 3
DROP SEQUENCE counter;

-- 4
CREATE SEQUENCE counter_by_2 INCREMENT BY 2 MINVALUE 2;

-- 5
-- regions_id_seq

-- 6
ALTER TABLE films ADD COLUMN id serial PRIMARY KEY;

-- 9
ALTER TABLE films DROP CONSTRAINT films_pkey;