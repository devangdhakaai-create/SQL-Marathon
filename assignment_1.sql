-- Query 1. Create a new database named company_db
CREATE DATABASE company_db;
-- To connect via sql shell/ psql client command:
\c company_db; 

-- Query 2. Design a table to store companies
CREATE TABLE companies (
    company_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    founded_year INT
);

-- Query 3. Design a table to store departments
CREATE TABLE departments (
    department_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    company_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    budget NUMERIC(12,2),
    FOREIGN KEY (company_id) REFERENCES companies(company_id)
);

-- Query 4. Design a table to store employees
CREATE TABLE employees (
    employee_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    department_id INT NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    role VARCHAR(100) NOT NULL,
    salary NUMERIC(12,2) NOT NULL,
    hire_date DATE NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Query 5,6. Apply proper constraints:
Primary Key
Foreign Key
NOT NULL
Insert sample data into all tables

INSERT INTO companies (name, location, founded_year)
VALUES
('TechNova Pvt Ltd', 'Bengaluru, India', 2015),
('BlueCorp Solutions', 'Mumbai, India', 2010);

INSERT INTO departments (company_id, name, budget)
VALUES
(1, 'Engineering', 5000000),
(1, 'Human Resources', 800000),
(1, 'Marketing', 1500000),
(2, 'Product', 3000000),
(2, 'Finance', 1200000);

INSERT INTO employees (department_id, first_name, last_name, role, salary, hire_date)
VALUES
(1, 'Aarav', 'Mehta', 'Software Engineer', 90000, '2022-07-10'),
(1, 'Neha', 'Patel', 'Senior Engineer', 120000, '2020-03-14'),
(2, 'Kabir', 'Sharma', 'HR Manager', 75000, '2021-01-05'),
(3, 'Priya', 'Singh', 'Marketing Specialist', 60000, '2023-08-01'),
(4, 'Aditya', 'Khan', 'Product Manager', 110000, '2019-11-21'),
(5, 'Maya', 'Rao', 'Financial Analyst', 95000, '2021-06-30');
