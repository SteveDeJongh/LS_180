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