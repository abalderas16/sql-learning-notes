---Join Tables [INNER JOIN, FULL OUTER JOIN, LEFT OUTER JOIN, RIGHT OUTER JOIN, SELF JOIN, CROSS JOIN]

--SAMPLE ANAOLGY TABLE:-------

--Parent Table 
CREATE TABLE customer (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO customer (customer_id, name)
VALUES
    (1, 'Arley'),
    (2, 'Maria'),
    (3, 'John');

--Child Table 
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY, 
    customer_id INT, 
    FOREIGN KEY customer_id REFERENCES customer(customer_id)
);

INSERT INTO orders (order_id, customer_id)
VALUES
    (101, 1),
    (102, 2),
    (103, 5);

--INNER JOIN = Only show me records that exist in Table A & Table B "If a value exists in one table but not the other -> it is excluded"
SELECT *
FROM customers AS c 
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id;
--RESULT WOULD BE: 
-- customer_id          name            order_id
--    1                 Arley               101
--    2                 Maria               102
--------John (customer_id 3) No orders 'Removed', Order 103 (customer_id 5) No matching customer "Removed" 
--INNER JOIN HELPS ANSWER: Which records are vaild relationships between these tables?

--FULL JOIN = Returns ALL rows from BOTH tables matches where possible NULLs where not
SELECT *
FROM customers c
FULL JOIN orders o
  ON c.customer_id = o.customer_id;
--RESULT WOULD BE: 
-- customer_id          name            order_id
--    1                 Arley               101
--    2                 Maria               102
--    3                 John                NULL
--    4                 NULL                NULL
--    5                 NULL                103
----You see everything. Best used when Data reconciliation, Comparing two systems, Auditing mismatches "Data Engineering audits"

--LEFT JOIN =  Returns ALL rows from the left table matching rows from the right table if no match then NULL. 
SELECT * 
FROM customers AS c 
LEFT JOIN orders o 
    ON c.customer_id = o.customer_id
--RESULT WOULD BE: 
-- customer_id          name            order_id
--    1                 Arley               101
--    2                 Maria               102
--    3                 John                NULL
--------John (customer_id 3) shows up even without orders. Use when finding missing data ex:"Which customers have no orders?"

--RIGHT JOIN = Returns ALL rows from right table matching rows from the left if no match then NULL. 
SELECT * 
FROM customers AS c 
RIGHT JOIN orders o 
    ON c.customer_id = o.customer_id
--RESULT WOULD BE: 
-- customer_id          name            order_id
--    1                 Arley               101
--    2                 Maria               102
--    5                 NULL                103

--SELF JOIN = A table joined to itself

--Parent Table 
CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    manager_id INT, 
    FOREIGN KEY (manager_id)
        REFERENCES employees(emp_id)
        ON DELETE SET NULL
); ---Sample of ORG charts 

INSERT INTO employees (emp_id, name, manager_id)
VALUES
    (1, 'Arley', NULL),
    (2, 'Maria',  1),
    (3, 'John',   1);

SELECT 
    e.name AS employee,
    m.name AS manager 
FROM employees AS e 
JOIN employees AS m 
    ON e.manager_id = m.emp_id;
--RESULT WOULD BE: 
--  employee            manager
--   Maria               Arley
--   John                Arley
--------Used when Hierarchies, Org charts, Parent-child Relationship 

--CROSS JOIN = Returns every possible combination of rows between two tables 

CREATE TABLE customer (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO customer (customer_id, name)
VALUES
    (1, 'Arley'),
    (2, 'Maria');

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product VARCHAR(50)
);

INSERT INTO products (product_id, product)
VALUES
    (10, 'Laptop'),
    (20, 'Mouse'),
    (30, 'Keyboard');

SELECT 
  c.customer_id,
  c.name,
  p.product_id,
  p.product
FROM customers c
CROSS JOIN products p; -- Pro version. 
--RESULTS WOULD BE: 
--customer_id	name	product_id	product
--1	            Arley	    10	    Laptop
--1	            Arley	    20	    Mouse
--2	            Maria	    10	    Laptop
--2	            Maria	    20	    Mouse
