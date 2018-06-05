select * from cleaned.violations
 order by "date" desc
 limit 10 ;
 
 SELECT COUNT(inspection) FROM cleaned.violations WHERE code='34';
  
 SELECT COUNT(DISTINCT code) FROM cleaned.violations as code_count;
 SELECT DISTINCT code FROM cleaned.violations order by code;

 
SELECT cleaned.inspections.inspection, cleaned.violations.code
FROM (cleaned.inspections
INNER JOIN cleaned.violations ON cleaned.inspections.inspection=cleaned.violations.inspection)
where cleaned.inspections.date = '2018-05-25';

--Q5  --violations without record of inspection
select cleaned.violations.inspection, cleaned.violations.code
from (cleaned.violations
left join cleaned.inspections on cleaned.inspections.inspection=cleaned.violations.inspection)
where cleaned.inspections.inspection is null;

--Q6

select code, count(*) 
from cleaned.violations group by code;

--Q7
SELECT code, count(*)
FROM cleaned.violations
where date >= '2018-01-01'
GROUP BY code
HAVING code!='' and code::integer<15
order by code::integer;

