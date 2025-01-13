-- 2
SELECT count(id) FROM tickets;

-- 3
SELECT count(DISTINCT customer_id) FROM tickets;

-- 4
SELECT ROUND(count(DISTINCT tickets.customer_id) / count(DISTINCT customers.id)::decimal * 100, 2) AS percent
  FROM tickets RIGHT OUTER JOIN customers ON tickets.customer_id = customers.id;

-- 5
SELECT events.name, COUNT(events.name) AS popularity
  FROM events INNER JOIN tickets ON events.id = tickets.event_id
  GROUP BY events.name
  ORDER BY popularity DESC;

-- 6
SELECT c.id, c.email, COUNT(DISTINCT t.event_id) AS count
  FROM customers AS c INNER JOIN tickets AS t
  ON c.id = t.customer_id
  GROUP BY c.id
  HAVING COUNT(DISTINCT t.event_id) = 3;

-- 7
SELECT e.name AS event, e.starts_at, sections.name, seats.row, seats.number AS seat
  FROM events AS e INNER JOIN tickets AS t
  ON e.id = t.event_id
  JOIN seats
  ON seats.id = t.seat_id
  JOIN sections
  ON seats.section_id = sections.id
  JOIN customers
  ON t.customer_id = customers.id
  WHERE customers.email = 'gennaro.rath@mcdermott.co';