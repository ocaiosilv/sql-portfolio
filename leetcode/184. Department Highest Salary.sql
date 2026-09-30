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
departmentId is a foreign key (reference columns) of the ID from the Department table.
Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.
 

Table: Department

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table. It is guaranteed that department name is not NULL.
Each row of this table indicates the ID of a department and its name.
 

Write a solution to find employees who have the highest salary in each of the departments.

Return the result table in any order.

*/

select distinct namedDepartmentsQuery.Department, namedDepartmentsQuery.Employee, namedDepartmentsQuery.Salary
from (
    select b.name as Department, a.name as Employee, a.salary as Salary, b.id as DepartmentId
    from Employee as a
    Left join Department as b
    on b.id = a.departmentId
) as namedDepartmentsQuery
right join (
    select max(salary) as Salary, departmentId
    from Employee
    group by departmentId
) as maxSalaryinDepartmentQuery
on namedDepartmentsQuery.Salary = maxSalaryinDepartmentQuery.Salary and maxSalaryinDepartmentQuery.departmentId = namedDepartmentsQuery.DepartmentId