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

# SQL Book 'Your first Database: Data' exercises pt4

# 1.
\c encyclopedia
ALTER TABLE animals
  ADD COLUMN class varchar(100);

UPDATE animals SET class='Aves';

# 2.
ALTER TABLE animals
  ADD COLUMN phylum varchar(100),
  ADD COLUMN kingdom varchar(100);

UPDATE animals SET
  phylum='Chordata',
  kingdom='Animalia';

# 3.
ALTER TABLE countries
  ADD COLUMN continent varchar(50);

UPDATE countries
  SET continent='Europe'
  WHERE name = 'France' OR name = 'Germany';

UPDATE countries
  SET continent='Asia'
  WHERE name = 'Japan';

UPDATE countries
  SET continent='North America'
  WHERE name = 'USA';

# 4.
UPDATE celebrities
  SET deceased = true
  WHERE first_name = 'Elvis';

ALTER TABLE celebrities
  ALTER COLUMN deceased
  SET NOT NULL;

# 5.
DELETE FROM celebrities
WHERE first_name = 'Tom' AND last_name = 'Cruise';

# 6.
ALTER TABLE celebrities
  RENAME TO singers;

DELETE FROM singers
WHERE occupation NOT LIKE '%singer%' OR occupation NOT LIKE '%Signer%'

INSERT INTO singers (id, first_name, occupation, date_of_birth, deceased, last_name)
VALUES (1, 'Bruce', 'Singer', '1949-09-23', false, 'Springsteen'),
       (2, 'Scarlet', 'Actress', '1984-11-22', false, 'Johansson'),
       (3, 'Frank', 'Singer, Actor', '1915-12-12', true, 'Sinatra'),
       (5, 'Madona', 'Signer, Actress', '1958-08-16', false, ''),
       (6, 'Prince', 'Singer, Songwriter, Musician, Actor', '1958-06-07', false, ''),
       (7, 'Elvis', 'Singer, Musician, Actor', '1935-01-08', false, 'Presley');

# 7.
DELETE FROM countries;

# 8.
\c ls_burger
UPDATE orders
SET drink='Lemonade'
WHERE customer_name = 'James Bergman'; # or id = 1;

# 9.
UPDATE orders
SET side='Fries',
side_cost=0.99,
customer_loyalty_points= 31
WHERE id=4;

# 10.
UPDATE orders
SET side_cost=1.20
WHERE side='Fries';

#  SQL Book 'Working With Multiple Tables' Exercises pt1

# 1.
CREATE TABLE continents (
id serial PRIMARY KEY,
continent_name varchar(50),
);

ALTER TABLE countries
DROP COLUMN continent;

ALTER TABLE countries
ADD COLUMN continent_id int,

ALTER TABLE countries
ADD FOREIGN KEY (continent_id)
REFERENCES countries(id);

# 2.
INSERT INTO continents (continent_name) VALUES
('Africa'),
('Asia'),
('Europe'),
('North America'),
('South America');

INSERT INTO countries (name, capital, population, continent_id)
VALUES ('Brazil', 'Brasilia', 208385000, 5),
('Egypt', 'Cairo', 96308900, 1),
('France', 'Paris', 67158000, 3),
('Germany', 'Berlin', 82349400, 3),
('Japan', 'Tokyo', 126672000, 2),
('USA', 'Washington D.C.', 325365189, 4);

# 3.
ALTER TABLE singers
ADD CONSTRAINT unique_id UNIQUE (id);

CREATE TABLE albums (
id serial PRIMARY KEY,
album_name varchar(100),
released date,
genre varchar(100),
label varchar(100),
singer_id int,
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

# 4.
CREATE TABLE customers (
  id serial PRIMARY KEY,
  customer_name varchar(100)
);

CREATE TABLE email_addresses (
  customer_id integer PRIMARY KEY,
  customer_email varchar(50),
  FOREIGN KEY (customer_id)
  REFERENCES customers(id)
  ON DELETE CASCADE
);
  
INSERT INTO customers (customer_name)
VALUES ('James Bergman'),
('Natasha O''Shea'),
('Aaron Muller');

INSERT INTO email_addresses (customer_id, customer_email)
VALUES (1, 'james1998@email.com'),
(2, 'natasha@osheafamily.com');

# 5.

CREATE TABLE products (
  id serial PRIMARY KEY,
  product_name varchar(50),
  product_cost decimal(4,2) DEFAULT 0,
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

# 6.

DROP TABLE orders;

CREATE TABLE orders (
  id serial PRIMARY KEY,
  customer_id integer,
  order_status varchar(20),
  FOREIGN KEY (customer_id)
  REFERENCES customers (id)
  ON DELETE CASCADE
);

CREATE TABLE order_itmes (
  id serial PRIMARY KEY,
  order_id integer NOT NULL,
  product_id integer NOT NULL,
  FOREIGN KEY (order_id)
  REFERENCES orders (id)
  ON DELETE CASCADE,
  FOREIGN KEY (product_id)
  REFERENCE products (id)
  ON DELETE CASCADE
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

#  SQL Book 'Working With Multiple Tables' Exercises pt2

# 1.
SELECT countries.name, continents.continent_name
FROM countries JOIN continents
ON countries.continent_id = continents.id;

# 2.
SELECT countries.name, countries.capital
FROM countries JOIN continents
ON countries.continent_id = continents.id
WHERE continents.continent_name LIKE 'Europe';

OR:

SELECT name, capital FROM countries WHERE continent_id = 3;

# 3.
SELECT DISTINCT singers.first_name
FROM singers JOIN albums
ON singers.id = albums.singer_id
WHERE albums.label LIKE '%Warner Bros%';

# 4.
SELECT singers.first_name, singers.last_name, albums.album_name
FROM singers JOIN albums
ON singers.id = albums.singer_id
WHERE albums.released >= '1980-01-01'
AND albums.released < '1990-01-01'
AND singers.deceased = false
ORDER BY singers.date_of_birth DESC;

# OR:

SELECT singers.first_name, singers.last_name, albums.album_name
FROM singers JOIN albums
ON singers.id = albums.singer_id
WHERE date_part('year', albums.released) >= '1980' 
AND date_part('year', albums.released) < '1990' 
AND singers.deceased = false
ORDER BY singers.date_of_birth DESC;

# 5.

SELECT singers.first_name, singers.last_name
FROM singers LEFT JOIN albums
ON singers.id = albums.singer_id
WHERE albums.id IS NULL;

# 6.

SELECT first_name, last_name
FROM singers 
  WHERE id NOT IN (
    SELECT singer_id FROM albums
  );

# 7.

# Doesn't return product info other than product id from order_items table.
SELECT orders.id, order_items.product_id
FROM orders JOIN order_items
ON orders.id = order_items.order_id;

# Returns extra product info from linking order_items and products table.
SELECT orders.*, products.*
FROM orders JOIN order_items
ON orders.id = order_items.order_id
JOIN products
ON order_items.product_id = products.id;

# 8.
SELECT orders.id
FROM orders JOIN order_items
ON orders.id = order_items.order_id
JOIN products
ON order_items.product_id = products.id
WHERE products.product_name = 'Fries';

# With table aliasing

SELECT o.id
FROM orders AS o JOIN order_items AS oi
ON o.id = oi.order_id
JOIN products AS p
ON oi.product_id = p.id
WHERE p.product_name = 'Fries';

# 9.

SELECT DISTINCT c.customer_name AS "Customers who like fries"
FROM customers AS c JOIN orders AS o
ON c.id = o.customer_id
JOIN order_items AS oi
ON o.id = oi.order_id
JOIN products AS p
ON oi.product_id = p.id
WHERE p.product_name = 'Fries';

# 10.

SELECT sum(p.product_cost) AS "Total order cost"
FROM products AS p JOIN order_items as oi
ON p.id = oi.product_id
JOIN orders AS o 
ON o.id = oi.order_id
JOIN customers AS c
ON c.id = o.customer_id
WHERE c.customer_name LIKE 'Natasha%';

# 11.
SELECT p.product_name, count(oi.id)
FROM products AS p JOIN order_items AS oi
ON p.id = oi.product_id
GROUP BY p.product_name
ORDER BY p.product_name ASC;

# Schema, Data, and SQL

# THe SQL Langauge Practice Problems:

# 1.
SQL is a special purpose language since it is typically only used to interact with relational databases, and is predominently and declarative language.

# 2.
DDL - Database defintion Language
DML - Database manipulation language
DCL - Database control language

# 3.
'canoe'
'a long road'
'weren''t'
'"No way!"'

# 4.
||

# 5.
LOWER()

SELECT LOWER('ALpacHE'); #=> 'alpache'

# 6.
t or f

# 7.
SELECT trunc(4 * pi() * 26.3 ^ 2);

# PostgreSQL Data Type Practice Problems

# 1.
The `text` datatype is not part of the standard SQL library. It is a datatype that allows for any length of text to be entered. In comparison to varchar(limit), where we allow a string of characters up to `limit` amount.

# 2.
`Integer` allows only whole numbers, `decimal` allows us to specify the total number of digits allowed and the number of digits allowed to the right of the decimal, while real just shows the actual whole number including any fractional values.

# 3.
2147483647

# 4.
Timestamp includes the time of day as well as the date, while date is just date.

# 5.
Not as just TIMESTAMP, but with TIMESTAMP WITH TIME ZONE (or timestamptz) '2004-01-01 HH:MM:SS+timezonedif'

# Working With a Single Table Practice Problems

# 1.
CREATE TABLE people (
  name varchar(255),
  age integer,
  occupation varchar(255)
);

# 2.
INSERT INTO people (name, age, occupaton) VALUES ('Abby', 34, 'biologist');
INSERT INTO people (name, age) VALUES ('Mu''nisah, 26);
INSERT INTO people (name, age, occupaton) VALUES ('Mirabelle, 40, 'contractor');

# 3.
SELECT * FROM people WHERE name = 'Mu''nisah';
SELECT * FROM people WHERE age = 26;
SEELCT * FROM people WHERE occupation IS NULL;

# 4.
CREATE TABLE birds (
  name varchar(255),
  length decimal(4, 1),
  wingspan decimal(4,1),
  family text,
  extinct boolean
);

# 5.
INSERT INTO birds
VALUES ('Spotted Towhee', 21.6, 26.7, 'Emberizidae', false),
('American Robin', 25.5, 36.0, 'Turdidae', false),
('Greater Koa Finch', 19.0, 24.0, 'Fringillidae', true),
('Carolina Parakeet', 33.0, 55.8, 'Psittacidae', true),
('Common Kestrel', 35.5, 73.5, 'Falconidae', false);

# 6.
SELECT name, family FROM birds WHERE extinct = false ORDER BY length DESC;

# 7.
SELECT round(avg(wingspan), 1), min(wingspan), max(wingspan) FROM birds;

# 8.
CREATE TABLE menu_items (
  item text,
  prep_time integer,
  ingredient_cost decimal(4,2),
  sales integer,
  menu_price decimal(4,2)
);

# 9.
INSERT INTO menu_items
VALUES ('omelette', 100, 1.50, 182, 7.99),
('tacos', 5, 2.00, 254, 8.99),
('oatmeal', 1, 0.50, 79, 5.99);

# 10.
SELECT item, (menu_price - ingredient_cost) AS profit FROM menu_items ORDER BY profit DESC Limit 1;

# 11.
SELECT item, menu_price, ingredient_cost, 
 round((13.0 * (prep_time/60.0)), 2) AS labour,
 round((menu_price - ingredient_cost - (13.0 * (prep_time/60.0))),2) AS profit FROM menu_items ORDER BY profit DESC;

# or

SELECT item, menu_price, ingredient_cost,
       round(prep_time/60.0 * 13.0, 2) AS labor,
       menu_price - ingredient_cost - round(prep_time/60.0 * 13.0, 2) AS profit
  FROM menu_items
  ORDER BY profit DESC;

# Loading Database Dumps Practice Problems

# 1.

psql -d my_database < file_to_import.sql

# or from psql console and connected to correct db.

\i ~/launch-school/ls_180/file_to_import.sql

The file contains sql statements, when imported the statements are executed.

Checks if the films table already exists in my_database
creates a table called films
inserts 3 rows (or records) of data.

# 2.
SELECT * FROM films;

# 3.
SELECT * FROM films WHERE length(title) < 12;

# 4.
ALTER TABLE films
ADD COLUMN director text;

ALTER TABLE films
ADD COLUMN duration integer;

# 5.
UPDATE films
SET director = 'John McTiernan', duration = 132
WHERE title = 'Die Hard';

UPDATE films
SET director = 'Michael Curtiz', duration = 102
WHERE title = 'Casablanca';

UPDATE films
SET director = 'Francis Ford Coppola', duration = 113
WHERE title = 'The Conversation';

# 6.
INSERT INTO films # Can specify columns as well by (title, "year", genre, director, duration)
VALUES ('1984',	1956, 'scifi', 'Michael Anderson',	90),
('Tinker Tailor Soldier Spy', 2011, 'espionage', 'Tomas Alfredson', 127),
('The Birdcage', 1996, 'comedy',	'Mike Nichols',	118);

# 7.
SELECT title, extract("year" from current_date) - "year" AS age FROM films ORDER BY age ASC;

# 8.
SELECT title, duration FROM films WHERE duration > 120 ORDER BY duration DESC;

# 9.
SELECT title FROM films ORDER BY duration DESC LIMIT 1;

# More Single Table Queries

# 1.
createdb residents

# 2.

curl - o single_table_queries.sql https://raw.githubusercontent.com/launchschool/sql_course_data/master/sql-and-relational-databases/schema-data-and-sql/more-single-table-queries/residents_with_data.sql

psql -d residents < single_table_queries.sql

# 3.
SELECT state, count(state) FROM people GROUP BY state ORDER BY count DESC LIMIT 10;

# 4.
SELECT split_part(email,'@',-1) AS domain, count(id) 
FROM people 
GROUP BY domain 
ORDER BY count DESC;

# Or
SELECT substr(email, strpos(email, '@') + 1) as domain,
         COUNT(id)
  FROM people
  GROUP BY domain
  ORDER BY count DESC;

# 5.
DELETE FROM people
WHERE id = 3399;

# 6.
DELETE FROM people
WHERE state = 'CA';

Good practice to use a select query to ensure the condition works as intended.

SELECT * FROM people
WHERE state = 'CA';

# 7.
UPDATE people
SET given_name = UPPER(given_name)
WHERE email LIKE '%teleworm.us';

# 8.
DELETE FROM people;

# NOT NULL and Default Values

# 1.
NULL, which signifies the absense of a value.

# 2.
ALTER TABLE employees ALTER COLUMN department SET DEFAULT 'unassigned';
UPDATE employess SET department = 'unassigned' WHERE department IS NULL;
ALTER TABLE employees ALTER COLUMN department SET NOT NULL;

# 3.
CREATE TABLE temperatures (
  date date NOT NULL,
  low integer NOT NULL,
  high integer NOT NULL
);

# 4.
INSERT INTO temperatures
VALUES
 ('2016-03-01' ,34, 43),
 ('2016-03-02' ,32, 44),
 ('2016-03-03' ,31, 47),
 ('2016-03-04' ,33, 42),
 ('2016-03-05' ,39, 46),
 ('2016-03-06' ,32, 43),
 ('2016-03-07' ,29, 32),
 ('2016-03-08' ,23, 31),
 ('2016-03-09' ,17, 28);

# 5.
SELECT date, round((high + low) / 2, 1) AS average
FROM temperatures 
WHERE date >= '2016-03-02' AND date < '2016-03-09';

# alternative WHERE syntax
WHERE BETWEEN '2016-03-02' AND '2016-03-08';

# 6.
ALTER TABLE temperatures
ADD COLUMN raindfall integer DEFAULT 0;

# 7.
UPDATE temperatures
SET rainfall = ((high + low)/2 - 35)
WHERE (high+low)/2 > 35;

# 8.
ALTER TABLE temperatures ALTER COLUMN rainfall TYPE numeric(6,3);

UPDATE temperatures
SET rainfall = (rainfall * 0.039);

# 9.
ALTER TABLE temperatures 
RENAME TO weather;

# 10.
\d $table_name ( d DESCRIBES the table)

# 11.
psql -d sql_lesson -t weather --inserts > dump.sql

PostgreSQL creates a file named `dump.sql` with all the table scheme and data for the `weather` table in sql_lesson database. We specify using `INSERTS` instead of the default behavior of COPY FROM stdin.

# More Constraints

# 1.
\i ~/Launch-School/ls_180/films2.sql

# or

psql -d sql_lesson < films2.sql

# 2.
ALTER TABLE films ALTER COLUMN title SET NOT NULL;
ALTER TABLE films ALTER COLUMN year SET NOT NULL;
ALTER TABLE films ALTER COLUMN genre SET NOT NULL;
ALTER TABLE films ALTER COLUMN director SET NOT NULL;
ALTER TABLE films ALTER COLUMN duration SET NOT NULL;

# 3.
It adds the nullable value of 'not null' to that column in the details. (in PostgreSQL 14 +)
not null will be included in that columns modifiers column.

# 4.
ALTER TABLE films ADD CONSTRAINT title_unique UNIQUE (title);

# 5.
As this is a table constraint, it's added under indexes as a constraint tittle 'title_unqiue'

Indexes:
    "title_unique" UNIQUE CONSTRAINT, btree (title)

# 6.
ALTER TABLE films
DROP CONSTRAINT title_unique;

# 7.
ALTER TABLE films
  ADD CONSTRAINT title_length
  CHECK (length(title) >= 1);

# 8.
INSERT INTO films VALUES ('',2012, 'basfs', 'asdad', 12);
ERROR: new row for relation "films" violates check constraint "title_length"

# 9.
Check Constrains:
      "title_length" CHECK (length(tittle::text) >= 1)

# 10.
ALTER TABLE films
DROP CONSTRAINT title_length;

# 11.
ALTER TABLE films
  ADD CONSTRAINT year_between
  CHECK ("year" BETWEEN 1900 AND 2100);

# 12.
Check constraints:
  "year_between" CHECK (year >= 1900 AND year <= 2100)

# 13.
ALTER TABLE films
  ADD CONSTRAINT direct_length
  CHECK (length(director) >= 3 AND position(' ' in director) > 0);

# 14.
Check constraints:
    "direct_length" CHECK (length(director::text) >= 3 AND POSITION((' '::text) IN (director)) > 0)

# 15.
UPDATE films
SET director = 'Johnny'
WHERE title = 'Die Hard';

ERROR:  new row for relation "films" violates check constraint "direct_length"
DETAIL:  Failing row contains (Die Hard, 1988, action, Johnny, 132).

# 16.
A) Designate a specific TYPE of data that can be input.
B) NOT NULL constraint
C) Check constraint

# 17.
No, it raises an error when trying to add data to the table and use the default value.

CREATE TABLE shoes (name text, size numeric(3,1) DEFAULT 0);
ALTER TABLE shoes ADD CONSTRAINT shoe_size CHECK (size BETWEEN 1 AND 15);
INSERT INTO shoes (name) VALUES ('blue sneakers');
ERROR:  new row for relation "shoes" violates check constraint "shoe_size"
DETAIL:  Failing row contains (blue sneakers, 0.0).

# 18.
\d table name

# Using Keys

# 1.
CREATE SEQUENCE 'counter';

# 2.
SELECT nextval('counter');

# 3.
DROP SEQUENCE counter;

# 4.
Yes, CREATE SEQUENCE 'even_only' INCREMENT by 2 MINVALUE 2;

# 5.
'regions_id_seq'

# 6.
ALTER TABLE films ADD COLUMN id serial PRIMARY KEY;

# 7.
'Error duplicate key value violates unique constraint 'id_unique'
Key (id)=(3) already exists.

# 8.
ERROR: multiple primary keys for table "films" are not allowed.

# 9.
ALTER TABLE films DROP CONSTRAINT films_pkey;

# GROUP BY and Aggregate Functions

# 1.
curl - O https://raw.githubusercontent.com/launchschool/sql_course_data/master/sql-and-relational-databases/schema-data-and-sql/group-by-and-aggregate-functions/films4.sql

psql -d sql_lesson < films4.sql

# 2.
INSERT INTO films (title, year, genre, director, duration)
VALUES ('Wayne''s World',	1992,	'comedy', 'Penelope Spheeris',	95),
('Bourne Identity',	2002, 'espionage',	'Doug Liman', 118);

# 3.
SELECT genre FROM films GROUP BY genre;

# or

SELECT DISTINCT genre FROM films;

# 4.
SELECT genre FROM films GROUP BY genre;

# 5.
SELECT round(avg(duration)) FROM films;

# 6.
SELECT genre, round(avg(duration)) AS average FROM films GROUP BY genre;

# 7.
SELECT year / 10 * 10 as decade, ROUND(avg(duration)) as average_duration
FROM films GROUP BY decade ORDER BY decade;

# 8.
SELECT * FROM films WHERE director ILIKE 'john%';

# 9.
SELECT genre, count(films.id) AS count FROM films GROUP BY genre ORDER BY count desc;

# 10.
SELECT year / 10 * 10 AS decade, genre, string_agg(title, ', ') AS films FROM films
GROUP BY decade, genre
ORDER BY decade, genre;

# 11.
SELECT genre, sum(duration) AS total_duration FROM films GROUP BY genre ORDER BY total_duration, genre ASC;

# Relational Data and JOINs

# Database Diagrams: Levels of schema

# 1.
Conceptual, logical, and physical.

# 2.
A conceptual schema is a schema that is mostly concerned with bigger objects and higher level concepts. A high level design focused on idengtifying entities and their relationships.

# 3.
A physical schema is the details of data types and information pertienent to each table in the database.

# 4.
One to one
One to Many
Many to Many

# Database Diagrams: Cardinality and Modality

# 1.
Cardinality is the number of objects on each side of the relationship. One to one, one to many, and many to many.

# 2.
Modality is if a relationship is required or not, displayed by a 1 or 0

# 3.
1

# 4.
Crows foot notation.

# Working with Multiple Tables

# 1.
curl -O https://raw.githubusercontent.com/launchschool/sql_course_data/master/sql-and-relational-databases/relational-data-and-joins/working-with-multiple-tables/theater_full.sql

psql -d sql_lesson2 < theater_full.sql

# 2.
SELECT count(*) FROM tickets;

# 3.
SELECT count(DISTINCT customer_id) FROM tickets;

# 4.
SELECT round( COUNT(DISTINCT tickets.customer_id)
/ COUNT(DISTINCT customer.id)::decimal * 100, 2)
AS percent
FROM customers
LEFT OUTER JOIN tickets
ON tickets.customer_id = customers.id;

# 5.
SELECT events.name, count(tickets.id) AS popularity
 FROM events 
 LEFT OUTER JOIN tickets 
   ON events.id = tickets.event_id 
 GROUP BY events.name 
 ORDER BY popularity DESC;

# 6.
SELECT customers.id, customers.email, count(DISTINCT tickets.event_id) 
FROM customers
INNER JOIN tickets
  ON customers.id = tickets.customer_id
GROUP BY customers.id
HAVING count(DISTINCT tickets.event_id) = 3;

# 7.
SELECT e.name AS event,
        e.starts_at AS start_at,
        s.name AS section,
        se.row AS row,
        se.number AS seat
FROM events AS e
JOIN tickets AS t
  ON t.event_id = e.id
JOIN seats AS se
  ON se.id = t.seat_id
JOIN sections AS s
  ON s.id = se.section_id
JOIN customers AS c
  ON t.customer_id = c.id
WHERE c.email LIKE 'gennaro.rath@mcdermott.co';

# Using Foreign Keys

# 1.
curl -O https://raw.githubusercontent.com/launchschool/sql_course_data/master/sql-and-relational-databases/relational-data-and-joins/foreign-keys/orders_products1.sql

createdb foreign-keys
psql -d foreign-keys < orders_products1.sql

# 2.

ALTER TABLE orders ADD CONSTRAINT orders_product_id_fkey FOREIGN KEY (product_id) REFERENCES products(id);

# 3.
INSERT INTO products (name)
VALUES ('small bolt'), ('large bolt');

INSERT INTO orders (quantity, product_id)
VALUES (10, 1),
       (25, 1),
       (15, 2);

# 4.
SELECT o.quantity AS quantity, p.name AS name FROM orders AS o
JOIN products AS p ON o.product_id = p.id;

SELECT quantity, name FROM orders INNER JOIN products ON orders.product_id = products.id;

# 5.
Yes

INSERT INTO orders (quantity) VALUES (1);

# 6.
ALTER TABLE orders ALTER COLUMN product_id SET NOT NULL;

An error will be raised as the column currently contains null values.

# 7. 
DELETE FROM orders WHERE ID = 4;
ALTER TABLE orders ALTER COLUMN product_id SET NOT NULL;

# 8.
CREATE TABLE reviews (
  id serial PRIMARY KEY,
  body text NOT NULL,
  product_id integer REFERENCES products(id)
);

# 9.

INSERT INTO reviews (body, product_id)
VALUES ('a little small', 1), ('very round!', 1), ('could have been smaller', 2);

# 10.

False. As we saw above, foreign key columns allow NULL values. As a result, it is often necessary to use NOT NULL and a foreign key constraint together.

# One to many relationships

# 1.
INSERT INTO calls ("when", duration, contact_id)
VALUES ('2016-01-18 14:47:00', 632, 6);

# important to quote the column name "when" as it's a SQL keyword.

# 2.
SELECT calls.when, calls.duration, contacts.first_name FROM calls
INNER JOIN contacts ON calls.contact_id = contacts.id
WHERE (contacts.first_name || ' ' || contacts.last_name) != 'William Swift';

# 3.
INSERT INTO contacts (first_name, last_name, number)
VALUES ('Merve', 'Elk', 6343511126),
('Sawa', 'Fyodorov', 6125594874);

INSERT INTO calls ("when", duration, contact_id)
VALUES ('2016-01-17 11:52:00', 175, 26),
('2016-01-18 21:22:00', 79, 27);

# 4.
ALTER TABLE contacts ADD CONSTRAINT number_unique UNIQUE (number);

# 5.
INSERT INTO contacts (first_name, last_name, number)
VALUES ('Steve', 'McGeeve', 7204890809);

ERROR: duplicate key value violates unique constraint "number_unique"
Detail: ley (number)=(7204890809) already exists.

# 6.
"when" needs to be quoted as it is a reserved SQL keyword.

# 7.
CALLS Many(0)-to-one Contact

# Many to many relationships

# 1.
ALTER TABLE books_categories ALTER COLUMN book_id
SET NOT NULL;

ALTER TABLE books_categories ALTER COLUMN category_id
SET NOT NULL;

ALTER TABLE books_categories
DROP CONSTRAINT "books_categories_book_id_fkey",
ADD CONSTRAINT "books_categories_book_id_fkey"
FOREIGN KEY ("book_id")
REFERENCES books(id)
ON DELETE CASCADE;

ALTER TABLE books_categories
DROP CONSTRAINT "books_categories_category_id_fkey",
ADD CONSTRAINT "books_categories_category_id_fkey"
FOREIGN KEY ("category_id")
REFERENCES categories(id)
ON DELETE CASCADE;

# 2.
SELECT books.id, books.author, string_agg(categories.name, ', ') FROM books
INNER JOIN books_categories ON books.id = books_categories.book_id
INNER JOIN categories ON categories.id = books_categories.category_id
GROUP BY books.id
ORDER BY books.id;

# 3.

INSERT INTO categories (name) VALUES ('Space Exploration'), ('Cookbook'), ('South Asia');

ALTER TABLE books ALTER COLUMN title TYPE text;

INSERT INTO books (author, title) VALUES ('Lynn Sherr',	'Sally Ride: America''s First Woman in Space');
INSERT INTO books_categories VALUES (4,5), (4,1), (4,7);

INSERT INTO books (author, title) VALUES ('Charlotte Brontë',	'Jane Eyre');
INSERT INTO books_categories VALUES (5,2), (5,4);

INSERT INTO books (author, title) VALUES ('Meeru Dhalwala and Vikram Vij',	'Vij''s: Elegant and Inspired Indian Cuisine');
INSERT INTO books_categories VALUES	(6,8), (6,1), (6,9);

# 4.

ALTER TABLE books_categories ADD UNIQUE
(book_id, category_id);

# 5.
SELECT categories.name AS name, count(books.id) AS book_count, string_agg(books.title, ', ') AS book_titles
FROM categories
JOIN books_categories ON categories.id = books_categories.category_id
JOIN books ON books_categories.book_id = books.id
GROUP BY categories.name
ORDER BY categories.name ASC;

# or

SELECT categories.name, count(books.id) as book_count, string_agg(books.title, ', ') AS book_titles
  FROM books
    INNER JOIN books_categories ON books.id = books_categories.book_id
    INNER JOIN categories ON books_categories.category_id = categories.id
  GROUP BY categories.name ORDER BY categories.name;