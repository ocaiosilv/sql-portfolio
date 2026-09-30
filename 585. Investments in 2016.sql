/*
Table: Insurance

+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| pid         | int   |
| tiv_2015    | float |
| tiv_2016    | float |
| lat         | float |
| lon         | float |
+-------------+-------+
pid is the primary key (column with unique values) for this table.
Each row of this table contains information about one policy where:
pid is the policyholder's policy ID.
tiv_2015 is the total investment value in 2015 and tiv_2016 is the total investment value in 2016.
lat is the latitude of the policy holder's city. It's guaranteed that lat is not NULL.
lon is the longitude of the policy holder's city. It's guaranteed that lon is not NULL.
 

Write a solution to report the sum of all total investment values in 2016 tiv_2016, for all policyholders who:

have the same tiv_2015 value as one or more other policyholders, and
are not located in the same city as any other policyholder (i.e., the (lat, lon) attribute pairs must be unique).
Round tiv_2016 to two decimal places.
*/

with NonUnique2015 as (
    select tiv_2015
    from (
        select Insurance.tiv_2015, count(Insurance.tiv_2015) as total
        from Insurance
        group by Insurance.tiv_2015)
    where total > 1
),

DiffLatitude as (
    select lat, lon
    from (
        SELECT lat, lon, COUNT(*)
        FROM Insurance
        GROUP BY lat, lon)
    where count < 2
)

SELECT SUM(tiv_2016)::numeric(10,2) AS tiv_2016
from Insurance
where Insurance.tiv_2015 in (
    select tiv_2015
    from NonUnique2015
) 
AND (Insurance.lat, Insurance.lon) in (
    select *
    from DiffLatitude
)
