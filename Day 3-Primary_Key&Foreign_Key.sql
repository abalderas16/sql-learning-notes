
-- column_name data_type PRIMARY KEY example of a student table and a course table below:
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY, 
    student_name VARCHAR(100)
);

CREATE TABLE course_id (
    course_id SERIAL PRIMARY KEY 
    course_name VARCHAR(50)
);

--A COMPOSITE PRIMARY KEY is used when a table doesnt have a single unique column to identify the row. In this case we can use a combination of two or more columns as the primary key together. 
CREATE TABLE course_enrollments (
    student_id INT, 
    course_id INT, 
    enrollment_timestamp TIMESTAMP, 
    PRIMARY KEY (student_id, course_id) --you will never have the same student enrolled in the same class more than once
);

--FOREIGN KEY is a column or set of columns in a table that reference the primary key of another table

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY, 
    customer_id INTEGER, 
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
); --Keep i mind this allows customer_id to be NUll this is early pipeline stage (raw/staging table)

--If modeling business truth, not raw intake it will look like this:
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY, 
    customer_id INT NOT NULL REFERENCES customers(customer_id)
);
