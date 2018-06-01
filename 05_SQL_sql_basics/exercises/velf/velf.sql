---select count(*) from dssgeu.cleaned.inspections;
--- 1. Show me the last 10 violations (ORDER BY date)
select * from dssgeu.cleaned.violations
order by date desc
limit 10;

--- 2. Count the violations with code 34 that happened already this year


select count(*) from dssgeu.cleaned.violations as vio
where vio.code='34' 
and vio.date >= '2018-01-01';

---3. How many code are there by the way? can you show them?
select distinct count(code) from dssgeu.cleaned.violations;

---4. Do you have an idea of what inspection generate each violation? 
---That means, can you join the inspection to the corresponding violation for the day of "2018-05-25"?
select * from dssgeu.cleaned.inspections as insp
left join  dssgeu.cleaned.violations as vio
on vio.inspection=insp.inspection
where vio.date='2018-05-25'
limit 10;

--- 5. Is there any violation without inspection defined? Of course not, right?
select count(*) from dssgeu.cleaned.violations as vio
where vio.inspection = NULL;

--- 6. Get a list of the number of violations by code (since ever)
select 
code,
count(code) as num_of_violations
from dssgeu.cleaned.violations
group by code
order by 2 DESC;


--- 7. Get a list of the number of violations by type (just during this year) for codes below 15

select 
code,
count(code) as num_of_violations
from dssgeu.cleaned.violations
where code != '' AND code::integer<=15
and date>='2018-01-01'
group by code
order by 2 DESC;
