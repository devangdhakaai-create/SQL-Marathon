-- Query 1. Perform a salary transfer using transactions
BEGIN;

-- debit
UPDATE employees
SET salary = salary - 5000
WHERE emp_id = 10;

-- credit
UPDATE employees
SET salary = salary + 5000
WHERE emp_id = 12;

COMMIT;

-- Rollback if transaction version fails during testing or doen't executs other subqueries
ROLLBACK;

-- Query 2. Identify departments that have employees
SELECT d.department_id, d.name
FROM departments d
WHERE EXISTS (
    SELECT 1 FROM employees e
    WHERE e.department_id = d.department_id
);

-- or alternative method to do that:
SELECT d.department_id, d.name, COUNT(e.emp_id) AS total_employees
FROM departments d
LEFT JOIN employees e ON e.department_id = d.department_id
GROUP BY d.department_id, d.name
HAVING COUNT(e.emp_id) > 0;

-- Query 3. Display employee-manager hierarchy
SELECT 
    e.emp_id,
    e.first_name || ' ' || e.last_name AS employee,
    m.first_name || ' ' || m.last_name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id;

-- Query 4. Compare previous and next salaries
SELECT 
    emp_id,
    first_name || ' ' || last_name AS employee,
    salary,
    LAG(salary)  OVER (ORDER BY salary) AS prev_salary,
    LEAD(salary) OVER (ORDER BY salary) AS next_salary
FROM employees;

-- Query 5. Generate department-wise salary totals
SELECT 
    d.name AS department,
    SUM(e.salary) AS total_salary,
    AVG(e.salary) AS avg_salary,
    COUNT(e.emp_id) AS total_employees
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.name
ORDER BY total_salary DESC;

-- Query 6. Export database structure and data
-- If you wantt full copy of db, as tables, schemas, rows, constranits.
-- data + structure
pg_dump -U username -d dbname -F c > backup.dump
-- If just want to print the blueprint, like table, keys, but not rows
-- Structure Only
pg_dump -U username -d dbname -s > schema.sql
-- If you wanna data from db (inserts only)
-- Data Only
pg_dump -U username -d dbname -a > data.sql
-- If you want to do the reverse operation, or recreate db from dump than type this command
-- Restoration
pg_restore -U username -d newdb backup.dump

