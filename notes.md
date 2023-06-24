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
