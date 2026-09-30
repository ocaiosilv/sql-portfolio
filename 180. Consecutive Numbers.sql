/*
Table: Logs

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
In SQL, id is the primary key for this table.
id is an autoincrement column starting from 1.
 

Find all numbers that appear at least three times consecutively.

Return the result table in any order.

answer: kinda a 3 pointer and it ignores the ids that doesnt exists, so no need to start at the third pos or treat edge cases
*/

SELECT DISTINCT a.num AS ConsecutiveNums
FROM Logs a, Logs b, Logs c
WHERE a.num = b.num
  AND b.num = c.num
  AND a.id = b.id - 1
  AND b.id = c.id - 1
