# SQL Basics
This tutorial is a starting point for SQL, we go fast at the beginning but if you are confused go through this tutorial or ask us:

```
http://www.postgresqltutorial.com/

``` 



### Basic DML vs DDL -> Manipulation vs Definition

DDL is the language you use to define/configure your database model for instance; Normally is connected with DBA (DB administration)examples are creating a Table, adding a user, adding an index or even creating a Database Schema;

for more examples see 

```
http://www.postgresqltutorial.com/postgresql-administration/
``` 


DML is your thing: working with data. We're doing this tutorial by example. For each question we ask, we answer with a query


Let's get data FROM several places and make a file with all results identified by the number of the step. The file name should be your name;

This is something you should submit at the end of the session, to the repo to 

`dssg-europe-syllabus/04_SQL_sql_basics/exercises/[your_name_folder]`


### Database Scenario: The food inspections data set

The data represents the inspections made in different facilities in the area of Chicago.

There are different types of inspections, different types of facilities and different results (or outcomes) of that inspections. Also the data contains the types of violations and text descriptions in free form about the violations.

Obviously, we have spatio-temporal data (i.e. the inspections happen in a given time at some place).


Take a couple of minutes to Look at the data in the `Cleaned` Schema

```

  Hands-on
  Expected time: 5 minutes

  Feel the data:

  How many tables are there?
  Which are the respective columns?
  How many rows per table?
  Any idea about how to join them?
  
```


### SELECT, ORDER BY, LIMIT and OFFSET

**1. Show me the last 10 violations (ORDER BY date)**


### WHERE 


**2. Count the violations with code 34 that happened already this year**



### DISTINCT

**3. How many code are there by the way? can you show them?**


### INNER, LEFT, RIGHT JOIN, FULL OUTER JOIN

**4. Do you have an idea of what inspection generate each violation? That means, can you join the inspection to the corresponding violation for the day of "2018-05-25"?**


**5. Is there any violation without inspection defined? Of course not, right?**


### GROUP BY, HAVING

Ok, lets aggregate rows that have the same characteristics. For instance, 

**6. Get a list of the number of violations by code (since ever)**

Now, let's filters **before** and **after** grouping:


**7. Get a list of the number of violations by type (just during this year) for codes below 15**


----------
## ANSWERS


### SELECT, ORDER BY, LIMIT and OFFSET

**1. Show me the last 10 violations (ORDER BY date)**

```SQL
SELECT * FROM cleaned.violations ORDER BY date desc limit 10
```


### WHERE 


**2. Count the violations with code 34 that happened already this year**

```SQL
SELECT COUNT(*) FROM cleaned.violations WHERE date_part('year', date)  = 2018 AND code = '34'
```


### DISTINCT

**3. How many code are there by the way? can you show them?**

```SQL
SELECT COUNT(DISTINCT (code)) FROM cleaned.violations
```
```SQL
SELECT DISTINCT (code) FROM cleaned.violations
```

### INNER, LEFT, RIGHT JOIN, FULL OUTER JOIN

**4. Do you have an idea of what inspection generate each violation? That means, can you join the inspection to the corresponding violation for the day of "2018-05-25"?**

**Let's start being careful with identation from now on**

```SQL
SELECT 
  * 
FROM 
  cleaned.violations 
INNER JOIN cleaned.inspections ON violations.inspection = inspections.inspection
```




**5. Is there any violation without inspection defined? Of course not, right?**

```SQL
SELECT 
  COUNT(*) 
FROM 
  cleaned.violations 
LEFT OUTER JOIN cleaned.inspections ON violations.inspection = inspections.inspection 
WHERE 
  inspections.inspection IS NULL
```


### GROUP BY, HAVING

Ok, lets aggregate rows that have the same characteristics. For instance, 

**6. Get a list of the number of violations by code (since ever)**

```SQL
SELECT 
  code, count(*) 
from 
  cleaned.violations 
GROUP BY 
  code 
```

Now, let's filters **before** and **after** grouping:


**7. Get a list of the number of violations by type (just during this year) for codes below 15**

```SQL
SELECT 
  code, count(*) 
from 
  cleaned.violations 
where 
  date_part('year', date) = 2018
GROUP BY 
  code 
having 
  code != '' and code::integer < 15
```

- before query was done with where
- after query was done with having


**8. Submit your data! Create a file with your name with your queries, and your answers (when they make sense) and push it to the `/exercises/[your_name_folder]` directory on this Repo**

Let's get a little more analytical


-----

Grouping in PostGres (and other Analytical databases) could be quite powerful

### GROUPING SETS

Now you can have a group of [GROUP BY]'s in the same query (no exercise):

```SQL
SELECT 
  COUNT(*), code, date 
FROM 
  cleaned.violations  
GROUP BY 
  GROUPING 
    SETS((code), (date))
```

### CUBE

You can have a combination of possible aggregations

```SQL
SELECT 
  COUNT(*), code, date 
FROM 
  cleaned.violations 
GROUP BY 
  CUBE(
    license_number, code, date
  );
```


### ROLLUP
This needs Hierarchy among features ....hmmm Columns! Know more about [Rollup and DrillDowns]:https://www.inertia7.com/projects/5#rollupoper


```SQL
SELECT 
		* 
FROM 
	cleaned.violations 
SELECT
    EXTRACT (YEAR FROM date) y,
    EXTRACT (MONTH FROM date) M,
    EXTRACT (DAY FROM date) d,
    COUNT (code)
FROM
    cleaned.violations
GROUP BY
    ROLLUP (
        EXTRACT (YEAR FROM date),
        EXTRACT (MONTH FROM date),
        EXTRACT (DAY FROM date)
    );

```

**Don't forget to push your file !!!!**

Next step, SQL Advanced