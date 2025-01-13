-- 2
ALTER TABLE orders
  ADD CONSTRAINT orders_product_id_fkey FOREIGN KEY (product_id) REFERENCES products(id);

-- 3
INSERT INTO products (name)
  VALUES ('small bolt'),
  ('large bolt');
INSERT INTO orders (product_id, quantity)
  VALUES (1, 10),
  (1, 25),
  (2, 15);

-- 4
SELECT p.name, o.quantity
  FROM products AS p INNER JOIN orders AS o
  ON p.id = o.product_id;

-- 5
INSERT INTO orders (quantity)
  VALUES (17);

-- 6
ALTER TABLE orders
  ALTER COLUMN product_id SET NOT NULL;

-- 7
DELETE FROM orders WHERE product_id IS NULL;

-- 8
CREATE TABLE reviews(
  id serial PRIMARY KEY,
  order_id int REFERENCES products(id),
  review text NOT NULL
);

-- 9
INSERT INTO reviews (order_id, review)
  VALUES (1, 'a little small'),
  (1, 'very round!'),
  (2, 'could dhave been smaller');

-- 10
-- false - see 5