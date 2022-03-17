USE DATABASE "YELP";
USE SCHEMA "YELP"."STAGE";

CREATE OR REPLACE FILE FORMAT sf_tut_csv_format
    FIELD_DELIMITER = NONE
    RECORD_DELIMITER = '\\n';

CREATE OR REPLACE TEMPORARY STAGE sf_tut_stage
    FILE_FORMAT = sf_tut_csv_format;

PUT file:///Users/minwoong.cho/Jo/dev/udacity/data_archtect/projects/weather_affects_restaurant/udacity-data-architect-yelp-weather/data/yelp_dataset/yelp_academic_dataset_tip.json @sf_tut_stage;

COPY INTO yelp_tip(user_id, business_id, text, timestamp, compliment_count)
    FROM (SELECT parse_json($1):user_id,
                 parse_json($1):business_id,
                 parse_json($1):text,
                 to_timestamp_ntz(parse_json($1):date),
                 parse_json($1):compliment_count
          FROM @sf_tut_stage/yelp_academic_dataset_tip.json.gz t)
    ON_ERROR = 'continue';
