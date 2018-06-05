-- Q1 --
select * from cleaned.violations order by date desc limit 10;

-- Q2 --
select count(*) from cleaned.violations where code='34' and date >= '2018-01-01';
--SELECT COUNT(*) FROM cleaned.violations WHERE date_part('year', date)  = 2018 AND code = '34';

-- Q3 --
select count(distinct code) from cleaned.violations;
select distinct code from cleaned.violations;

-- Q4 --
select * from cleaned.violations as v inner join cleaned.inspections as i on (v.inspection = i.inspection) where v.date='2018-05-25';

-- Q5 --
select * from cleaned.violations as v left outer join cleaned.inspections as i on (v.inspection = i.inspection) where i.inspection is null;

-- Q6 --
select count(code), code from cleaned.violations group by code;

-- Q7 --
select count(code), code from cleaned.violations where date>='2018-01-01' group by code having code != '' and code::int < 15;
