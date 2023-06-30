/* SQL Fundamentals DDL */

-- 1
createdb extrasolar

CREATE TABLE stars (
  id serial PRIMARY KEY,
  name varchar(25) UNIQUE NOT NULL,
  distance integer NOT NULL CHECK (distance > 0),
  spectral_type char(1),
  companions integer NOT NULL CHECK (companions >= 0)
);

CREATE TABLE planets (
  id serial PRIMARY KEY,
  designation char(1) UNIQUE,
  mass integer
);

-- 2
ALTER TABLE planets ADD COLUMN star_id integer NOT NULL REFERENCES stars(id);

-- 3
ALTER TABLE stars ALTER COLUMN name TYPE varchar(50);
--FE
Altering a character length to a greater length will not raise an error, however altering
the character length to a shorter length may raise an error if any values are longer
than the newly defined length.

-- 4
ALTER TABLE stars ALTER COLUMN distance TYPE numeric;
--FE
Changing from numeric to integer will lose all fractional data.
This is because integers dont support any fractiona values by definiton, so any cast
from a type that does will have any values truncated `SELECT 4.3::integer` demonstrates
this.

-- 5
ALTER TABLE stars
ADD CHECK (spectral_type IN ('O', 'B', 'A', 'F', 'G', 'K','M')),
ALTER COLUMN spectral_type SET NOT NULL;

--6
# Creating a enumerated type:
CREATE TYPE valid_spectral_type AS ENUM ('O', 'B', 'A', 'F', 'G', 'K','M');

ALTER TABLE stars ALTER COLUMN spectral_type 
TYPE valid_spectral_type USING spectral_type::valid_spectral_type;

# If the `USING` clause was removed, we would get an error:
ERROR:  column "spectral_type" cannot be cast automatically to type spectral_type_enum
HINT:  You might need to specify "USING spectral_type::spectral_type_enum".

-- 7
ALTER TABLE planets 
ALTER COLUMN mass TYPE numeric,
ALTER COLUMN mass SET NOT NULL,
ADD CHECK (mass > 0);

ALTER TABLE planets ALTER COLUMN designation SET NOT NULL;

-- 8
ALTER TABLE planets ADD COLUMN semi_major_axis numeric NOT NULL;

-- FE
ALTER TABLE planets
  ADD COLUMN semi_major_axis numeric;

UPDATE planets SET semi_major_axis = 0.04 WHERE star_id = 1; -- or another star_id
UPDATE planets SET semi_major_axis = 40 WHERE star_id = 2; -- or another star_id

ALTER TABLE planets
ALTER COLUMN semi_major_axis SET NOT NULL;

-- 9
CREATE TABLE moons (
  id serial PRIMARY KEY,
  designation integer NOT NULL CHECK (designation > 0),
  semi_major_axis numeric CHECK (semi_major_axis > 0.0),
  mass numeric CHECK (mass > 0),
  planet_id integer NOT NULL REFERENCES planets (id)
);

-- 10
# To make a backup:
pg_dump --inserts extrasolar > extrasolar.dump.sql

\c sql_lesson (or any other db)
DROP DATABASE extrasolar;