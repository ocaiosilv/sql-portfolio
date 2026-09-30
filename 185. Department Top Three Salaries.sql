/*

Table: Employee

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| id           | int     |
| name         | varchar |
| salary       | int     |
| departmentId | int     |
+--------------+---------+
id is the primary key (column with unique values) for this table.
departmentId is a foreign key (reference column) of the ID from the Department table.
Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.
 

Table: Department

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the ID of a department and its name.
 

A company's executives are interested in seeing who earns the most money in each of the company's departments. A high earner in a department is an employee who has a salary in the top three unique salaries for that department.

Write a solution to find the employees who are high earners in each of the departments.

Return the result table in any order.
2 joins
1°: Get the department name and connect it to the employee.
2°: Match each employee with the top 3 unique salaries of their department.

2° join detail:
List 3 rows using ROW_NUMBER() with PARTITION BY departmentId to rank salaries within each department. 
Matched by both salary and departmentId since the same salary can exist in different departments.
*/
s


select distinct dp.Name as Department, ep.name as Employee, ep.salary as Salary
from Employee as ep
join Department as dp
on ep.departmentId = dp.id
join (
    select salary, departmentId
    from (
        select a.salary, a.departmentId, ROW_NUMBER() OVER (
            PARTITION BY departmentId
            ORDER BY a.salary DESC
        ) AS rn
        from (
            select distinct d.salary, d.departmentid
            from employee as d
        ) as a
        order by departmentid, rn
    )
    where rn < 4
) as trimmed
on trimmed.salary = ep.salary and trimmed.departmentId = dp.id
