USE DATABASE "YELP";
USE SCHEMA "YELP"."STAGE";

create or replace file format mycsvformat
  type = 'CSV'
  field_delimiter = ','
  skip_header = 1;

create or replace stage my_csv_stage
  file_format = mycsvformat;

CREATE OR REPLACE FILE FORMAT sf_tut_csv_format
    FIELD_DELIMITER = NONE
    RECORD_DELIMITER = '\\n';

PUT file:///Users/minwoong.cho/Jo/dev/udacity/data_archtect/projects/weather_affects_restaurant/udacity-data-architect-yelp-weather/data/weather/USW00023169-LAS_VEGAS_MCCARRAN_INTL_AP-precipitation-inch.csv @my_csv_stage auto_compress=true;

COPY INTO precipitation
  FROM @my_csv_stage/USW00023169-LAS_VEGAS_MCCARRAN_INTL_AP-precipitation-inch.csv.gz
  file_format = (format_name = mycsvformat)
  on_error = 'skip_file';