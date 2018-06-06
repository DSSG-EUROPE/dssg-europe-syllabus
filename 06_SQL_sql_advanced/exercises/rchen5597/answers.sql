-- Advanced SQL
-- # Before we start
-- ## The notes
-- ## Test your connection
-- # The punchline
-- # The food inspections data set
-- # Some basic tasks in a data analysis project
-- # Cleaning and manipulating the data
-- ## Hands-on
-- # Manipulating the data: JSON

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
        extract(year from v.date)::int,  -- crq: changed
        json_agg(
                 json_build_object('code',v.code, -- crq: changed
                                   'description', v.description,  -- crq: changed
                                   'comment',v.comment)  -- crq: changed
        ) as violations
from cleaned.violations as v
where inspection  = '2078651'
group by v.inspection, v.license_num, v.date; 
-- We need a group by since we are using an aggregator function

-- ## Hands-on: Estimated time: 1 minute Manipulate the previous query statement 
--              and try to join it with the inspections (You should get only one row)

with new_table as (
    select
            v.inspection,
            v.license_num,
            v.date,
            extract(year from v.date)::int,  -- crq: changed
            json_agg(
                     json_build_object('code',v.code, -- crq: changed
                                       'description', v.description,  -- crq: changed
                                       'comment',v.comment)  -- crq: changed
            ) as violations
    from cleaned.violations as v
    where inspection  = '2078651'
    group by v.inspection, v.license_num, v.date
)
select * from (cleaned.inspections right join new_table on cleaned.inspections.inspection = new_table.inspection)
-- crq: `right join` outputs a subset of the table on the right, i.e. `new_table`


-- # Cleaning your code and (maybe) gaining a little speed: CTEs
with new_violations as (
    select
        v.inspection,
        v.license_num,
        v.date,
        extract(year from v.date)::int,  -- crq: changed
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



-- crq: multiple with clauses below. Here we have two with clauses. 
-- crq: a good exercise is to match the different table / query names below
with new_violations as (
    select
        v.inspection as inspection_tmp,
        v.license_num,
        v.date,
        extract(year from v.date)::int,  -- crq: changed
        json_agg(
                 json_build_object('code',v.code, -- crq: changed
                                   'description', v.description, -- crq: changed
                                   'comment',v.comment)  -- crq: changed
        ) as sub_violations
    from cleaned.violations as v
    where inspection  = '2078651'
    group by v.inspection, v.license_num, v.date
),
new_table as (
    select
            v.inspection as inspection_tmp,
            v.license_num,
            v.date,
            extract(year from v.date)::int,  -- crq: changed
            json_agg(
                     json_build_object('code',v.code, -- crq: changed
                                       'description', v.description,  -- crq: changed
                                       'comment',v.comment)  -- crq: changed
            ) as violations
    from cleaned.violations as v
    where inspection  = '2078651'
    group by v.inspection, v.license_num, v.date
)
select i.*, v.sub_violations
from new_table as i
left join new_violations as v -- Here we are using the "common table"
using (inspection_tmp); -- crq: this is the key used for joining
-- crq: join. We can join using `on table_a.keyword_a = table_b.keyword_b`. 
-- If keyword_a and keyword_b are the same, say, both are `someWord`, we can just say `using someWord`. 


-- # Querying unstructured data

select
    -- event_id as inspection, -- crq: changed
    jsonb_array_elements(violations) as violations -- Each entry in the violations column is a json file
from semantic.inspections
where event_id = '104246'
limit 2;

select
    event_id as inspection, -- crq: changed
    jsonb_array_elements(violations) as violations -- Each entry in the violations column is a json file
    -- e.g. {"code": "30", "comment": "All food not stored in the original container shall be stored in properly labeled containers. CORRECTED ON 1-14-10", "severity": "minor", "description": "FOOD IN ORIGINAL CONTAINER, PROPERLY LABELED: CUSTOMER ADVISORY POSTED AS NEEDED"}
from semantic.inspections
where event_id = '104246';


with new_violations as (
     select
        event_id as inspection, -- crq: changed
        jsonb_array_elements(violations) as violations -- This returns several rows
     from semantic.inspections
     where event_id = '104246' -- crq: ? Can I call this `inspection` also? 
)
select inspection as inspection_tmp,
       violations ->> 'code' as violation_code_tmp, -- We want the value of the key 'code'
       violations ->> 'severity' as severity_tmp, -- crq: get the `severity` field out of the json file
       count(*)
from new_violations
group by inspection_tmp, violation_code_tmp, severity_tmp; 

-- crq: play with `group by`

select
    event_id as inspection, -- crq: changed
    jsonb_array_elements(violations) as violations -- This returns several rows
from semantic.inspections
where event_id = '104246'; -- crq: ? Can I call this `inspection` also?
     
-- crq: ? todo, not sure why the first chunk below works but the second doesn't. Differ in last lime.
-- crq: ? error message: Must appear in the GROUP BY clause or be used in an aggregate function
-- crq: chunk one. Works
with new_violations as (
     select
        event_id as inspection, -- crq: changed
        jsonb_array_elements(violations) as violations -- This returns several rows
     from semantic.inspections
     where event_id = '104246' -- crq: ? Can I call this `inspection` also? 
)
select inspection as inspection_tmp,
       violations ->> 'code' as violation_code_tmp, -- We want the value of the key 'code'
       violations ->> 'severity' as severity_tmp -- crq: get the `severity` field out of the json file
from new_violations
group by violation_code_tmp, inspection_tmp, severity_tmp; 

-- crq: chunk two. Does not work.
with new_violations as (
     select
        event_id as inspection, -- crq: changed
        jsonb_array_elements(violations) as violations -- This returns several rows
     from semantic.inspections
     where event_id = '104246' -- crq: ? Can I call this `inspection` also? 
)
select inspection as inspection_tmp,
       violations ->> 'code' as violation_code_tmp, -- We want the value of the key 'code'
       violations ->> 'severity' as severity_tmp -- crq: get the `severity` field out of the json file
from new_violations
group by violation_code_tmp, severity_tmp; 




with new_violations as (
     select
        event_id as inspection, -- crq: changed
        jsonb_array_elements(violations) as violations -- This returns several rows
     from semantic.inspections
     where event_id = '104246' -- crq: ? Can I call this `inspection` also? 
)
select inspection as inspection_tmp,
       violations ->> 'code' as violation_code, -- We want the value of the key 'code'
       count(*)
from new_violations
group by inspection_tmp, violation_code;  -- crq: changed 
-- crq: ? todo these must be here, else errors happen. Why?
-- crq: ? todo Why do we still have `group by`? I already fixed to have `event_id` = 104246


-- ## Hands-on: Estimated time: 2 minutes Modify this query to get the facility (using license_num) 
--             in which the inspectors found the biggest number of violation code 40.



with new_table as (
    with new_violations as (
     select
         license_num,
        jsonb_array_elements(violations) as violations -- This returns several rows
     from (semantic.inspections inner join semantic.entities using (entity_id))
    )
    select 
        license_num,
        violations ->> 'code' as violation_code_tmp  
    from new_violations
    where violations ->> 'code'  is not null
)
select license_num, count(*) from new_table where violation_code_tmp = '40' group by license_num order by count(*) desc limit 3;


-- crq: see what violation codes there are 
with new_table as (
    with new_violations as (
     select
         license_num,
        jsonb_array_elements(violations) as violations -- This returns several rows
     from (semantic.inspections inner join semantic.entities using (entity_id))
    )
    select 
        license_num,
        violations ->> 'code' as violation_code_tmp  
    from new_violations
    where violations ->> 'code'  is not null
)
select distinct violation_code_tmp from new_table order by violation_code_tmp asc;

-- hands on solution: get the top three facilities (identified by facility_num) with the most code-40 violation
with new_table as (
    with new_violations as (
     select
         license_num,
        jsonb_array_elements(violations) as violations -- This returns several rows
     from (semantic.inspections inner join semantic.entities using (entity_id))
    )
    select 
        license_num,
        violations ->> 'code' as violation_code_tmp  
    from new_violations
    where violations ->> 'code'  is not null and violations ->> 'code'  <> ''  -- crq: useful, check if entry is not empty space.
)
select license_num, count(*) from new_table where violation_code_tmp::int4 = 40 group by license_num order by count(*) desc limit 3;


-- # “Datawarehousing”

-- ## Hands-on
--         Generate data for a BI dashboard, that shows all total number of inspections, 
--      and their results, per city, facility type, month, year including totals and subtotals
-- crq: ? todo. que? no entiendo.

-- ## Datawarehousing functions
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

-- ## Hands-on

-- crq: ? todo. Can spend some more time here. 
--         The three code chunks below work, but what do they do? They differ in the group by clauses. 
--         Compare the output and find the differences.

select
        date_part('month', date)::int4 as mm,
        date_part('year', date)::int4 as yy,
        -- city, -- crq: ? how to map zipcode to city?
        facility_type as ff,
        result as rr,
        count(*) as number_of_inspections
from semantic.inspections
where date_part('year', date) = 2017 and date_part('month', date) = 1
group by GROUPING SETS (mm, yy, ff, rr, ())



select
        date_part('month', date)::int4 as mm,
        date_part('year', date)::int4 as yy,
        -- city, -- crq: ? how to map zipcode to city?
        facility_type as ff,
        result as rr,
        count(*) as number_of_inspections
from semantic.inspections
where date_part('year', date) = 2017 and date_part('month', date) = 1
group by ROLLUP (mm, yy, ff, rr)



select
        date_part('month', date)::int4 as mm,
        date_part('year', date)::int4 as yy,
        -- city, -- crq: ? how to map zipcode to city?
        facility_type as ff,
        result as rr,
        count(*) as number_of_inspections
from semantic.inspections
where date_part('year', date) = 2017 and date_part('month', date) = 1
group by CUBE (mm, yy, ff, rr)

-- crq: todo. Continue from here. 


-- # Analytical Questions: Looking through the window

-- ## Hands-on

-- # Analytical Questions: Looking through the window
-- ## Window functions

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
select my_date from (select v.date as my_date, * from semantic.inspections as v left join raw.inspections on v.event_id::int4 = raw.inspections.inspection::int4) as useless_name; -- crq: throws error
select v.date from (semantic.inspections as v left join raw.inspections on v.event_id::int4 = raw.inspections.inspection::int4); -- crq: throws error


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


-- ## Hands-on


-- # Analytical Questions: Using the previous row
select
entity_id,
date as inspection_date,
lag(date, 1) over w1 as previous_inspection,
age(date, lag(date,1) over w1) as time_since_last_inspection
from semantic.inspections
where facility_type = 'wholesale'
window w1 as (partition by entity_id order by date asc)
order by entity_id, date asc;

-- # Analytical Questions: Using some other rows

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
where  entity_id = 222
window w as (partition by entity_id order by date asc rows between 3 preceding and 1 preceding);


-- ## Hands on

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
limit 7;


-- # Meaning in text

-- ## Full Text Search

select
       comment,
       replace(plainto_tsquery(comment)::text, ' & ', ' ') as cleaned_comment,
       to_tsvector(comment) as vectorized_comment
from cleaned.violations limit 7;

-- START FROM HERE

-- crq: runs, but takes a whole lotta time
select
        regexp_split_to_table(cleaned_comment, '\s+') as word,
        count(1) as word_count
from text_analysis.comments
group by word
--order by word_count desc 
limit 1;


-- # Spatial awareness



select
        distinct on (entity_id, s.school_nm)
        entity_id, s.school_nm as "school"
from gis.public_schools as s join semantic.events as i
     on ST_DWithin(geography(s.wkb_geometry), geography(i.location), 200) -- This is the distance in meters
where facility_type = 'restaurant' and risk = 'high';


-- todo 
-- # Appendix
-- ## Creating the database 
