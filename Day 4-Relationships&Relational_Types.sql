---Five main types of RELATIONS:
--one-to-one
---one-to-many
----many-to-one
-----many-to-many
------self-referencing relationships(also known as recursive relationships)

--ONE TO ONE = Foreign Key + UNIQUE constraint: Each employee record corresponds to one, and only one, vehicle record in the database.

--Parent Table
CREATE TABLE vehicles (
    vehicle_id SERIAL PRIMARY KEY,
    vehicle_name VARCHAR(50)
);

--Child Table
CREATE TABLE employees (
    employees_id SERIAL PRIMARY KEY, 
    employee_name VARCHAR(100),
    vehicle_assign_id INT UNIQUE NOT NULL, 
        CONSTRAINT fk_employee_vehicle
            FOREIGN KEY (vehicle_id) --Foreign Key links employee - vehicle
            REFERENCES vehicles(vehicle_id)--vehicle can only appear once Enforces true 1-to-1
);

--ONE TO MANY = One row in Table A can link to many rows in Table B. But each row in Table B links only to one row in Table A

---Parent Table "Anology: A PARENT CAN HAVE MANY CHILDEREN"
CREATE TABLE customer (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(50)
);

--Child Table "Anology: A CHILD HAS ONLY ONE PARENT"
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY, 
    order_total INT,
    customer_id INT, 
    FOREIGN KEY customer_id REFERENCES customer(customer_id)
);

--MANY TO ONE = Many records in Table A relate to ONE record in Table B

--Child Table
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY, 
    order_total INT,
    customer_id INT NOT NULL, 
    FOREIGN KEY (customer_id)
    REFERENCES customer(customer_id)
    ON DELETE CASCADE --If you delete a customer this will DELETE FROM customer WHERE customer_id = 1; Then all thier orders are automatically deleted. 
);

--Parent Table 
CREATE TABLE customer (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(50)
); 

---MANY TO MANY = Many records in Table A relate to many records in Table B. Need to Creat an Intermediate Table AKA Junction Table

---Parent Table
CREATE TABLE students (
    students_id SERIAL PRIMARY KEY,
    students_name VARCHAR(100) NOT NULL 
); -- Student ID (1, 2)/ Student Name (Arley, Maria)

-- Child Table
CREATE TABLE courses (
    courses_id SERIAL PRIMARY KEY, 
    courses_name VARCHAR(50) NOT NULL
); -- Course ID (10, 20) / Course Name (SQL, PYTHON)

---Junction Table 
CREATE TABLE student_courses (
students_id INT, 
courses_id INT, 
PRIMARY KEY (students_id, courses_id),
FOREIGN KEY (students_id) REFERENCES students(students_id) ON DELETE CASCADE, --If a student is deleted, their enrollments are revmoved as well. 
FOREIGN KEY (courses_id) REFERENCES courses(courses_id) ON DELETE RESTRICT --Blocks deletion if related rows exist
);   --- Student ID (1, 1, 2) / Course ID (10, 20, 20) = Arley Takes (SQL, PYTHON)/ PYTHON course has (Arley, Maria)

--- self-referencing relationships = A table contains a foreign key that references its own primary key

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY, 
    employee_name VARCHAR(100) NOT NULL, 
    manager_id INT, 
    FOREIGN KEY (manager_id)
        REFERENCES employees(employee_id)
        ON DELETE SET NULL --- If Managers leave, employees dont get deleted, They just lose thier Manager reference
); --employee_id (1,2,3,4) / Employee Name (CEO, Arley, Sam, John) / Manager_id (NULL, 1,1,2)