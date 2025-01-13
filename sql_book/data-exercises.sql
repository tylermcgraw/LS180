-- Add Data with INSERT

-- 1. Make sure you are connected to the encyclopedia database. Add the following data to the countries table:
INSERT INTO countries VALUES (DEFAULT, 'France', 'Paris', 67158000);

-- 2. Now add the following additional data to the countries table:
INSERT INTO countries (name, capital, population)
  VALUES ('USA', 'Washington D.C.', 325365189),
    ('Germany', 'Berlin', 82349400),
    ('Japan', 'Tokyo', 126672000);

-- 3. Add an entry to the celebrities table for the singer and songwriter Bruce Springsteen, who was born on September 23rd 1949 and is still alive.
INSERT INTO celebrities (first_name, last_name, occupation, date_of_birth, deceased)
  VALUES ('Bruce', 'Springsteen', 'Singer Songwriter', 'Sep-23-1949', false);

-- 4. Add an entry for the actress Scarlett Johansson, who was born on November 22nd 1984. Use the default value for the deceased column.
INSERT INTO celebrities (first_name, last_name, occupation, date_of_birth)
  VALUES ('Scarlett', 'Johansson', 'Actress', 'Nov-22-1984');

-- 5. Add the following two entries to the celebrities table with a single INSERT statement. For Frank Sinatra set true as the value for the deceased column. For Tom Cruise, don't set an explicit value for the deceased column, but use the default value.
INSERT INTO celebrities (first_name, last_name, occupation, date_of_birth, deceased)
  VALUES ('Frank', 'Sinatra', 'Singer, Actor', 'Dec-12-1915', true),
  ('Tom', 'Cruise', 'Actor', 'Jul-03-1962', DEFAULT);

-- 7. Update the last_name column of the celebrities table so that the data in the previous question can be entered, and then add the data to the table.
ALTER TABLE celebrities
  ALTER COLUMN last_name DROP NOT NULL;
INSERT INTO celebrities (first_name, occupation, date_of_birth, deceased)
                 VALUES ('Madonna', 'Singer, Actress', '1958-08-16', false),
                        ('Prince', 'Singer, Songwriter, Musician, Actor', '1958-06-07', true);

-- 9. Check the schema of the animals table. What would happen if we tried to insert the following data to the table?
ALTER TABLE animals
  DROP CONSTRAINT unique_binomial_name;
INSERT INTO animals (name, binomial_name, max_weight_kg, max_age_years, conservation_status)
             VALUES ('Dove', 'Columbidae Columbiformes', 2, 15, 'LC'),
                    ('Golden Eagle', 'Aquila Chrysaetos', 6.35, 24, 'LC'),
                    ('Peregrine Falcon', 'Falco Peregrinus', 1.5, 15, 'LC'),
                    ('Pigeon', 'Columbidae Columbiformes', 2, 15, 'LC'),
                    ('Kakapo', 'Strigops habroptila', 4, 60,'CR');

-- 10. Connect to the ls_burger database and examine the schema for the orders table. Based on the table schema and following information, write and execute an INSERT statement to add the appropriate data to the orders table.
INSERT INTO orders (customer_name, customer_email, customer_loyalty_points, burger, side, drink, burger_cost, side_cost, drink_cost)
            VALUES ('James Bergman', 'james1998@email.com', 28, 'LS Chicken Burger', 'Fries', 'Cola', 4.50, 0.99, 1.50),
                   ('Natasha O''Shea', 'natasha@osheafamily.com', 18, 'LS Cheeseburger', 'Fries', NULL, 3.50, 0.99, DEFAULT),
                   ('Natasha O''Shea', 'natasha@osheafamily.com', 42, 'LS Double Deluxe Burger', 'Onion Rings', 'Chocolate Shake', 6.00, 1.50, 2.00),
                   ('Aaron Muller', NULL, 10, 'LS Burger', NULL, NULL, 3.00, DEFAULT, DEFAULT);


-- Select Queries

-- 1. Make sure you are connected to the encyclopedia database. Write a query to retrieve the population of the USA.
SELECT population FROM countries WHERE name = 'USA';

-- 2. Write a query to return the population and the capital (with the columns in that order) of all the countries in the table.
SELECT population, capital FROM countries;

-- 3. Write a query to return the names of all the countries ordered alphabetically.
SELECT name FROM countries ORDER BY name;

-- 4. Write a query to return the names and the capitals of all the countries in order of population, from lowest to highest.
SELECT name, capital FROM countries ORDER BY population;

-- 5. highest to lowest
SELECT name, capital FROM countries ORDER BY population DESC;

-- 6. Write a query on the animals table, using ORDER BY, that will return the following output:
SELECT name, binomial_name, max_weight_kg, max_age_years
  FROM animals
  ORDER BY max_age_years, max_weight_kg, name DESC;

-- 7. Write a query that returns the names of all the countries with a population greater than 70 million.
SELECT name FROM countries WHERE population > 70000000;

-- 8. Write a query that returns the names of all the countries with a population greater than 70 million but less than 200 million.
SELECT name FROM countries WHERE population BETWEEN 70000000 AND 200000000;

-- 9. Write a query that will return the first name and last name of all entries in the celebrities table where the value of the deceased column is not true.
SELECT first_name, last_name FROM celebrities WHERE deceased <> true OR deceased IS NULL;

-- 10. Write a query that will return the first and last names of all the celebrities who sing.
SELECT first_name, last_name FROM celebrities WHERE occupation ILIKE '%Singer%';

-- 11. Write a query that will return the first and last names of all the celebrities who act.
SELECT first_name, last_name FROM celebrities WHERE occupation ILIKE '%Act%';

-- 12. Write a query that will return the first and last names of all the celebrities who both sing and act.
SELECT first_name, last_name FROM celebrities WHERE occupation ILIKE '%Singer%' AND occupation ILIKE '%Act%';

-- 13. Connect to the ls_burger database. Write a query that lists all of the burgers that have been ordered, from cheapest to most expensive, where the cost of the burger is less than $5.00.
SELECT burger FROM orders WHERE burger_cost < 5 ORDER BY burger_cost;

-- 14. Write a query to return the customer name and email address and loyalty points from any order worth 20 or more loyalty points. List the results from the highest number of points to the lowest.
SELECT customer_name, customer_email, customer_loyalty_points FROM orders WHERE customer_loyalty_points >= 20 ORDER BY customer_loyalty_points DESC;

-- 15. Write a query that returns all the burgers ordered by Natasha O'Shea.
SELECT burger FROM orders WHERE customer_name = 'Natasha O''Shea';

-- 16. Write a query that returns the customer name from any order which does not include a drink item.
SELECT customer_name FROM orders WHERE drink IS NULL;

-- 17. Write a query that returns the three meal items for any order which does not include fries.
SELECT burger, side, drink FROM orders WHERE side <> 'Fries' OR side IS NULL;

-- 18. Write a query that returns the three meal items for any order that includes both a side and a drink.
SELECT burger, side, drink FROM orders WHERE side IS NOT NULL AND drink IS NOT NULL;


-- More on Select

-- 1. Make sure you are connected to the encyclopedia database. Write a query to retrieve the first row of data from the countries table.
SELECT * FROM countries LIMIT 1;

-- 2. Write a query to retrieve the name of the country with the largest population.
SELECT name FROM countries ORDER BY population DESC LIMIT 1;

-- 3. Write a query to retrieve the name of the country with the second largest population.
SELECT name FROM countries ORDER BY population DESC LIMIT 1 OFFSET 1;

-- 4. Write a query to retrieve all of the unique values from the binomial_name column of the animals table.
SELECT DISTINCT binomial_name FROM animals;

-- 5. Write a query to return the longest binomial name from the animals table.
SELECT binomial_name FROM animals ORDER BY length(binomial_name) DESC LIMIT 1;

-- 6. Write a query to return the first name of any celebrity born in 1958.
SELECT first_name FROM celebrities WHERE date_part('year', date_of_birth) = '1958';

-- 7. Write a query to return the highest maximum age from the animals table.
SELECT max(max_age_years) FROM animals;

-- 8. Write a query to return the average maximum weight from the animals table.
SELECT avg(max_weight_kg) FROM animals;

-- 9. Write a query to return the number of rows in the countries table.
SELECT count(id) FROM countries;

-- 10. Write a query to return the total population of all the countries in the countries table.
SELECT sum(population) FROM countries;

-- 11. Write a query to return each unique conservation status code alongside the number of animals that have that code.
SELECT conservation_status, count(conservation_status) FROM animals GROUP BY conservation_status;

-- 12. Connect to the ls_burger database. Write a query that returns the average burger cost for all orders that include fries.
SELECT avg(burger_cost) FROM orders WHERE side = 'Fries';

-- 13. Write a query that returns the cost of the cheapest side ordered.
SELECT min(side_cost) FROM orders WHERE side IS NOT NULL;

-- 14. Write a query that returns the number of orders that include Fries and the number of orders that include Onion Rings.
SELECT side, count(id) FROM orders WHERE side IS NOT NULL GROUP BY side;


-- Update Data in a Table

-- 1. Add a column to the animals table called class to hold strings of up to 100 characters. Update all the rows in the table so that this column holds the value Aves.
ALTER TABLE animals ADD COLUMN class varchar(100);
UPDATE animals SET class = 'Aves';

-- 2. Add two more columns to the animals table called phylum and kingdom. Both should hold strings of up to 100 characters. Update all the rows in the table so that phylum holds the value Chordata and kingdom holds Animalia for all the rows in the table.
ALTER TABLE animals
  ADD COLUMN phylum varchar(100),
  ADD COLUMN kingdom varchar(100);
UPDATE animals
  SET phylum = 'Chordata', kingdom = 'Animalia';

-- 3. Add a column to the countries table called continent to hold strings of up to 50 characters. Update all the rows in the table so France and Germany have a value of Europe for this column, Japan has a value of Asia and the USA has a value of North America.
ALTER TABLE countries ADD COLUMN continent varchar(50);
UPDATE countries SET continent = 'Asia' WHERE name = 'Japan';
UPDATE countries SET continent = 'Europe' WHERE name = 'Germany' OR name = 'France';
UPDATE countries SET continent = 'North America' WHERE name = 'USA';

-- 4. In the celebrities table, update the Elvis row so that the value in the deceased column is true. Then change the column so that it no longer allows NULL values.
UPDATE celebrities SET deceased = true WHERE first_name = 'Elvis';
ALTER TABLE celebrities ALTER COLUMN deceased SET NOT NULL;

-- 5. Remove Tom Cruise from the celebrities table.
DELETE FROM celebrities WHERE first_name = 'Tom' AND last_name = 'Cruise';

-- 6. Change the name of the celebrities table to singers, and remove anyone who isn't a singer.
ALTER TABLE celebrities RENAME TO singers;
DELETE FROM singers WHERE occupation NOT ILIKE '%Singer%';

-- 7. Remove all the rows from the countries table.
DELETE FROM countries;

-- 8. Connect to the ls_burger database. Change the drink on James Bergman's order from a Cola to a Lemonade.
UPDATE orders SET drink = 'Lemonade' WHERE customer_name = 'James Bergman';

-- 9. Add Fries to Aaron Muller's order. Make sure to add the cost ($0.99) to the appropriate field and add 3 loyalty points to the current total.
UPDATE orders SET side = 'Fries', side_cost = 0.99, customer_loyalty_points = 13 WHERE customer_name = 'Aaron Muller';

-- 10. The cost of Fries has increased to $1.20. Update the data in the table to reflect this.
UPDATE orders SET side_cost = 1.20 WHERE side = 'Fries';