/* SQL Fundamentals Many-To-Many */

-- 1
createdb billing
psql -d billing

CREATE TABLE customers (
  id serial PRIMARY KEY,
  name text NOT NULL,
  payment_token char(8) NOT NULL UNIQUE CHECK (payment_token ~ '^[A-Z]{8}$')
);

CREATE TABLE services (
  id serial PRIMARY KEY,
  description text NOT NULL,
  price numeric(10,2) NOT NULL CHECK (price >= 0.00)
);

INSERT INTO customers (name, payment_token)
VALUES
('Pat Johnson' ,'XHGOAHEQ'),
('Nancy Monreal' ,'JKWQPJKL'),
('Lynn Blake' ,'KLZXWEEE'),
('Chen Ke-Hua' ,'KWETYCVX'),
('Scott Lakso' ,'UUEAPQPS'),
('Jim Pornot' ,'XKJEYAZA');

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

CREATE TABLE customers_services (
 id serial PRIMARY KEY,
 customer_id integer REFERENCES customers(id) ON DELETE CASCADE NOT NULL,
 service_id integer REFERENCES services(id) NOT NULL,
 UNIQUE (customer_id, service_id)
);

INSERT INTO customers_services (customer_id, service_id)
VALUES (1,1), (1,2), (1,3),
(3,1), (3,2), (3,3), (3,4), (3,5),
(4,1), (4,4),
(5,1), (5,2), (5,6),
(6,1), (6,6), (6, 7);

-- 2
SELECT DISTINCT customers.id, customers.name, customers.payment_token FROM customers
INNER JOIN customers_services ON customers_services.customer_id = customers.id;

-- Could also use customers.* to get all columns from just the customers table.

-- 3
SELECT DISTINCT customers.* FROM customers
LEFT OUTER JOIN customers_services ON customers_services.customer_id = customers.id
WHERE customers_services.id IS NULL;

-- FE

SELECT DISTINCT customers.*, services.* FROM customers
FULL OUTER JOIN customers_services ON customers_services.customer_id = customers.id
FULL OUTER JOIN services ON customers_services.service_id = services.id
WHERE customers_services.id IS NULL;

-- 4
SELECT services.description FROM customers_services
RIGHT OUTER JOIN services ON services.id = customers_services.service_id
WHERE customers_services.id IS NULL;

-- 5
SELECT customers.name, 
string_agg(services.description, ', ') AS services 
FROM customers
LEFT OUTER JOIN customers_services 
ON customers.id = customers_services.customer_id
LEFT OUTER JOIN services 
ON customers_services.service_id = services.id
GROUP BY customers.id;

-- FE

SELECT CASE WHEN lag(customers.name)
         OVER (ORDER BY customers.name) = customers.name THEN NULL
         ELSE customers.name
         END AS name,
       services.description
FROM customers
LEFT OUTER JOIN customers_services
             ON customer_id = customers.id
LEFT OUTER JOIN services
             ON services.id = service_id;

-- 6
SELECT services.description, count(customers_services.id) FROM services
LEFT OUTER JOIN customers_services ON services.id = customers_services.service_id
GROUP BY services.description
HAVING count(customers_services.id) >= 3
ORDER BY services.description;

-- 7
SELECT sum(price) as gross FROM services
JOIN customers_services ON services.id = customers_services.service_id;

-- 8
INSERT INTO customers (name, payment_token) VALUES ('John Doe', 'EYODHLCN');

INSERT INTO customers_services (customer_id, service_id)
VALUES (8, 1), (8, 2), (8, 3);

-- 9
SELECT SUM(price) FROM services
INNER JOIN customers_services ON services.id = service_id
WHERE price > 100;

SELECT sum(price) FROM customers
CROSS JOIN services
WHERE price > 100;

-- 10
-- As service_id is the foreign key for services id, it needs to be removed from this table first.
DELETE FROM customers_services
WHERE service_id = 7;

DELETE FROM services
WHERE id = 7;

DELETE FROM customers
WHERE id = 4;