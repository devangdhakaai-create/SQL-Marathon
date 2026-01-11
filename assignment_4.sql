-- Query 1. Update salary for a specific department
UPDATE employees
SET salary = salary * 1.10
WHERE department_id = (
    SELECT department_id
    FROM departments
    WHERE name = 'Engineering'
);

-- Query 2. Remove employees from an obsolete department
DELETE FROM employees
WHERE department_id = (
    SELECT department_id
    FROM departments
    WHERE name = 'Marketing'
);

-- Query 3. Create a view for high-earning employees
CREATE VIEW high_earners AS
SELECT 
    employee_id,
    first_name,
    last_name,
    salary
FROM employees
WHERE salary > 100000;

SELECT * FROM high_earners;

-- Query 4. Add validation to ensure salary is always positive
ALTER TABLE employees
ADD CONSTRAINT chk_positive_salary
CHECK (salary > 0);

-- Query 5. Improve search performance using indexing
CREATE INDEX idx_employees_department
ON employees(department_id);

CREATE INDEX idx_employees_manager
ON employees(manager_id);

CREATE INDEX idx_employees_salary
ON employees(salary);

CREATE INDEX idx_employees_last_name
ON employees(last_name);

-- Query 6. Create a stored procedure for department-based queries
CREATE OR REPLACE PROCEDURE get_employees_by_department(dep TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT 
        e.first_name || ' ' || e.last_name AS employee,
        e.role,
        e.salary
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
    WHERE d.name = dep;
END;
$$;

CALL get_employees_by_department('Engineering');
