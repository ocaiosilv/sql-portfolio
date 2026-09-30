/*
Table: ProductPurchases

+-------------+------+
| Column Name | Type | 
+-------------+------+
| user_id     | int  |
| product_id  | int  |
| quantity    | int  |
+-------------+------+
(user_id, product_id) is the unique identifier for this table. 
Each row represents a purchase of a product by a user in a specific quantity.
Table: ProductInfo

+-------------+---------+
| Column Name | Type    | 
+-------------+---------+
| product_id  | int     |
| category    | varchar |
| price       | decimal |
+-------------+---------+
product_id is the unique identifier for this table.
Each row assigns a category and price to a product.
Amazon wants to understand shopping patterns across product categories. Write a solution to:

Find all category pairs (where category1 < category2)
For each category pair, determine the number of unique customers who purchased products from both categories
A category pair is considered reportable if at least 3 different customers have purchased products from both categories.

Return the result table of reportable category pairs ordered by customer_count in descending order, and in case of a tie, by category1 in ascending order lexicographically, and then by category2 in ascending order.


comments:
My immediate tought was to create all the product combinations for each buyer so i could fidn wich users bought diff products from diff categories.
But i realised that i needed to assert that the order of the categories would not result in a duplicate or that the product catg were different,_
so i used the LEAST and GREATEST functions and a <> condition, and then, after that, i just counted the unique users for each category pair and _
filtered as the problem requested.


*/

with Finfo as (
    select b.category, a.user_id, a.product_id, a.quantity
    from ProductPurchases as a
    join ProductInfo as b on a.product_id = b.product_id
),

buysComb as (
    select distinct LEAST(a.category,c.category) as catg1, GREATEST(a.category,c.category) as catg2, a.user_id, LEAST(a.product_id,c.product_id) as pd1, GREATEST(a.product_id,c.product_id) as pd2
    from Finfo as a
    join Finfo as c on a.user_id = c.user_id
    where a.category <> c.category 
    group by a.product_id, c.product_id,a.category,c.category,a.user_id
)

select catg1 as category1, catg2 as category2, count(ids) as customer_count
from (
    select distinct catg1, catg2, user_id as ids 
    from buysComb
    where catg1 < catg2 
    order by catg1, catg2
)
group by catg1, catg2
having count(ids) > 2
order by customer_count desc, catg1 asc, catg2 asc