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

### Understand how to create and remove constraints, including `CHECK` constraints

We can create constraints either at table creation time, or using `ALTER TABLE` after the fact.

<--! At Table Creation Time -->
CREATE TABLE table_name (
  col_1_name col_1_datatype [Constraints,...],
  col_2_name ...
  [table constraints]
);

<--! After Table Creation -->
ALTER TABLE table_name
ADD CONSTRAINT constraint_name UNIQUE
(col_name);

<--! Add check constraint -->
ALTER TABLE table_name
ADD CONSTRAINT constraint_name
CHECK (length(col_1_name) > 2);
<--! OR -->
ALTER TABLE table_name
ADD CHECK (length(col_1_name) > 2);

<--! Adding a NOT NULL column constraint with special syntax -->
ALTER TABLE table_name
  ALTER COLUMN col_1_name
  SET NOT NULL;

<--! Add unique table constraint -->
ALTER TABLE table_name ADD UNIQUE (col1_name, col2_name, ...);

<--! Add unique table constraint to column -->
ALTER TABLE table_name ADD UNIQUE (col_name);

To remove a constraint:

ALTER TABLE table_name
  DROP CONSTRAINT constraint_name;

### Be familiar with using subqueries

SELECT id FROM table_name WHERE id IN (select id FROM table_name_2 WHERE some_condition);

Subqueries can be used to return a list of values from some other table, that are then use to check against the condition of our initial outer query. Subqueries have special access to several additional expression; `EXISTS`, `IN`, `NOT IN`, `ANY`, `SOME`, and `ALL`. These are especially handy as often times the subquery does not return a single value, therefor rendering the `=` operator useless.

<!-- PostgreSQL -->
### Describe what a sequence is and what they are used for.

A sequence is a kind of relation that maintains a current number and can be used to create a series of numbers. Sequences are automatically created when we use the `SERIAL` constraint, but can also be created manually using `CREATE SEQUENCE`. Sequences can be used numerous applications, but are most often used to create a series for use as default values when inserting data into a table.

### Create an auto-incrementing column. (Sequence)

<-- Will increment sequence by 1 -->
CREATE SEQUENCE sequence_name;

<--! change default increment value and minimum (starting) value -->
CREATE SEQUENCE sequence_name INCREMENT by 2 MINVALUE 2;

<--! Using the created squence in a column -->
CREATE TABLE table_name (
  id integer DEFAULT nextval('sequence_name')
);

### Define a default value for a column.

<--! Set Default Value at creation -->
CREATE TABLE table_name (
  col_name TYPE DEFAULT 0,
  ...
);

<--! Set Default Value after creation -->
ALTER TABLE table_name
  ALTER COLUMN col_name
  SET DEFAULT 0;

### Be able to describe what primary, foreign, natural, and surrogate keys are.

**Primary Key**

A Primary Key is a unique identifier for that specific row. These can be defined within the tables schema, and ensures that the values in this column are unique and not null. To create a Primary Key we specify `PRIMARY KEY` after the TYPE. By specifying the `PRIMARY KEY` we show our intentions, and this automatically adds the `NOT NULL` and `UNIQUE` constraints.

CREATE TABLE table_name (
  id integer PRIMARY KEY
);

**Foreign Key**

A foreign key is assigned to a tables column to identify the relationship between a row in the current table and a row in a different table. The value in the current tables column references the row identifier in another table. Foreign keys can also be used in constraints that ensure the value entered in this column either exists or doesn’t in a different table, this is called referential integrity and is one the major reasons for using foreign key constraints. Referential integrity refers to when data from one field in a table’s row must reference data that exists in another table. We can designate foreign key constraints and use the ON DELETE CASCADE clause to ensure that if a reference entity from one table is deleted, the reference entities in another table are also removed.

<--! Creating a table with a Foreign Key -->
CREATE TABLE table_name (
  id serial PRIMARY KEY,
  other_table_id integer REFERENCES other_table_name(other_table_col)
);

<--! Adding a Foreign Key constraint to an existing column -->
ALTER TABLE table_name
  ADD CONSTRAINT constraint_name FOREIGN KEY (curr_table_column_name) REFERENCES other_table_name(other_table_col);

**Natural Key**

A Natural Key is a value that already exists within the input data. These are not created keys but rather data that might appear to be unique and a possible unique identifier. These values should be unique and not change relations, something that rarely occurs with input data.

**Surrogate Key**

A surrogate key is a value that can be used to identify a row of data. The keys are most often created using a `serial` type for the column along with a `unique` constraint. `serial` creates an auto incrementing sequence of numbers used as the value that is `NOT NULL`. There is an overlap between surrogate keys and primary keys, with the main difference being the identifying intention in the table schema.

CREATE TABLE table_name (
  surr_id serial UNIQUE
);

### Create and remove CHECK constraints from a column.

<--! Adding -->
<--! When createing a table -->
CREATE TABLE table_name (
  col_1_name text CHECK (col_1_name = 'col 1 text'),
  ...
);

<--! After table creation -->
ALTER TABLE table_name
  ADD CONSTRAINT check_constraint_name
  CHECK (expression);

<--! Removing -->
ALTER TABLE table_name DROP CONSTRAINT check_name;


### Create and remove foreign key constraints from a column.

<--! At Table Creation -->
CREATE TABLE table_name (
  id serial PRIMARY KEY,
  col_2 integer REFERENCES other_table_name(other_table_col_name)
);

<--! After Table Creation -->
ALTER TABLE table_name ADD CONSTRAINT constraint_name FOREIGN KEY(curr_table_col_name) REFERENCES reference_table_name(reference_table_col_name);

<!-- Database Diagrams -->
### Talk about the different levels of schema.

**Conceptual:** High Level design focused on identifying entities and their relationships. Primarily focused on bigger objects and higher-level concepts. Is primarily concerned with data in a very abstract way, and **not** at all with how that data and relationships between objects are going to be stored within the database. Here we are not concerned with the number of tables required, just the relationships between entities.

**Logical:** A combination of the two. A logical schema will often contain a list of all the data and dataypes, but its often done in such a way that it isn’t specific to an actual database.

**Physical:** A low level database specific design focused on implementation. Database specific implementation of a conceptual model. Includes the different attributes an entity can hold along with the various datatypes.

### Entity-relationship diagram (or model) ERD

A visual representation of a conceptual schema. Entities are represented in rectangles, with the relationship between the entities represented by lines.

A line that connects directly to a entity in a single line represents a ONE end to a connection.

A line that splits into three lines when connecting to an entity represents a MANY end to a connection.

### Define cardinality and modality.

**Cardinality:** Cardinality defines the number of entities on either side of the relationship between two tables. This refers to the one-to-one, one-to-many, and many-to-many relationships tables can have.

**Modality:** Modality refers to wether or not a relationship is required. This can be done using foreign key constraints, indicating that if a value is to be used in 1 table, it must be present in the other table. In crows foot notation, this is identified as a (1) if it is required, or a (0) if the relationship is optional.

### Relationships (1:1, 1:M, M:M)

**One-To-One**

One-to-one relationships are very rare in the real world. This would be a situation where a tables primary key is the same for another row of data in a different table and uses the same primary key. The construct of a one-to-one relationship is very similar to a one-to-many.

**One-To-Many**

A One-to-many relationship is when a reference to one entity can be used multiple times by another entity. We do this by adding a foreign key to the many side which typically would reference the primary key of the one side. With certain applications this can remove repeated data, and avoid instances of update anomaly, insertion anomaly, and deletion anomaly.

**Many-To-Many**
A many-to-many relationship is one which two both tables have entities that can relate to one (or more than one) entity from the 2nd table. This is done by using a join table, where we track the pairs of entities.

When naming these join tables, it is convention to use alphabetical order of the joined tables names.

4. Be able to draw database diagrams using crow's foot notation.
