# CSV to DB

Follow the tutorial directly at this link:

https://github.com/dssg/hitchhikers-guide/tree/master/curriculum/1_getting_and_keeping_data/csv-to-db

Some important things to note:


Some things important:

- Get the `2016.csv` file on the instance at `/mnt/data`instead of `curl -O 
- Copy it to a folder with your name in that directory and use it;
- `jwalsh_schema` and `jwalsh_table` are example names: use your own name instead


## Delivering `answers.md` 

to push to this session `/exercises/[your_name_folder]/answers.md` (don't forget your name):

- Just before **Step 2:**, take a screenshot with your newly created schema visible in DBeaver
- Send us a file with the first record from the query 

```
  select * from [jwalsh]_schema.[jwalsh]_table limit 5;
``` 

