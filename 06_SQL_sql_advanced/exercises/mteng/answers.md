LEANING AND MANIPULATING THE DATA
--There are 2 tables: violations and inspections
--How many rows per table? 
select count(*) from cleaned.violations;
select count(*) from cleaned.inspections;
--Any idea about how to join the tables? On violations.inspection and inspections.inspection
--Look at the inspection =2078651,= How many violations does it had? 11 violations
select count(inspection)
from cleaned.violations
where inspection = '2078651';

--MANIPULATING THE DATA - JSON
select
       json_agg(
        row_to_json(v.*)
       ) as violations
from cleaned.violations as v
where inspection  = '2078651';

select *
from
(select
        v.inspection,
        v.license_num,
        v.date,
        json_agg(
                 json_build_object('code',v.code,
                                   'description', v.description,
                                   'comment',v.comment)
        ) as violations
from cleaned.violations as v
where inspection  = '2078651'
group by v.inspection, v.license_num, v.date) as agg_v
join cleaned.inspections
on agg_v.inspection = cleaned.inspections.inspection;
-- We need a group by since we are using an aggregator function

--CTEs
-- You first define your subquery and assign a name to it
-- This will work as a "common table"
with violations as (
     select
        v.inspection,
        v.license_num,
        v.date,
        json_agg(
                json_build_object('code',v.code,
                                  'description', v.description,
                                  'comment',v.comment)
        ) as violations
      from cleaned.violations as v
      group by v.inspection, v.license_num, v.date
)
-- Then you can use it

select i.*, v.violations
from cleaned.inspections as i
left join violations as v -- Here we are using the "common table"
using (inspection);

--Querying unstructured data


with violations as (
     select
        event_id, entity_id,
        jsonb_array_elements(violations) as violations -- This returns several rows
     from semantic.inspections
), specific_events as (
select event_id,entity_id,
       violations ->> 'code' as violation_code, -- We want the value of the key 'code'
       count(*) as total
from violations
where violation_code = 40
group by event_id, violation_code, entity_id)
select license_num 
from semantic.entities
join specific_events
on semantic.entities.entity_id = specific_events.entity_id
group by license_num,specific_events.total
having specific_events.total = max(specific_events.total);

with violations as (
     select
        entity_id,
        jsonb_array_elements(violations) as violations -- This returns several rows
     from semantic.inspections
), subtable as 
(select entity_id,
       violations ->> 'code' as violation_code, -- We want the value of the key 'code'
       count(*) as num_violation
from violations
where violations ->> 'code'  = '40'
group by violation_code, entity_id)
select license_num, num_violation  from (semantic.entities
join subtable on subtable.entity_id = semantic.entities.entity_id)
order by subtable.num_violation desc
limit 1;

--Data warehousing function
select
        date_part('month', date),
        location,
        facility_type,
        "result" as results,
        count(*) as number_of_inspections
from semantic.inspections
where date_part('year', date) = 2017 and  date_part('month', date) = 1
--group by  date_part('month', date), date_part('year', date), location, facility_type, results

--group by GROUPING SETS (month, year, city, facility_type, results, ())
--group by  grouping sets (date_part('month', date), date_part('year', date), location, facility_type, results,())

--group by ROLLUP (month, year, city, facility_type, results)
--group by rollup(date_part('month', date), date_part('year', date), location, facility_type, results)

--group by CUBE (month, year, city, facility_type, results)
group by cube(date_part('month', date), date_part('year', date), location, facility_type, results);

--ANALYTICAL QUESTIONS
select facility_type, count(cleaned.inspections.inspection)
from cleaned.inspections
group by facility_type;

with count_insp as 
(select facility_type, sum(cleaned.inspections.inspection) as count_i
from cleaned.inspections
group by facility_type
)
select avg(count_i)
from count_insp
;

with count_insp as 
(select facility_type, sum(cleaned.inspections.inspection) as count_i
from cleaned.inspections
group by facility_type
), average as
(select avg(count_i) as avv
from count_insp
group by facility_type)
select facility_type, count_i - avv
from average, count_insp
;

with count_insp as 
(select facility_type, sum(cleaned.inspections.inspection) as count_i
from cleaned.inspections
group by facility_type
), maximum as
(select max(count_i) as avv
from count_insp
group by facility_type)
select facility_type, avv - count_i 
from maximum, count_insp
;


--select facility_type from semantic.inspections;

with failures_per_facility as (
select
        entity_id,
        facility_type,
        extract(year from date) as year,
        count(*)filter (where "result" = 'fail') as inspections_fail
from semantic.inspections
where extract(year from date) = 2015 and facility_type is not null
group by entity_id, facility_type, year
)
select
        year, entity_id,
        facility_type,     
        inspections_fail,
        sum(inspections_fail) over w1 as "total inspections per type",
        100*(inspections_fail::decimal/(sum(inspections_fail) over w1))::numeric(18,1)  as "% of inspections fails",
        (avg(inspections_fail) over w1)::numeric(18,3) as "avg inspections per type",
        inspections_fail - avg(inspections_fail) over w1 as "distance from avg",
        --first_value(inspections) over w2 as "max inspections per type",
        --inspections - first_value(inspections) over w2 as "distance from top 1",
        dense_rank() over w2 as rank
        --(nth_value(inspections,1) over w3 / inspections::decimal)::numeric(18,1) as "rate to top 1",
        --ntile(5) over w2 as ntile
from failures_per_facility
where facility_type = 'wholesale'
window
       w1 as (partition by facility_type, year),
       w2 as (partition by facility_type, year order by inspections_fail desc),
       w3 as (partition by facility_type, year order by inspections_fail desc rows between unbounded preceding and unbounded following)
limit 10;

--STILL NEED TO DO THAT

--Using the previous row 
select
entity_id,
date as inspection_date,
lag(date, 1) over w1 as previous_inspection,
age(date, lag(date,1) over w1) as time_since_last_inspection
from semantic.inspections
where facility_type = 'wholesale'
window w1 as (partition by entity_id order by date asc)
order by entity_id, date asc ;

--Using some other rows
with violations as (
select
        event_id,
        entity_id,
        date,
        jsonb_array_elements(violations) as violations
from semantic.inspections
),
number_of_violations as (
select
        event_id,
        entity_id,
        date,
        count(*) as num_of_violations
from violations
group by event_id, entity_id, date
)
select
        entity_id,
        date,
        num_of_violations,
        sum(num_of_violations) over w as running_total,
        array_agg(num_of_violations) over w as previous_violations
from number_of_violations
where  entity_id = 11326
window w as (partition by entity_id order by date asc rows between 3 preceding and 1 preceding);

--Hands-on
with risks as (
select
        date,
        entity_id,
        risk,
        lag(risk,1) over w as previous_risk
from semantic.inspections
window w as (partition by entity_id order by date asc)
)
select
        extract(year from date) as year,
        entity_id,
        count(case
             when risk = 'high' and previous_risk = 'medium' then 1
             when risk = 'medium' and previous_risk = 'low' then 1
        end) as up,
        count(case
             when risk = 'medium' and previous_risk = 'high' then 1
             when risk = 'low' and previous_risk = 'medium' then 1
        end) as down
from risks
group by entity_id, extract(year from date)
order by year, up desc, down desc
limit 10;

--MEANING in TEXT
--SPATIAL
select
        distinct on (entity_id, s.school_nm)
        entity_id, s.school_nm as "school"
from gis.public_schools as s join semantic.inspections as i
     on ST_DWithin(geography(s.wkb_geometry), geography(i.location), 200) -- This is the distance in meters
where facility_type = 'restaurant' and risk = 'high';

--PERMISSION PROBLEMMMMMMMM
