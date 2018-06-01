1.
select * from cleaned.violations order by date desc limit 10;

2.
select count(*) from cleaned.violations where date >= '2018-01-01' and code = '34';

3.
select count(distinct code) from cleaned.violations;

4.
select a.*, b.type
from cleaned.violations as a
left join cleaned.inspections as b
on a.inspection = b.inspection
where a.date = '2018-05-25';

5.
select a.*, b.*
from cleaned.violations as a
left join cleaned.inspections as b
on a.inspection = b.inspection
where b.type = NULL;

6.
select code, count(*)
from cleaned.violations
group by code;

7.
select code, count(*)
from cleaned.violations
group by code
having code != '' and code::integer < 15 order by code::integer;

