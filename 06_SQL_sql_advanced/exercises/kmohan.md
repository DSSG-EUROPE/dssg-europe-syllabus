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
inner join cleaned.inspections on cleaned.inspections.inspection = v.inspection
where v.inspection  = '2078651'
group by v.inspection, v.license_num, v.date

-- 

with violations as (
     select
        event_id,
        entity_id,
        jsonb_array_elements(violations) as violations -- This returns several rows
     from semantic.inspections
)

select semantic.entities.entity_id,
		semantic.entities.facility,
       violations ->> 'code' as violation_code,
       count(*) as v_count
from violations
inner join semantic.entities on semantic.entities.entity_id=violations.entity_id
where  violations ->> 'code' = '40'
group by violation_code,semantic.entities.entity_id,
		semantic.entities.facility
order by v_count desc limit 1



