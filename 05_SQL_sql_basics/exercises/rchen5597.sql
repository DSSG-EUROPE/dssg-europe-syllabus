-- Reference: https://github.com/DSSG-EUROPE/dssg-europe-syllabus/tree/master/05_SQL_sql_basics
-- Exercise 
-- SELECT, ORDER BY, LIMIT and OFFSET
-- 1. Show me the last 10 violations (ORDER BY date)

-- WHERE
-- 2. Count the violations with code 34 that happened already this year

-- DISTINCT
-- 3. How many code are there by the way? can you show them?

-- INNER, LEFT, RIGHT JOIN, FULL OUTER JOIN
-- 4. Do you have an idea of what inspection generate each violation? That means, can you join the inspection to the corresponding violation for the day of "2018-05-25"?

-- 5. Is there any violation without inspection defined? Of course not, right?

-- GROUP BY, HAVING
-- Ok, lets aggregate rows that have the same characteristics. For instance,

-- 6. Get a list of the number of violations by code (since ever)

-- Now, let's filters before and after grouping:

-- 7. Get a list of the number of violations by type (just during this year) for codes below 15

-- # 1
select * from cleaned.violations order by date desc limit 10;

-- # 2
select count(*) from cleaned.violations where  code = '34' and extract(year from date)::int = 2018;

-- # 3
select count(distinct(code)) from cleaned.violations;

-- # 4
select * from cleaned.violations join cleaned.inspections on cleaned.violations.inspection = cleaned.inspections.inspection limit 10;

-- # 5
select count(*) from cleaned.violations left join cleaned.inspections on violations.inspection = inspections.inspection 
    where inspections.inspection is null;

-- # 6
select count(*), code from cleaned.violations group by code;

-- # 7
select count(*), code from cleaned.violations where date_part('year', date) = 2018 and code != '' and code::int4 < 15 group by code;

select count(*), code from cleaned.violations where date_part('year', date) = 2018 group by code having code != '' and code::int4 < 15;

-- Note that `where` comes before `group by` vs. `having` comes after `group by`

