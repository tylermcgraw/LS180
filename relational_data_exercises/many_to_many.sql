-- 1
ALTER TABLE books_categories
  ALTER COLUMN book_id SET NOT NULL,
  ALTER COLUMN category_id SET NOT NULL,
  DROP CONSTRAINT books_categories_book_id_fkey,
  DROP CONSTRAINT books_categories_category_id_fkey,
  ADD FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE,
  ADD FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE;

-- 2
SELECT b.id, b.author, STRING_AGG(c.name, ', ') AS categories
  FROM books AS b INNER JOIN books_categories AS bc
  ON b.id = bc.book_id
  INNER JOIN categories AS c
  ON bc.category_id = c.id
  GROUP BY b.id;

-- 3
ALTER TABLE books ALTER COLUMN title TYPE text;

INSERT INTO books (author, title)
  VALUES ('Lynn Sherr', 'Sally Ride: America''s First Woman in Space'),
  ('Charlotte Brontë', 'Jane Eyre'),
  ('Meeru Dhalwala and Vikram Vij', 'Vij''s: Elegant and Inspired Indian Cuisine');

INSERT INTO categories (name)
  VALUES ('Space Exploration'),
  ('Cookbook'),
  ('South Asia');

INSERT INTO books_categories (book_id, category_id)
  VALUES (4, 1), (4, 5), (4, 7),
  (5, 2), (5, 4),
  (6, 8), (6, 1), (6, 9);

-- 4
ALTER TABLE books_categories
  ADD UNIQUE (book_id, category_id);

-- 5
SELECT c.name, COUNT(c.id) AS book_count , STRING_AGG(b.title, ', ') AS book_titles
  FROM books AS b
    INNER JOIN books_categories AS bc
      ON b.id = bc.book_id
    INNER JOIN categories AS c
      ON c.id = bc.category_id
  GROUP BY c.name
  ORDER BY c.name;