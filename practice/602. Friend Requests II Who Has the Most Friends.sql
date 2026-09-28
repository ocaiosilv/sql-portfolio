/*
Table: RequestAccepted

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| requester_id   | int     |
| accepter_id    | int     |
| accept_date    | date    |
+----------------+---------+
(requester_id, accepter_id) is the primary key (combination of columns with unique values) for this table.
This table contains the ID of the user who sent the request, the ID of the user who received the request, and the date when the request was accepted.
 

Write a solution to find the people who have the most friends and the most friends number.

The test cases are generated so that only one person has the most friends.


*/


select requester_id as id, count as num
from
(select requester_id, count(accepter_id)
from (
    SELECT requester_id, accepter_id
    FROM RequestAccepted

    UNION ALL

    SELECT accepter_id, requester_id
    FROM RequestAccepted
)
group by requester_id
)
order by num desc
limit 1