-- Query 1. Show employees along with their managers
ALTER TABLE employees
ADD COLUMN manager_id INT;

ALTER TABLE employees
ADD CONSTRAINT fk_manager
FOREIGN KEY (manager_id) REFERENCES employees(employee_id);

-- employee → manager (both inside employees)
UPDATE employees SET manager_id = 2 WHERE employee_id = 1;  -- Aarav → Neha
UPDATE employees SET manager_id = NULL WHERE employee_id = 2;
UPDATE employees SET manager_id = NULL WHERE employee_id = 3;

-- To verify the result
SELECT 
    e.employee_id,
    e.first_name || ' ' || e.last_name AS employee,
    m.first_name || ' ' || m.last_name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id;

-- Query 2. Find employees earning more than average salary
SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- Query 3. Display employee name, department, and company
SELECT
    e.first_name || ' ' || e.last_name AS employee,
    d.name AS department,
    c.name AS company
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN companies c ON d.company_id = c.company_id;

-- Query 4. Identify the second-highest salary
SELECT DISTINCT salary
FROM employees
ORDER BY salary DESC
LIMIT 1 OFFSET 1;

-- Query 5. Rank employees by salary within departments
SELECT
    e.first_name || ' ' || e.last_name AS employee,
    d.name AS department,
    e.salary,
    RANK() OVER (
        PARTITION BY e.department_id
        ORDER BY e.salary DESC
    ) AS salary_rank
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- Query 6. Categorize employees as Low / Medium / High earners
SELECT
    e.first_name || ' ' || e.last_name AS employee,
    e.salary,
    CASE
        WHEN e.salary < 60000 THEN 'Low'
        WHEN e.salary BETWEEN 60000 AND 100000 THEN 'Medium'
        ELSE 'High'
    END AS salary_band
FROM employees e;
