-- 1
CREATE DATABASE auction;
\c auction

CREATE TABLE bidders(
  id serial PRIMARY KEY,
  name text NOT NULL
);

CREATE TABLE items(
  id serial PRIMARY KEY,
  name text NOT NULL,
  initial_price numeric(6,2) NOT NULL CHECK (initial_price > 0.00 AND initial_price <= 1000.00),
  sales_price numeric(6,2) CHECK (sales_price > 0.00 AND sales_price <= 1000.00)
);

CREATE TABLE bids(
  id serial PRIMARY KEY,
  bidder_id integer REFERENCES bidders(id) ON DELETE CASCADE,
  item_id integer REFERENCES items(id) ON DELETE CASCADE,
  amount numeric(6,2) NOT NULL CHECK (amount > 0.00 AND amount <= 1000.00)
);

CREATE INDEX ON bids (bidder_id, item_id);

-- Copy data for bidders from the csv file to the bidders table
\copy bidders FROM 'bidders.csv' WITH HEADER CSV

-- Copy data for items from the csv file to the items table
\copy items FROM 'items.csv' WITH HEADER CSV

-- Copy data for bids from the csv file to the bids table
\copy bids FROM 'bids.csv' WITH HEADER CSV

-- 2
SELECT DISTINCT name AS "Bid on Items" FROM items
  WHERE id IN
    (SELECT item_id FROM bids);

-- 3
SELECT DISTINCT name AS "Not Bid On" FROM items
  WHERE id NOT IN
    (SELECT item_id FROM bids);

-- 4
SELECT DISTINCT name FROM bidders
  WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);

-- 5
SELECT MAX(bid_counts.count) FROM (
  SELECT bidder_id, COUNT(item_id) AS count FROM bids
  GROUP BY bidder_id
) AS bid_counts;

-- 6
SELECT name, (
  SELECT COUNT(item_id) FROM bids
  WHERE items.id = bids.item_id
) FROM items;

-- 7
SELECT id FROM (
  SELECT * FROM (
    SELECT * FROM items WHERE name = 'Painting'
    ) AS painting
    WHERE initial_price = 100.00
  ) AS price
  WHERE sales_price = 250.00;
-- OR
SELECT id FROM items
  WHERE (items.name, items.initial_price, items.sales_price)
  = ('Painting', 100.00, 250.00);

-- 8
EXPLAIN ANALYZE SELECT DISTINCT name FROM bidders
  WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);

-- 9
EXPLAIN ANALYZE SELECT MAX(bid_counts.count) FROM
  (SELECT COUNT(bidder_id) FROM bids GROUP BY bidder_id) AS bid_counts;

EXPLAIN ANALYZE SELECT COUNT(bidder_id) AS max_bid FROM bids
  GROUP BY bidder_id
  ORDER BY max_bid DESC
  LIMIT 1;