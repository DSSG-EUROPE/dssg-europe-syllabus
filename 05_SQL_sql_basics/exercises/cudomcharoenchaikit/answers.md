#### Q1
select * from dssgeu.cleaned.violations order by "date" desc limit 10; 


####  2. Count the violations with code 34 that happened already this year 
SELECT COUNT(*) FROM dssgeu.cleaned.violations as v WHERE v.code = '34' and v.date>='2018-01-01';



#### 3. How many code are there by the way? can you show them?
SELECT COUNT(DISTINCT code) FROM dssgeu.cleaned.violations;

#### 4. Do you have an idea of what inspection generate each violation? That means, can you join the inspection to the corresponding violation for the day of "2018-05-25"?

select * from dssgeu.cleaned.inspections as ins
left join dssgeu.cleaned.violations as v
on ins.inspection = v.inspection
where ins.date = '2018-05-25';

#### 5. Is there any violation without inspection defined? Of course not, right?
select count(*) from dssgeu.cleaned.violations as v
where v.inspection=null;


#### 6. Get a list of the number of violations by code (since ever)
select
code,
count(code)
FROM
dssgeu.cleaned.violations
GROUP BY
code;



#### 7. Get a list of the number of violations by type (just during this year) for codes below 15
select
code,
count(code)
FROM
dssgeu.cleaned.violations
where 
code!='' and code::integer<15 and date>='2018-01-01'
GROUP BY
code;
