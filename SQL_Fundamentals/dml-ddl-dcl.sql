/* SQL Fundamentals DML, DDL, and DCL */

-- 1
Database Definition Language is used to create, modify, and delete databases and tables.
Ex:
ALTER TABLE table_name
  ALTER COLUMN colname TYPE integer;

ALTER TABLE table_name
  RENAME TO new_table_name;

CREATE, ALTER, DROP, are all common DDL statements.

Database Manipulation Language is used to create, update, and delete the actual data in a database.
Ex:
SELECT * FROM table_name;

INSERT INTO table_name
  (col1, col2)
  VALUES (val1, val2);

SELECT, INSERT, UPDATE, DELETE, are all common DML statements.

-- 2
SELECT column_name FROM my_table;

This statement uses the DML language component of SQL.

-- 3
CREATE TABLE things (
  id serial PRIMARY KEY,
  item text NOT NULL UNIQUE,
  material text NOT NULL
);

This statement uses DDL to define the schema of a table.

-- 4
ALTER TABLE things
DROP CONSTRAINT things_item_key;

This statement uses DDL of SQL to drop the constraint on the column item, in the table things.

-- 5
INSERT INTO things VALUES (3, 'Scissors', 'Metal');

This uses DML to add the information into the things table as a new row.

-- 6
UPDATE things
SET material = 'plastic'
WHERE item = 'Cup';

This uses DML to change information in the column material where any rows item column matches 'Cup'.

-- 7
\d things

This is a psql meta command, and not part of DDL, DML, or DCL.

-- 8
DELETE FROM things WHERE item = 'Cup';

This is a DML statement, deleting any row where item is equal to 'Cup'

-- 9
DROP DATABASE xyzzy;
This is a DDL statement, deleting the database.

-- 10
CREATE SEQUENCE part_number_sequence;

This is a DDL statement. CREATE SEQUENCE statements modify the characteristics and attributes of a database
by adding a sequence object to teh database structure. It does not manipulate any data,
but instead manipulates the data definitions.
