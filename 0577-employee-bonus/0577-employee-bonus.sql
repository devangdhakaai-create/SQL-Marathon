-- Write your PostgreSQL query statement below
-- SELECT e.name, b.bonus 
-- FROM Employee e
-- LEFT JOIN Bonus b 
-- ON e.empId = b.empId
-- WHERE b.Bonus < 1000 OR b.Bonus IS NULL;

SELECT e.name,
       COALESCE(b.bonus, NULL) AS bonus
FROM Employee e
LEFT JOIN Bonus b ON e.empId = b.empId
WHERE b.bonus < 1000 OR b.bonus IS NULL;
