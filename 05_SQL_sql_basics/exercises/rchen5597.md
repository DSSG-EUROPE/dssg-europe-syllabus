select * from cleaned.violations order by date desc limit 10;
select count(*) from cleaned.violations where  code = '34' and extract(year from date)::int = 2018;
select count(distinct(code)) from cleaned.violations;
select * from cleaned.violations join cleaned.inspections on cleaned.violations.inspection = cleaned.inspections.inspection limit 10;
select count(*) from cleaned.violations left join cleaned.inspections on violations.inspection = inspections.inspection 
    where inspections.inspection is null;
select count(*), code from cleaned.violations group by code;
select count(*), code from cleaned.violations where date_part('year', date) = 2018 and code != '' and code::int4 < 15 group by code;


