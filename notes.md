# Notes For LS_170 exercises #

# SQL Book 'Getting Started' exercises

# 1.
SELECT customer_name FROM orders;

# 2.
SELECT * FROM orders
WHERE drink = 'Chocolate Shake';

# 3.
SELECT burger, side, drink 
FROM orders
where id = 2;

# 4.
SELECT customer_name FROM orders
WHERE side = 'Onion Rings';

# SQL Book 'Your first Database: Scheme' exercises pt1

# 1.
createdb database_one

# 2.
psql -d database_one

# 3.
CREATE DATABASE database_two;

# 4.
\c database_two

# 5.
\list

# 6.
\c database_one
DROP DATABASE database_two;

# 7.
\q
dropdb database_one
dropdb ls_burger

# SQL Book 'Your first Database: Scheme' exercises pt2

# 1.
createdb encyclopedia
psql -d encyclopedia

# 2.
CREATE TABLE countries (
  id serial,
  name varchar(50) UNIQUE NOT NULL,
  capital varchar(50) NOT NULL,
  population integer
);

# 3.
CREATE TABLE famous_people (
  id serial,
  name varchar(100) NOT NULL,
  occupation varchar(150),
  date_of_birth varchar(50),
  deceased boolean DEFAULT false
);

# 4.
CREATE TABLE animals (
  id serial,
  name varchar(100) NOT NULL,
  binomial_name varchar(100) NOT NULL,
  max_weight_lbs decimal(8,3),
  max_age_years integer,
  conservation_status char(2)
);

For conservation_status, char or varchar could be used. Though it is convention to use char when we know exaclty how long the strill will be every time.

# 5.
\dt

# 6.
\d animals

# 7.
\q
createdb ls_burger
psql -d ls_burger

OR

CREATE DATABASE ls_burger;
\connect (or \c) ls_burger

# 8.
CREATE TABLE orders (
  id serial,
  customer_name varchar(100) NOT NULL,
  burger varchar(50),
  side varchar(50),
  drink varchar(50),
  order_total decimal(4,2) NOT NULL
);

# SQL Book 'Your first Database: Scheme' exercises pt3

# 1.
\c encyclopedia
ALTER TABLE famous_people
  RANAME TO celebrities;

# 2.
ALTER TABLE celebrities
  RENAME COLUMN name TO first_name;

ALTER TABLE celebrities
  ALTER COLUMN first_name TYPE varchar(80);

# 3.
ALTER TABLE celebrities
  ADD COLUMN last_name
  varchar(100)
  NOT NULL;

# 4.
ALTER TABLE celebrities
  ALTER COLUMN date_of_birth TYPE date
    USING date_of_birth::date,
  ALTER COLUMN date_of_birth SET NOT NULL;

# 5.
ALTER TABLE animals
  RENAME COLUMN max_weight_lbs TO max_weight_kgs;

ALTER TABLE animals
  ALTER COLUMN max_weight_kgs TYPE decimal(10,4);

# 6.
ALTER TABLE animals
  ADD CONSTRAINT unique_binomial_name UNIQUE
  (binomial_name);

# 7.

\c ls_burger

ALTER TABLE orders
  ADD COLUMN customer_email varchar(50),
  ADD COLUMN customer_loyalty_points integer DEFAULT 0;

# 8.

ALTER TABLE orders
  ADD COLUMN burger_cost decimal(4,2) DEFAULT 0,
  ADD COLUMN side_cost decimal(4,2) DEFAULT 0,
  ADD COLUMN drink_cost decimal(4,2) DEFAULT 0;

# 9.
ALTER TABLE orders DROP COLUMN order_total

# SQL Book 'Your first Database: Data' exercises pt1

# 1.
\c encyclopedia
INSERT INTO countries (name, capital, population)
('France', 'Paris', 67158000);

# 2.
INSERT INTO countries (name, capital, population)
VALUES
  ('USA', 'Washington D.C.', 325365189),
  ('Germany', 'Berlin', 82349400),
  ('Japan, 'Tokyo', 126672000);

# 3.
INSERT INTO celebrities (first_name, last_name, date_of_birth, occupation, deceased)
VALUES ('Bruce', 'Springsteen', '1949-09-23', 'singer, Songwriter', false);

# 4.
INSERT INTO celebrities (first_name, last_name, date_of_birth, occupation)
VALUES ('Scarlet', 'Johansson', '1984-11-22', 'Actress')

# 5.
INSERT INTO celebrities (first_name, last_name, occupation, date_of_birth, deceased)
VALUES ('Frank', 'Sinatra', 'Singer, Actor', '1915-12-12', true),
       ('Tom', 'Cruise', 'Actor', '1962-7-3', DEFAULT); 

# 6.
Error as we need to provide a value for 'last_name'.

Check the schema for celebrities using the `\d` metecommand.

# 7.

ALTER TABLE celebrities
  ALTER COLUMN last_name DROP NOT NULL;

INSERT INTO celebrities (first_name, occupation, date_of_birth, deceased)
  VALUES ('Madona', 'Signer, Actress', '1958-08-16', false),
         ('Prince', 'Singer, Songwriter, Musician, Actor', '1958-06-07', true);

# 8.
Even though the 'deceased' column is a boolean with a default value of `false`, as we have not specified a 'NOT NULL' constraint, PostgreSQL will actually set the value to `null`.

Generally, we want to avoid boolean columns being able to have NULL values, since booleans by their nature should only have two states of true or false.

# 9.
ALTER TABLE animals
  DROP CONSTRAINT unique_binomial_name;

INSERT INTO animals (name, binomial_name, max_weight_kgs, max_age_years, conservation_status)
VALUES ('Dove', 'Columbidae Columbiformes', 2, 15, 'LC'),
       ('Golden Eagle', 'Aquila Chrysaetos', 6.35, 24, 'LC'),
       ('Peregrine Falcon', 'Falco Peregrinus', 1.5, 15, 'LC'),
       ('Pigeon', 'Columbidae Columbiformes', 2, 15, 'LC'),
       ('Kakapo', 'Strigops habroptila', 4, 60,'CR');

# 10.

\c ls_burger

INSERT INTO orders (customer_name, customer_email, burger, side, drink, customer_loyalty_points, burger_cost, side_cost, drink_cost)
VALUES ('James Bergman', 'james1998@email.com', 'LS Chicken Burger', 'Fries', 'Cola', 28, 4.50, .99, 1.50),
       ('Natasha O''Shea', 'natasha@osheafamily.com', 'LS Cheeseburger', 'Fries', null, 18, 3.50, .99, 0),
       ('Natasha O''Shea', 'natasha@osheafamily.com', 'LS Double Deluxe Burger', 'Onion Rings', 'Chocolate Shake', 42, 6.00, 1.50, 2.00),
       ('Aaron Muller', null, 'LS Burger', null, null, 10, 3.00, 0, 0);
       
# SQL Book 'Your first Database: Data' exercises pt2

# 1.

SELECT population
FROM countires
WHERE name = 'USA'; # Or could use name LIKE 'USA';

# 2.

SELECT population, capital
FROM countries;

# 3.
SELECT name
FROM countries
ORDER BY name;

# 4.
SELECT name, capital FROM countries ORDER BY population;

# 5.
SELECT name, capital FROM countries ORDER BY population DESC;

# 6.
SELECT name, binomial_name, max_weight_kgs, max_age_years
FROM animals
ORDER BY max_age_years, max_weight_kgs, name DESC;

# 7.
SELECT name FROM countries WHERE population > 70000000;

# 8.
SELECT name FROM countries WHERE population > 70000000 AND population < 200000000;

# 9.
SELECT first_name, last_name FROM celebrities WHERE deceased <> true OR deceased IS NULL;

# 10.
SELECT first_name, last_name FROM celebrities WHERE occupation ILIKE '%singer%';

# 11.
SELECT first_name, last_name FROM celebrities WHERE occupation ILIKE '%Actor%' OR occupation ILIKE '%actress%';

# 12.
SELECT first_name, last_name FROM celebrities WHERE (occupation ILIKE '%actor%' OR occupation ILIKE '%actress%')
AND occupation ILIKE '%singer%';

# 13.
SELECT burger FROM orders
WHERE burger IS NOT NULL
  AND  burger_cost < 5.00
ORDER BY burger_cost;

# 14.
SELECT customer_name, customer_email, customer_loyalty_points FROM orders
WHERE customer_loyalty_points >= 20
ORDER BY customer_loyalty_points DESC;

# 15.
SELECT burger FROM orders
WHERE customer_name = 'Natasha O''Shea';

# 16.
SELECT customer_name FROM orders
WHERE drink IS NULL;

# 17.
SELECT burger, side, drink FROM orders
WHERE side != 'Fries'
OR side IS NULL;

# 18.
SELECT burger, side, drink FROM orders
WHERE side IS NOT NULL
AND drink IS NOT NULL;

# SQL Book 'Your first Database: Data' exercises pt3

# 1.
SELECT * FROM countries LIMIT 1;

# 2.
SELECT name FROM countries
ORDER BY population DESC
LIMIT 1;

# 3.
SELECT name FROM countries
ORDER BY population DESC
LIMIT 1 OFFSET 1;

# 4.
SELECT DISTINCT binomial_name FROM animals;

# 5.
SELECT binomial_name FROM animals
ORDER BY length(binomial_name) DESC
LIMIT 1;

# 6.
SELECT first_name FROM celebrities
WHERE date_part('year', date_of_birth) = '1958';

# 7.
SELECT max_age_years FROM animals
ORDER BY max_age_years DESC
LIMIT 1;

OR 

SELECT max(max_age_years) FROM animals;

# 8.
SELECT avg(max_weight_kgs) FROM animals;

# 9.
SELECT count(id) FROM countries;
# Or any column name for this query.

# 10.
SELECT sum(population) FROM countries;

# 11.
SELECT conservation_status, count(name) 
FROM animals 
GROUP BY conservation_status;

# 12.
SELECT avg(burger_cost) FROM orders WHERE side = 'Fries';

# 13.
SELECT min(side_cost) FROM orders WHERE side IS NOT NULL;

# 14.
SELECT side, count(id) FROM orders WHERE side = 'Fries' OR side = 'Onion Rings' GROUP BY side;