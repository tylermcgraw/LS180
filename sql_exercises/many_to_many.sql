-- 1
CREATE DATABASE billing;
\c billing

CREATE TABLE customers(
  id serial PRIMARY KEY,
  name text NOT NULL,
  payment_token char(8) NOT NULL UNIQUE CHECK (payment_token ~ '^[A-Z]{8}$')
);

CREATE TABLE services(
  id serial PRIMARY KEY,
  description text NOT NULL,
  price numeric (10, 2) NOT NULL CHECK (price > 0.00)
);

INSERT INTO customers (name, payment_token)
VALUES
  ('Pat Johnson', 'XHGOAHEQ'),
  ('Nancy Monreal', 'JKWQPJKL'),
  ('Lynn Blake', 'KLZXWEEE'),
  ('Chen Ke-Hua', 'KWETYCVX'),
  ('Scott Lakso', 'UUEAPQPS'),
  ('Jim Pornot', 'XKJEYAZA');

INSERT INTO services (description, price)
VALUES
  ('Unix Hosting', 5.95),
  ('DNS', 4.95),
  ('Whois Registration', 1.95),
  ('High Bandwidth', 15.00),
  ('Business Support', 250.00),
  ('Dedicated Hosting', 50.00),
  ('Bulk Email', 250.00),
  ('One-to-one Training', 999.00);

CREATE TABLE customers_services(
  id serial PRIMARY KEY,
  customer_id integer REFERENCES customers(id) ON DELETE CASCADE NOT NULL,
  service_id integer REFERENCES services(id) NOT NULL,
  UNIQUE (customer_id, service_id)
);

INSERT INTO customers_services (customer_id, service_id)
VALUES
  (1, 1), (1, 2), (1, 3),
  (3, 1), (3, 2), (3, 3), (3, 4), (3, 5),
  (4, 1), (4, 4),
  (5, 1), (5, 2), (5, 6),
  (6, 1), (6, 6), (6, 7);

-- 2
SELECT DISTINCT c.*
FROM customers AS c INNER JOIN customers_services AS cs
ON c.id = cs.customer_id;

-- 3
SELECT DISTINCT c.*, s.*
FROM customers AS c
FULL OUTER JOIN customers_services AS cs
ON c.id = cs.customer_id
FULL OUTER JOIN services AS s
ON s.id = cs.service_id
WHERE customer_id IS NULL;

-- 4
SELECT s.description
FROM customers_services as cs RIGHT OUTER JOIN services as s
ON cs.service_id = s.id
WHERE cs.service_id IS NULL;

-- 5
SELECT c.name, string_agg(s.description, ', ')
  FROM customers as c
    LEFT OUTER JOIN customers_services as cs
      ON c.id = cs.customer_id
    LEFT OUTER JOIN services as s
      ON s.id = cs.service_id
  GROUP BY c.name;

-- 6
SELECT s.description, COUNT(cs.id) as count
  FROM services as s INNER JOIN customers_services as cs
    ON s.id = cs.service_id
  GROUP BY s.description
  HAVING COUNT(cs.id) >= 3;

-- 7
SELECT SUM(s.price)
  FROM services as s
    INNER JOIN customers_services as cs
      ON s.id = cs.service_id;

-- 8
INSERT INTO customers (name, payment_token)
  VALUES ('John Doe', 'EYODHLCN');

INSERT INTO customers_services (customer_id, service_id)
  VALUES (7, 1), (7, 2), (7, 3);

-- 9
SELECT SUM(s.price)
  FROM services as s
    INNER JOIN customers_services as cs
      ON s.id = cs.service_id
  WHERE s.price > 100.00;

SELECT SUM(s.price)
  FROM services as s
    CROSS JOIN customers_services
  WHERE s.price > 100.00;

-- 10
DELETE FROM customers WHERE name = 'Chen Ke-Hua';
DELETE FROM customers_services WHERE service_id = 7;
DELETE FROM services WHERE description = 'Bulk Email';