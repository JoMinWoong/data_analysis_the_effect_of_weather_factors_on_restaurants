# How Weather affects Restaurant Ratings

## Overview
In this project scenario, students will use actual YELP and climate datasets in order to analyze the effects the weather has on customer reviews of restaurants. The data for temperature and precipitation observations are from the Global Historical Climatology Network-Daily (GHCN-D) database. Students will use a leading industry cloud-native data warehouse system called Snowflake for all aspects of the project.

## Description of screenshots needed for submission
### 1. Screenshot of 6 tables created upon upload of YELP data
diagram/stage_yelp_tables.png
### 2. Screenshot of 2 tables created upon upload of climate data
diagram/stage_climates_tables.png
### 3. SQL queries code that transforms staging to ODS_SCHEMA. (include all queries)
stage/*.sql
### 4. SQL queries code that specifically uses JSON functions to transform data from a single JSON structure of staging to multiple columns of ODS_SCHEMA. (can be similar to #3, but must include JSON functions)
stage/*.sql
### 5. Screenshot of the table with three columns: raw files, staging, and ODS_SCHEMA. (and sizes)
diagram/ods_tables.png
### 6. SQL queries code to integrate climate and Yelp data
ods/ods_ingest_from_stage.sql
### 7. SQL queries code necessary to move the data from ODS_SCHEMA to DWH_SCHEMA.
ods/*.sql
### 8. SQL queries code that reports the business name, temperature, precipitation, and ratings.
query/report_query.sql

## Reference
https://docs.snowflake.com/en/user-guide/script-data-load-transform-json.html
https://docs.snowflake.com/en/user-guide/data-load-internal-tutorial.html
