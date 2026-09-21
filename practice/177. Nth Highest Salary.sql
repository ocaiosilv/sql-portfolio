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
 

Write a solution to find the nth highest distinct salary from the Employee table. If there are less than n distinct salaries, return null.

The result format is in the following example.




comment: In the question structure, it is not mentioned how n should be treated if it is less than 1, but after some testing i found that it should be treated as NULL.
also, there is two ways that i thinked off, but one of them just works for MySql due logic and syntax. The order is going to be PostgreSQL and then MySQL.
*/

-- PostgreSQL

CREATE OR REPLACE FUNCTION NthHighestSalary(N INT) RETURNS TABLE (Salary INT) AS $$
BEGIN
if n < 1 then
    return query(select null::int as salary);
else
  RETURN QUERY (
    select distinct Employee.salary
    from Employee
    order by salary desc
    limit 1
    offset N-1
  );
  end if;
END;
$$ LANGUAGE plpgsql;

-- mySql


CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
SET N = N-1;
  RETURN (
    select distinct Employee.salary
    from Employee
    order by salary desc
    limit 1
    offset N
  );
END


/*
fact: the mysql version does not work with offset n -1, the value need to be set before the query, the probable reason for this is the way mysql handles the offset parameter, it probably maps -1 to 2^64 - 1 ( unsigned long long ), which is about 18 quintillion, and as the query does not have that position, it ignores and returns null. 

funfact: it would be possible that a table as big as 18 quintillion rows existed and affect the result, but, even assuming 1 byte per registry, that is about 18 exabytes, requiring an enormous amount of storage and data. For all the means, its safer to take the if else aproach.  
*/