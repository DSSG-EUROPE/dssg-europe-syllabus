1.
SELECT * FROM cleaned.inspections ORDER BY date DESC LIMIT 10;

2.
SELECT count(*) FROM cleaned.violations WHERE code LIKE '34' AND EXTRACT(year FROM "date") = 2018;

3. 
select count (*) from (select distinct code from cleaned.violations) as temp;

select distinct code from cleaned.violations;

4.
SELECT * FROM cleaned.violations 
JOIN cleaned.inspections 
ON violations.inspection=inspections.inspection 
WHERE inspections.date =  '2018-05-25';

5.
select count(*) from cleaned.violations join cleaned.inspections
on violations.inspection=inspections.inspection
where inspections.inspection isnull;

6.
SELECT code, count(*) FROM cleaned.violations GROUP BY code;

7.
SELECT code, count(*) FROM cleaned.violations where data_part('year', date)=18 GROUP BY code HAVING code != '' AND code::int < 15;
