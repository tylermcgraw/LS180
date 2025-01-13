-- Table Relationships

-- 1. Make sure you are connected to the encyclopedia database. We want to hold the continent data in a separate table from the country data.
/*
Create a continents table with an auto-incrementing id column (set as the Primary Key), and a continent_name column which can hold the same data as the continent column from the countries table.
Remove the continent column from the countries table.
Add a continent_id column to the countries table of type integer.
Add a Foreign Key constraint to the continent_id column which references the id field of the continents table.
*/
ALTER TABLE countries DROP COLUMN continent;
ALTER TABLE countries ADD COLUMN continent_id int;
CREATE TABLE continents(
  id serial PRIMARY KEY,
  continent_name varhchar(50);
);
ALTER TABLE countries
  ADD FOREIGN KEY (continent_id) REFERENCES continents(id);

-- 2. Write statements to add data to the countries and continents tables so that the data below is correctly represented across the two tables. Add both the countries and the continents to their respective tables in alphabetical order.
INSERT INTO continents
  VALUES (DEFAULT, 'North America'),
  (DEFAULT, 'South America'),
  (DEFAULT, 'Europe'),
  (DEFAULT, 'Asia'),
  (DEFAULT, 'Africa');
UPDATE countries SET continent_id = 1 WHERE id = 2;
UPDATE countries SET continent_id = 3 WHERE id = 1 OR id = 3;
UPDATE countries SET continent_id = 4 WHERE id = 4;
INSERT INTO countries
  VALUES (DEFAULT, 'Egypt', 'Cairo', 96308900, 5),
  (DEFAULT, 'Brazil', 'Brasilia', 208385000, 2);

-- 3. We want to create an albums table to hold all the above data except the singer name, and create a reference from the albums table to the singers table to link each album to the correct singer. Write the necessary SQL statements to do this and to populate the table with data. Assume Album Name, Genre, and Label can hold strings up to 100 characters. Include an auto-incrementing id column in the albums table.
ALTER TABLE singers
  ADD CONSTRAINT unique_id UNIQUE(id);
CREATE TABLE albums(
  id serial PRIMARY KEY,
  singer_id int NOT NULL,
  album_name varchar(100),
  released date,
  genre varchar(100),
  label varchar(100),
  FOREIGN KEY (singer_id) REFERENCES singers(id)
);
INSERT INTO albums (album_name, released, genre, label, singer_id)
VALUES ('Born to Run', '1975-08-25', 'Rock and roll', 'Columbia', 1),
('Purple Rain', '1984-06-25', 'Pop, R&B, Rock', 'Warner Bros', 6),
('Born in the USA', '1984-06-04', 'Rock and roll, pop', 'Columbia', 1),
('Madonna', '1983-07-27', 'Dance-pop, post-disco', 'Warner Bros', 5),
('True Blue', '1986-06-30', 'Dance-pop, Pop', 'Warner Bros', 5),
('Elvis', '1956-10-19', 'Rock and roll, Rhythm and Blues', 'RCA Victor', 7),
('Sign o'' the Times', '1987-03-30', 'Pop, R&B, Rock, Funk', 'Paisley Park, Warner Bros', 6),
('G.I. Blues', '1960-10-01', 'Rock and roll, Pop', 'RCA Victor', 7);

-- 4.
CREATE TABLE customers(
  id serial PRIMARY KEY,
  customer_name varchar(100)
);
CREATE TABLE email_addresses(
  customer_id int PRIMARY KEY,
  customer_email varchar(100),
  FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

-- 5.
CREATE TABLE products (
  id serial PRIMARY KEY,
  product_name varchar(50),
  product_cost numeric(4,2) DEFAULT 0,
  product_type varchar(20),
  product_loyalty_points integer
);
INSERT INTO products (product_name, product_cost, product_type, product_loyalty_points)
  VALUES ('LS Burger', 3.00, 'Burger', 10 ),
  ('LS Cheeseburger', 3.50, 'Burger', 15 ),
  ('LS Chicken Burger', 4.50, 'Burger', 20 ),
  ('LS Double Deluxe Burger', 6.00, 'Burger', 30 ),
  ('Fries', 1.20, 'Side', 3 ),
  ('Onion Rings', 1.50, 'Side', 5 ),
  ('Cola', 1.50, 'Drink', 5 ),
  ('Lemonade', 1.50, 'Drink', 5 ),
  ('Vanilla Shake', 2.00, 'Drink', 7 ),
  ('Chocolate Shake', 2.00, 'Drink', 7 ),
  ('Strawberry Shake', 2.00, 'Drink', 7);

-- 6.
DROP TABLE orders;
CREATE TABLE orders(
  id serial PRIMARY KEY,
  customer_id int,
  order_status varchar(20),
  FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);
CREATE TABLE order_items(
  id serial PRIMARY KEY,
  order_id int NOT NULL,
  product_id int NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);
INSERT INTO orders (customer_id, order_status)
VALUES (1, 'In Progress'),
(2, 'Placed'),
(2, 'Complete'),
(3, 'Placed');

INSERT INTO order_items (order_id, product_id)
VALUES (1, 3),
(1, 5),
(1, 6),
(1, 8),
(2, 2),
(2, 5),
(2, 7),
(3, 4),
(3, 2),
(3, 5),
(3, 5),
(3, 6),
(3, 10),
(3, 9),
(4, 1),
(4, 5);


-- SQL Joins

-- 1. Connect to the encyclopedia database. Write a query to return all of the country names along with their appropriate continent names.
SELECT countries.name, continents.continent_name
  FROM countries
  JOIN continents
  ON countries.continent_id = continents.id;

-- 2. Write a query to return all of the names and capitals of the European countries.
SELECT name, capital FROM countries WHERE continent_id = 3;

-- 3. Write a query to return the first name of any singer who had an album released under the Warner Bros label.
SELECT DISTINCT singers.first_name
  FROM singers JOIN albums
  ON singers.id = albums.singer_id
  WHERE albums.label LIKE '%Warner Bros%';

-- 4. Write a query to return the first name and last name of any singer who released an album in the 80s and who is still living, along with the names of the album that was released and the release date. Order the results by the singer's age (youngest first).
SELECT singers.first_name, singers.last_name, albums.album_name, albums.released
  FROM singers JOIN albums
  ON singers.id = albums.singer_id
  WHERE albums.released >= '1980-01-01'
  AND albums.released < '1990-01-01'
  AND deceased = false
  ORDER BY singers.date_of_birth DESC;

-- 5. Write a query to return the first name and last name of any singer without an associated album entry.
SELECT singers.first_name, singers.last_name
  FROM singers LEFT JOIN albums
  ON singers.id = albums.singer_id
  WHERE albums.singer_id IS NULL;

-- 6. Rewrite the query for the last question as a sub-query.
SELECT first_name, last_name
  FROM singers
  WHERE id NOT IN (
    SELECT singer_id FROM albums
  );

-- 7. Connect to the ls_burger database. Return a list of all orders and their associated product items.
SELECT orders.*, products.*
  FROM orders JOIN order_items
  ON orders.id = order_items.order_id
  JOIN products ON order_items.product_id = products.id;

-- 8. Return the id of any order that includes Fries. Use table aliasing in your query.
SELECT o.id
  FROM orders AS o JOIN order_items AS oi
  ON o.id = oi.order_id
  JOIN products AS p
  ON oi.product_id = p.id
  WHERE p.product_name = 'Fries';

-- 9. Build on the query from the previous question to return the name of any customer who ordered fries. Return this in a column called 'Customers who like Fries'. Don't repeat the same customer name more than once in the results.
SELECT DISTINCT c.customer_name AS "Customer who like fries"
  FROM customers AS c JOIN orders AS o
  ON c.id = o.customer_id
  JOIN order_items AS oi
  ON o.id = oi.order_id
  JOIN products AS p
  ON oi.product_id = p.id
  WHERE p.product_name = 'Fries';

-- 10. Write a query to return the total cost of Natasha O'Shea's orders.
SELECT sum(p.product_cost)
  FROM products AS p JOIN order_items AS oi
  ON p.id = oi.product_id
  JOIN orders AS o
  ON oi.order_id = o.id
  JOIN customers AS c
  ON o.customer_id = c.id
  WHERE c.customer_name = 'Natasha O''Shea';

-- 11. Write a query to return the name of every product included in an order alongside the number of times it has been ordered. Sort the results by product name, ascending.
SELECT p.product_name, count(oi.product_id)
  FROM products AS p JOIN order_items AS oi
  ON p.id = oi.product_id
  GROUP BY p.product_name
  ORDER BY p.product_name ASC;