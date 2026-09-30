/*
Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
Each row of this table contains information about the salary of an employee.
 

Write a solution to find the second highest distinct salary from the Employee table. If there is no second highest salary, return null (return None in Pandas).

The result format is in the following example.

*/

SELECT MAX(e.salary) AS SecondHighestSalary
FROM Employee as e
WHERE e.salary < (
    SELECT MAX(b.salary)
    FROM Employee as b
);

--- It can be done with offset and limit but it needs to treat null cases by using a subquery ( because it creates a row automatically when runned that will return null if in the inside query returns nothing ).

SELECT (
    SELECT DISTINCT salary
    FROM Employee
    ORDER BY salary DESC
    OFFSET 1
    LIMIT 1
) AS SecondHighestSalary;


-- There is no percieved performance diff, that been said, the first solution is more readable and easier to understand.