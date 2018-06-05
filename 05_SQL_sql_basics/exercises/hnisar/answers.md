select * from cleaned.inspections order by "date" desc limit 10;

select * from cleaned.violations where code = '34' and date >= '2018-01-01';

select distinct code from cleaned.violations;

--4. Do you have an idea of what inspection generate each violation? That means,
--can you join the inspection to the corresponding violation for the day of "2018-05-25"

select * from cleaned.inspections as i, cleaned.violations as v where i.inspection = v.inspection and i.date = '2018-05-25'; 

--5. Is there any violation without inspection defined? Of course not, right?
-- is wrong select * from cleaned.violations where inspection is null;
SELECT COUNT(*) FROM cleaned.violations LEFT OUTER JOIN cleaned.inspections ON violations.inspection = inspections.inspection WHERE inspections.inspection IS null;

--6

select code, count(code) from cleaned.violations group by code;

--Get a list of the number of violations by type (just during this year) for codes below 15

select code, count(inspection) from cleaned.violations where  date>='2018-01-01'
group by code having code!='' and code::int <=15;




