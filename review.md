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

3. Write SQL statements using INSERT, UPDATE, DELETE, CREATE/ALTER/DROP TABLE, ADD/ALTER/DROP COLUMN.
4. Understand how to use GROUP BY, ORDER BY, WHERE, and HAVING.
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