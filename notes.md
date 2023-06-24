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