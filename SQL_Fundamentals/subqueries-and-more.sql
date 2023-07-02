/* SQL Fundamentals Subqueries and More */

-- 1
createdb auction

CREATE TABLE bidders (
  id serial PRIMARY KEY,
  name text NOT NULL
);

CREATE TABLE items (
  id serial PRIMARY KEY,
  name text NOT NULL,
  initial_price numeric(6,2) NOT NULL CHECK(initial_price BETWEEN 0.01 AND 1000.00),
  sales_price numeric(6,2) CHECK(sales_price BETWEEN 0.01 AND 1000.00)
);

CREATE TABLE bids (
  id serial PRIMARY KEY,
  bidder_id integer NOT NULL REFERENCES bidders(id) ON DELETE CASCADE,
  item_id integer NOT NULL REFERENCES items (id) ON DELETE CASCADE,
  amount numeric(6,2) NOT NULL CHECK(amount BETWEEN 0.01 AND 1000.00)
);

CREATE INDEX ON bids (bidder_id, item_id);

\copy bidders from 'bidders.csv' WITH HEADER CSV
\copy items from 'items.csv' WITH HEADER CSV
\copy bids from 'bids.csv' WITH HEADER CSV

-- 2

SELECT items.name AS "Bid  on Items" FROM items 
WHERE id IN (SELECT DISTINCT item_id FROM bids);

-- 3

SELECT name AS "Not Bid On" FROM items
WHERE id NOT IN (SELECT DISTINCT item_id FROM bids);

-- 4
SELECT name FROM bidders WHERE EXISTS 
(SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);

SELECT DISTINCT name from bidders
INNER JOIN bids ON bidders.id = bids.bidder_id;

-- 5
SELECT max(count) FROM
(SELECT count(bidder_id) FROM bids GROUP BY bidder_id) AS count;

-- 6
SELECT items.name, (SELECT count(bids.id) FROM bids WHERE items.id = bids.item_id)
 FROM items;

-- FE
SELECT items.name, count(bids.id) FROM items
LEFT OUTER JOIN bids ON items.id = bids.item_id
GROUP BY items.id
ORDER BY items.id;

-- 7

SELECT id FROM items WHERE name LIKE 'Painting';

SELECT id FROM items
WHERE ROW('Painting', 100.00, 250.00) = ROW(name, initial_price, sales_price);

-- 8
EXPLAIN SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);

EXPLAIN ANALYZE SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);

-- 9
EXPLAIN ANALYZE SELECT MAX(bid_counts.count) FROM
  (SELECT COUNT(bidder_id) FROM bids GROUP BY bidder_id) AS bid_counts;

EXPLAIN ANALYZE SELECT COUNT(bidder_id) AS max_bid FROM bids
  GROUP BY bidder_id
  ORDER BY max_bid DESC
  LIMIT 1;

-- The first query using a subquery is more efficient.
