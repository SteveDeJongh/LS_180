<!-- LS 180 Review -->

<!-- SQL -->
### Identify the different types of `JOIN`s and explain their differences.

`INNER JOIN` also known as just `JOIN` in PostgreSQL (as it’s the default `JOIN`) joins rows of tables on the defined match condition where both tables contain data. ie: Only rows that are matched to a row from another table will be present in the results.

`LEFT JOIN` or a `LEFT OUTER JOIN` will return all rows from the left table, regardless of if it has a matching row from the right column. If there’s no matching data from the right hand table those fields will be `null`.

`RIGHT JOIN` (`RIGHT OUTER JOIN`) is the opposite of `LEFT JOIN`. Here, all rows in the right table will be returned, even if there is no matching row in the left table.

`FULL JOIN` or `FULL OUTER JOIN` is the combination of a `LEFT JOIN` and a `RIGHT JOIN`. Returning all columns from both tables, even if there is no matching row from the opposite table. Any unmatched row will return null values for the columns of the opposite table.

`CROSS JOIN` links every row in one table with every row in the other table. This join will contain every possible combination of rows, and is also called a Cartesian JOIN.

### Name and define the three sublanguages of SQL and be able to classify different statements by sublanguage.

`DDL` or Data Definition Language: This is the language used to set up tables, and define the schema. This is where actions such as `CREATE` `DROP` `ALTER` are defined.

`DML` or Data manipulation language: This is the language where we interact with the table in our tables. Actions such as `SELECT`, `INSERT`, `UPDATE`, `DELETE` are all defined in this language. This is the language we are likely to use most often.

`DCL` or Data control language: This is the language used to control rights and access of users working with our database. This is where we control what users have access to what actions on a database. A read-only database rights allow you to only use a `SELECT` query to view data from a database or table. This is where actions such as `GRANT` and `REVOKE` are defined.

### Write SQL statements using INSERT, UPDATE, DELETE, CREATE/ALTER/DROP TABLE, ADD/ALTER/DROP COLUMN.

<--! INSERT -->
INSERT INTO table_name (column1_name, column2_name)
VALUES (column1_value, column2_value);

<--! UPDATE partiular rows-->
UPDATE table_name SET column_name = new_column_value WHERE expression;

<--! UPDATE all rows-->
UPDATE table_name SET column_name = new_column_value;

<--! DELETE particular rows -->
DELETE FROM table_name WHERE expression; 

<--! DELETE all rows -->
DELETE FROM table_name;

<--! CREATE TABLE -->
CREATE TABLE table_name ();

<--! CREATE TABLE with columns-->
CREATE TABLE table_name (
  column_1_name DATATYPE [constraints],
  ...
);

<--! ALTER TABLE -->
ALTER TABLE table_name RENAME TO new_table_name;

<--! ALTER TABLE add table constraint -->
ALTER TABLE table_name
  ADD CONSTRAINT constraint_name
  constraint_clause;

<--! DROP TABLE -->
DROP TABLE table_name;

<--! ADD COLUMN -->
ALTER TABLE table_name
  ADD COLUMN new_col_name DATATYPE [constraints];

<--! ALTER COLUMN -->

<--! ALTER TABLE changing column data type -->
ALTER TABLE table_name
  ALTER COLUMN col_name TYPE new_data_type;

<--! Rname a column -->
ALTER TABLE table_name
  RENAME COLUMN curr_col_name TO new_col_name;

<--! DROP COLUMN -->
ALTER TABLE table_name
  DROP COLUMN col_name;

### Understand how to use GROUP BY, ORDER BY, WHERE, and HAVING.

**GROUP BY**

SELECT col_1_name FROM table_name GROUP BY col_1_name;

When using the `GROUP BY` clause we must ensure that the column names in use in the `SELECT` query are either used by `GROUP BY` or have a valid way of combining the values from multiple rows into 1 result. This is where aggregate functions come into play. Functions like `count`, `string_agg`, `sum` can return 1 value from a group of multiple results.

**ORDER BY**

SELECT col_1_name, col_2_name FROM table_name ORDER BY col_1_name ASC, col_2_name DESC;

The `ORDER BY` clause is placed after the table name and after any `where` clauses in a `SELECT` statement.
The default sort order for a `ORDER BY` clause is ascending (`ASC`), this can be changed to descending using `DESC`.
We can sort by multiple columns, appending one after another separated by commas. The column we sort by does not need to appear in the results.

**WHERE**

SELECT col_1_name FROM table_name WHERE col_2_name = 'Some string';

The `WHERE` clause is included in a query after the table name. In a `WHERE` clause, we can check to see if a condition is true and only return the values for which it is.

**HAVING**

SELECT col_1_name FROM table_name GROUP BY col_1_name HAVING count(col_1_name) > 2;

`HAVING` conditions are similar to `WHERE` clauses, however `HAVING` works on columns that have been grouped and the results from that grouping.
The example above display a list of col_1_name from table_name grouped by col_1_name, where the number of rows that have the same column name is greater than 2.

5. Understand how to create and remove constraints, including CHECK constraints
6. Be familiar with using subqueries

<!-- PostgreSQL -->
1. Describe what a sequence is and what they are used for.
2. Create an auto-incrementing column.
3. Define a default value for a column.
4. Be able to describe what primary, foreign, natural, and surrogate keys are.
5. Create and remove CHECK constraints from a column.
6. Create and remove foreign key constraints from a column.

<!-- Database Diagrams -->
1. Talk about the different levels of schema.
2. Define cardinality and modality.
3. Be able to draw database diagrams using crow's foot notation.