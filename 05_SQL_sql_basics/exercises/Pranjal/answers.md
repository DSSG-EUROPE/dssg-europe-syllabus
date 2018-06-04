--- Task 1: Select the last 10 violations and order by date

SELECT * 
FROM cleaned.violations 
ORDER by date desc 
limit 10
 
--- Task 2: Count the violations with code 34 that have happened this year
 
SELECT COUNT(*) 
FROM cleaned.violations 
where date_part('year', date) = 2018 and code != '' and code::integer = 34 --- why do we have to say '34' and not 34?
  
--- Task 3: How many unique violation codes are there?

SELECT COUNT(DISTINCT (code)) 
FROM cleaned.violations 


--- Task 4:  Can you join the inspection to the corresponding violation for the day of "2018-05-25"?

SELECT * 
FROM cleaned.inspections
INNER JOIN cleaned.violations   
ON violations.inspection = inspections.inspection
WHERE inspections.date = '2018-05-25'

--- Task 5:  Is there any violation without a record of inspection?

SELECT COUNT(*) 
FROM cleaned.violations 
LEFT OUTER JOIN cleaned.inspections ON violations.inspection = inspections.inspection 
WHERE inspections.inspection IS NULL

--- Task 6:  Get a list of the number of violations by code.

SELECT code, count(*) 
from cleaned.violations 
GROUP BY code

--- Task 7:	 Get a list of the number of violations by type, for this year, and for codes below 15
SELECT violations.code 
FROM cleaned.violations  
WHERE date_part('year', date) = 2018 
GROUP BY violations.code 
having code != '' and code::integer < 15



