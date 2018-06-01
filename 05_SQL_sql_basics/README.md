# SQL Basics
This tutorial is a starting point for SQL, we go fast at the beginning but if you are confused have a look at this link for further information:

```
http://www.postgresqltutorial.com/
``` 



### SQL: Data Definition Language (DDL) and Data Manipulation Language (DML)
SQL is used for database administration, and manipulation. DDL is used to define/configure your database. Database administration is done using DDL, for example creating schemas, tables, adding users, or adding an index.

For more information and examples see 

```
http://www.postgresqltutorial.com/postgresql-administration/
``` 

DML is probably where most of your time will be spent, actually working with data. For example, creating new columns, and cleaning data. 

Create a file with your name, For each of the questions below, create a query.

This answers file will be submitted at the end of the session, to this repo: 

`dssg-europe-syllabus/04_SQL_sql_basics/exercises/[your_name_folder]`

### Database Scenario: The food inspections data set

The data represents the inspections made in different facilities in the area of Chicago.

There are different types of inspections, different types of facilities and different results (or outcomes) of that inspections. Also the data contains the types of violations and text descriptions in free form about the violations.

Obviously, we have spatio-temporal data (i.e. the inspections happen in a given time at some place).

Take five minutes to get familiar with the data in the `Cleaned` Schema, explore the following questions.

```
  How many tables are there?
  Which are the respective columns?
  How many rows per table?
  Any idea about how to join them?
```


### SELECT, ORDER BY, LIMIT and OFFSET

**1. Select the last 10 violations and order by date**


### WHERE 

**2. Count the violations with code 34 that have happened this year**


### DISTINCT

**3. How many unique violation codes are there?**


### INNER, LEFT, RIGHT JOIN, FULL OUTER JOIN

**4. Can you join the inspection to the corresponding violation for the day of "2018-05-25"?**

**5. Is there any violation without a record of inspection?**


### GROUP BY, HAVING

Ok, lets aggregate rows that have the same characteristics. For instance, 

**6. Get a list of the number of violations by code.

**7. Get a list of the number of violations by type, for this year, and for codes below 15**

----
Answers will be available...
