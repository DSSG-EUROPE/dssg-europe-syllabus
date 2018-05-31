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

----
Answers will be available...