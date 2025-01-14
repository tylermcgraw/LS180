-- 1
CREATE DATABASE workshop;
\c workshop

CREATE TABLE devices(
  id serial PRIMARY KEY,
  name text NOT NULL,
  created_at timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE parts(
  id serial PRIMARY KEY,
  part_number integer UNIQUE NOT NULL,
  device_id integer REFERENCES devices(id)
);

-- 2
INSERT INTO devices (name)
  VALUES ('Accelerometer'), ('Gyroscope');

INSERT INTO parts (part_number, device_id)
  VALUES (1, 1), (2, 1), (3, 1),
  (11, 2), (12, 2), (13, 2), (14, 2), (15, 2),
  (777, NULL), (666, NULL), (512, NULL);

-- 3
SELECT devices.name, parts.part_number
  FROM devices INNER JOIN parts
  ON devices.id = parts.device_id;

-- 4
SELECT * FROM parts WHERE SUBSTRING(CAST(part_number AS varchar), 1) = '3';

-- 5
SELECT devices.name, COUNT(parts.id)
  FROM devices LEFT OUTER JOIN parts
  ON devices.id = parts.device_id
  GROUP BY devices.name;

-- 6
SELECT devices.name, COUNT(parts.id)
  FROM devices LEFT OUTER JOIN parts
  ON devices.id = parts.device_id
  GROUP BY devices.name
  ORDER BY devices.name DESC;

-- 7
SELECT part_number, device_id FROM parts WHERE device_id IS NOT NULL;
SELECT part_number, device_id FROM parts WHERE device_id IS NULL;

-- 8
SELECT name FROM devices ORDER BY created_at ASC LIMIT 1;

-- 9
UPDATE parts SET device_id = 1 WHERE part_number = 14 OR part_number = 15;

-- 10
DELETE FROM parts WHERE device_id = 1;
DELETE FROM devices WHERE name = 'Accelerometer';