/* SQL Fundamentals DML */

-- 1
psql postgres
CREATE DATABASE workshop;
\c workshop

CREATE TABLE devices (
  id serial PRIMARY KEY,
  name varchar(50) NOT NULL,
  created_at timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE parts (
  id serial PRIMARY KEY,
  part_number integer UNIQUE NOT NULL,
  device_id integer REFERENCES devices (id)
);

-- 2

INSERT INTO devices (name)
VALUES ('Accelerometer'), ('Gyroscope');

INSERT INTO parts (part_number, device_id)
VALUES (12, 1), (14, 1), (16, 1), (31, 2), (33, 2), (35, 2), (37, 2), (39, 2), 
(50, NULL), (54, NULL), (58, NULL);

-- 3
SELECT name, part_number FROM devices INNER JOIN parts ON parts.device_id = devices.id;

-- 4
SELECT * FROM parts WHERE CAST(part_number AS TEXT) LIKE '3%';
-- or
SELECT * FROM parts WHERE part_number::TEXT LIKE '3%';

-- 5
SELECT devices.name, count(parts.id) FROM devices 
LEFT OUTER JOIN parts ON devices.id = parts.device_id 
GROUP BY devices.name;

-- 6

SELECT devices.name AS name, count(parts.id) FROM devices 
LEFT OUTER JOIN parts ON devices.id = parts.device_id 
GROUP BY devices.name
ORDER BY name DESC;

-- 7
SELECT part_number, device_id FROM parts WHERE device_id IS NOT NULL;
SELECT part_number, device_id FROM parts WHERE device_id IS NULL;

-- 8
INSERT INTO devices (name) VALUES ('Magnetometer');
INSERT INTO parts (part_number, device_id) VALUES (42,3);

SELECT name AS oldest_device FROM devices ORDER BY created_at ASC LIMIT 1;

-- 9
SELECT * FROM parts WHERE id = 7 OR id = 8;

UPDATE parts
SET device_id = 3
WHERE id = 7 OR id = 8;

-- 10
Required to delete the parts that reference the device id in the parts table before deleting
the device in devices.

SELECT * FROM parts WHERE device_id = 1;

DELETE FROM parts WHERE device_id = 1;
DELETE FROM devices WHERE name = 'Accelerometer';