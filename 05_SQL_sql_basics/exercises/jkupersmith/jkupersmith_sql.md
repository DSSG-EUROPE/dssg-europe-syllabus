1.   SELECT * FROM cleaned.violations ORDER BY date    DESC LIMIT 10;

2. SELECT * FROM cleaned.violations where code='34' and date >= '2018-01-01'

3. SELECT count(distinct(code)) FROM cleaned.violations;
 
 
4. SELECT 
  * 
FROM 
  cleaned.violations 
INNER JOIN cleaned.inspections ON violations.inspection = inspections.inspection
WHERE cleaned.violations.date = '2018-05-25';

5.
SELECT count(*)
FROM cleaned.inspections
INNER JOIN cleaned.violations ON violations.inspection = inspections.inspection 
WHERE 
  inspections.inspection IS null;
  
  NO

  
  6.  Get a list of the number of violations by code.
  
  SELECT inspection, count(*)
  FROM cleaned.violations
  GROUP BY  violations.inspection
  
  
  7. 
  
  7. Get a list of the number of violations by type, for this year, and for codes below 15
  
 SELECT violations.code, count(*)
  FROM cleaned.violations
  
  WHERE date >= '2018-01-01' and code::integer < 15
 GROUP BY  violations.code;
  
  
