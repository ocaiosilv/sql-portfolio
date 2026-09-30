/*
Table: Sales

+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| sale_id     | int   |
| product_id  | int   |
| year        | int   |
| quantity    | int   |
| price       | int   |
+-------------+-------+
(sale_id, year) is the primary key (combination of columns with unique values) of this table.
Each row records a sale of a product in a given year.
A product may have multiple sales entries in the same year.
Note that the per-unit price.

Write a solution to find all sales that occurred in the first year each product was sold.

For each product_id, identify the earliest year it appears in the Sales table.

Return all sales entries for that product in that year.
*/

with minY as (
    select  product_id , min(year) as year
    from Sales
    group by product_id
)


select s.product_id , s.year as first_year , s.quantity as quantity , s.price as price
from Sales as s
join minY as mY on mY.product_id = s.product_id AND mY.year = s.year
