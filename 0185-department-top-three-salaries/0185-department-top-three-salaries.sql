-- Write your PostgreSQL query statement below
select e.name as employee, d.name as department, e.salary
from (
    select *, dense_rank() over(
        partition by departmentid
        order by salary desc
    ) as rk
    from employee
) e
join department d on d.id = e.departmentid
where rk<=3
ORDER BY e.salary DESC;