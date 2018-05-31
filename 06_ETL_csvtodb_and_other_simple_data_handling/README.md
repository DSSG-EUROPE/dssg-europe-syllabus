# CSV to DB

Just link directly to

https://github.com/dssg/hitchhikers-guide/tree/master/curriculum/1_getting_and_keeping_data/csv-to-db


Some things important:

- Use /mnt/Data to get the file instead of curl -O ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/daily/by_year/2016.csv.gz
- Copy it to a folder with your name in that directory and use it;
- `jwalsh_schema` is an example: use your own name instead


## Delivering `answer_file` 

to push to this session `/exercises/[your_name_folder]` (don't forget your name):

- Just before **Step 2:**, take a screenshot with your newly created schema visible in DBeaver
- Send us a file with the first record from the query 

```
  select * from [jwalsh]_schema.[jwalsh]_table limit 5;
``` 

