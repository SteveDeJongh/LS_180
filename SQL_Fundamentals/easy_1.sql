/* SQL Fundamentals Easy 1 */

-- 1
PostgreSQL Wrapper function:
createdb animals

SQL Statement from within psql console:
CREATE DATABASE animals;

-- 2
CREATE TABLE birds (
  id serial PRIMARY KEY,
  name varchar(25),
  age integer,
  species varchar(15)
);

-- 3
INSERT INTO birds (name, age, species)
VALUES ('Charlie', 3, 'Finch'), ('Allie', 5, 'Owl'), ('Jennifer', 3, 'Magpie'),
       ('Jamie', 4, 'Owl'), ('Roy', 8, 'Crow');

-- 4
SELECT * FROM birds;

-- 5
SELECT * FROM birds
WHERE age < 5;

-- 6
UPDATE birds
SET species='Raven'
WHERE species='Crow';

-- FE
UPDATE birds
SET species='Hawk'
WHERE id=4;

-- 7
DELETE FROM birds
WHERE age = 3 AND species = 'Finch';

-- 8
ALTER TABLE birds
  ADD CONSTRAINT check_age CHECK (age > 0);

INSERT INTO birds
VALUES (DEFAULT, 'Alan', -2, 'Blue Jay');

-- 9
DROP TABLE birds;

-- 10

dropdb animals

DROP DATABASE animals;