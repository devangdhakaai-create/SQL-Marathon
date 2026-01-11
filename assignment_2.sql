-- Query 1. Display all employees
SELECT * FROM employees;

-- Query 2. Find employees working in a specific department
SELECT * 
FROM employees
WHERE department_id = 1;

-- Query 3. List unique job titles
SELECT DISTINCT role
FROM employees;

-- Query 4. Sort employees by salary
SELECT *
FROM employees
ORDER BY salary ASC;

-- Query 5. Count total employees
SELECT COUNT(*) AS total_employees
FROM employees;

-- Query 6. Calculate average salary per department
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id;

-- Query 7. Show employee names along with department names
SELECT 
    e.first_name || ' ' || e.last_name AS employee_name,
    d.name AS department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;
