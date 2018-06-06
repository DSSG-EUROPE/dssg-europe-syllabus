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



-- crq: scratch
select * 
from semantic.inspections as table_a left join raw.inspections 
on table_a.event_id::int4 = raw.inspections.inspection::int4;
select date_part('month', semantic.inspections.date)::int4 from semantic.inspections;
select date_part('year', semantic.inspections.date)::int4 from semantic.inspections;
select city from (select * from semantic.inspections left join raw.inspections on semantic.inspections.event_id::int4 = raw.inspections.inspection::int4) joined_table;
select * from  (semantic.inspections as v left join raw.inspections on v.event_id::int4 = raw.inspections.inspection::int4) joined_table;
select * from  (semantic.inspections s left join raw.inspections r on s.event_id::int4 = r.inspection::int4) joined_table;
select * from  (semantic.inspections left join raw.inspections on semantic.inspections.event_id::int4 = raw.inspections.inspection::int4) joined_table;
select semantic.inspections.date as dates from semantic.inspections;
select semantic.inspections.date as date1, raw.inspections.date as date2 from  (semantic.inspections left join raw.inspections on (semantic.inspections.event_id::int4 = raw.inspections.inspection::int4));
select s.* from  (semantic.inspections s inner join raw.inspections r on s.event_id::int4 = r.inspection::int4);
select joined_table.city from (select * from semantic.inspections as table_a left join raw.inspections on table_a.event_id::int4 = raw.inspections.inspection::int4) joined_table;
select city from (semantic.inspections as table_a left join raw.inspections as table_b on table_a.event_id::int4 = table_b.inspection::int4);


-- crq: this runs
select v.date from (semantic.inspections as v left join raw.inspections on v.event_id::int4 = raw.inspections.inspection::int4);

-- crq: this does NOT run because of the `useless_name`. Why? 
-- crq: ? todo error: `There is an entry for table … but it cannot be referenced from this part of the query`. Ref:https://stackoverflow.com/questions/6347897/mixing-explicit-and-implicit-joins-fails-with-there-is-an-entry-for-table-b 
select v.date from (semantic.inspections as v left join raw.inspections on v.event_id::int4 = raw.inspections.inspection::int4) useless_name; -- crq: throws error

select city from (semantic.inspections as table_a left join raw.inspections on table_a.event_id::int4 = raw.inspections.inspection::int4)
where extract(year from table_a.date)::int4 = 2017;

select
        date_part('month', table_a.date)::int4 as mm,
        date_part('year', table_a.date)::int4 as yy,
        city, -- crq: ? how to map zipcode to city?
        table_a.facility_type as ff,
        result as rr,
        count(*) as number_of_inspections
from (semantic.inspections table_a left join raw.inspections table_b on table_a.event_id::int4 = table_b.inspection::int4)
where date_part('year', table_a.date) = 2017 and date_part('month', table_a.date) = 1
group by date_part('month', table_a.date), yy, ff, rr, city; -- crq: ? Why do I have to group by this?
--group by GROUPING SETS (month, year, city, facility_type, results, ())
--group by ROLLUP (month, year, city, facility_type, results)
--group by CUBE (month, year, city, facility_type, results)



select
        -- license_num,
        -- facility,
        facility_type as ff,
        date_part('year',date) as yy,
        count(*) as inspections
from semantic.inspections 
where date_part('year',date) = 2015 and facility_type is not null
group by ff, yy; -- , license_num, facility;


select
        license_num,
        facility,
        table_a.facility_type,
        date_part('year', date) as yy,
        count(*) as inspections
from (semantic.inspections as table_a left join semantic.entities as table_b on table_a.entity_id = table_b.entity_id)
where date_part('year', date) = 2015 and table_a.facility_type is not null
group by license_num, facility, table_a.facility_type, yy;


with failures_per_facility as (
    select
            license_num,
            facility,
            table_a.facility_type,
            date_part('year', date)::int4 as yy,
            count(*) as inspections
    from (semantic.inspections as table_a left join semantic.entities as table_b on table_a.entity_id = table_b.entity_id)
    where date_part('year', date) = 2015 and table_a.facility_type is not null
    group by license_num, facility, table_a.facility_type, yy
)
select
        yy,
        license_num,
        facility,
        facility_type,
        inspections,
        sum(inspections) over w1 as "total inspections per type",
        100*(inspections::decimal/sum(inspections) over w1)::numeric(18,1)  as "% of inspections",
        (avg(inspections) over w1)::numeric(18,3) as "avg inspections per type",
        inspections - avg(inspections) over w1 as "distance from avg",
        first_value(inspections) over w2 as "max inspections per type",
        inspections - first_value(inspections) over w2 as "distance from top 1",
        dense_rank() over w2 as rank,
        (nth_value(inspections,1) over w3 / inspections::decimal)::numeric(18,1) as "rate to top 1",
        ntile(5) over w2 as ntile
from failures_per_facility
where facility_type = 'restaurant'
window
       w1 as (partition by facility_type, yy),
       w2 as (partition by facility_type, yy order by inspections desc),
       w3 as (partition by facility_type, yy order by inspections desc rows between unbounded preceding and unbounded following)
limit 10;

