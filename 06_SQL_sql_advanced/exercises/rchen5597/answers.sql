select
       json_agg(
        row_to_json(v.*)
       ) as violations
from cleaned.violations as v
where inspection  = '2078651';


select
        v.inspection,
        v.license_num,
        v.date,
        extract(year from v.date)::int,  -- crq: some change here
        json_agg(
                 json_build_object('code',v.code, -- crq: some change here
                                   'description', v.description,  -- crq: some change here
                                   'comment',v.comment)  -- crq: some change here
        ) as violations
from cleaned.violations as v
where inspection  = '2078651'
group by v.inspection, v.license_num, v.date; 
-- We need a group by since we are using an aggregator function


with new_violations as (
    select
        v.inspection,
        v.license_num,
        v.date,
        extract(year from v.date)::int,  -- crq: some change here
        json_agg(
                 json_build_object('code',v.code, -- crq: changed
                                   'description', v.description, -- crq: changed
                                   'comment',v.comment)  -- crq: changed
        ) as sub_violations
    from cleaned.violations as v
    where inspection  = '2078651'
    group by v.inspection, v.license_num, v.date
)
select i.*, v.sub_violations
from cleaned.inspections as i
left join new_violations as v -- Here we are using the "common table"
using (inspection); -- crq: this is the key used for joining
-- crq: match the different table / query names above 


with new_violations as (
     select
        event_id as inspection, -- crq: changed
        jsonb_array_elements(violations) as violations -- This returns several rows
     from semantic.inspections
     where event_id = '104246' -- crq: ? Can I call this `inspection` also? 
)
select inspection,
       violations ->> 'code' as violation_code, -- We want the value of the key 'code'
       count(*)
from new_violations
group by inspection, violation_code;  -- crq: changed 
-- crq: ? these must be here, else errors happen. Why?
-- crq: ? Why do we still have `group by`? I already fixed to have `event_id` = 104246


-- This doesn't give you the subtotals and totals
select
        date_part('month', date)::int4 as mm,
        date_part('year', date)::int4 as yy,
        -- city, -- crq: ? how to map zipcode to city?
        facility_type as ff,
        result as rr,
        count(*) as number_of_inspections
from semantic.inspections
where date_part('year', date) = 2017 and date_part('month', date) = 1
group by date_part('month', date), yy, ff, rr; -- crq: ? Why do I have to group by this?
--group by GROUPING SETS (month, year, city, facility_type, results, ())
--group by ROLLUP (month, year, city, facility_type, results)
--group by CUBE (month, year, city, facility_type, results)


select * 
from semantic.inspections left join raw.inspections 
on semantic.inspections.event_id::int4 = raw.inspections.inspection::int4;

--
---- crq: ? todo 
--select
--        date_part('month', semantic.inspections.date)::int4 as mm,
--        date_part('year', semantic.inspections.date)::int4 as yy,
--        city, -- crq: ? how to map zipcode to city?
--        facility_type as ff,
--        result as rr,
--        count(*) as number_of_inspections
--from (select * from semantic.inspections left join raw.inspections on semantic.inspections.event_id::int4 = raw.inspections.inspection::int4) joined_table
--where date_part('year', semantic.inspections.date) = 2017 and date_part('month', semantic.inspections.date) = 1
--group by date_part('month', semantic.inspections.date), yy, ff, rr, city; -- crq: ? Why do I have to group by this?
----group by GROUPING SETS (month, year, city, facility_type, results, ())
----group by ROLLUP (month, year, city, facility_type, results)
----group by CUBE (month, year, city, facility_type, results)
--
--
--select
--        -- license_num,
--        -- facility,
--        facility_type as ff,
--        date_part('year',date) as yy,
--        count(*) as inspections
--from semantic.inspections 
--where date_part('year',date) = 2015 and facility_type is not null
--group by ff, yy -- , license_num, facility;
--
--
--
--with failures_per_facility as (
--select
--        license_num,
--        facility,
--        facility_type,
--        year,
--        count(*) as inspections
--from semantic.inspections
--where year = 2015 and facility_type is not null
--group by license_num, facility, facility_type, year
--)
--select
--        year,license_num,facility,facility_type,
--        inspections,
--        sum(inspections) over w1 as "total inspections per type",
--        100*(inspections::decimal/sum(inspections) over w1)::numeric(18,1)  as "% of inspections",
--        (avg(inspections) over w1)::numeric(18,3) as "avg inspections per type",
--        inspections - avg(inspections) over w1 as "distance from avg",
--        first_value(inspections) over w2 as "max inspections per type",
--        inspections - first_value(inspections) over w2 as "distance from top 1",
--        dense_rank() over w2 as rank,
--        (nth_value(inspections,1) over w3 / inspections::decimal)::numeric(18,1) as "rate to top 1",
--        ntile(5) over w2 as ntile
--from failures_per_facility
--where facility_type = 'WHOLESALE'
--window
--       w1 as (partition by facility_type, year),
--       w2 as (partition by facility_type, year order by inspections desc),
--       w3 as (partition by facility_type, year order by inspections desc rows between unbounded preceding and unbounded following)
--limit 10;
