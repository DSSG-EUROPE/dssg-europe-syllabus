select * from cleaned.violations order by "date" limit 10;
select count(*) from cleaned.violations where code='34' and date >= '2018-01-01'
select count(distinct code) from cleaned.violations
select * from cleaned.inspections 
inner join cleaned.violations on cleaned.inspections.inspection=cleaned.violations.inspection 
where cleaned.inspections.date='2018-05-25'

select count(*) from cleaned.violations where inspection=null

select cleaned.violations.code,count(*) from cleaned.violations group by cleaned.violations.code

select cleaned.violations.code,count(*) from cleaned.violations 
where cleaned.violations.date >= '2018-01-01' and cleaned.violations.code != ''
and cleaned.violations.code::integer < 15
group by cleaned.violations.code 

