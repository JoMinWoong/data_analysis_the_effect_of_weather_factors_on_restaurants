USE DATABASE "YELP";
USE SCHEMA "YELP"."STAGE";

CREATE OR REPLACE FILE FORMAT sf_tut_csv_format FIELD_DELIMITER = NONE
    RECORD_DELIMITER = '\\n';

CREATE OR REPLACE TEMPORARY STAGE sf_tut_stage
    FILE_FORMAT = sf_tut_csv_format;

PUT file:///Users/minwoong.cho/Jo/dev/udacity/data_archtect/projects/weather_affects_restaurant/udacity-data-architect-yelp-weather/data/yelp_dataset/yelp_academic_dataset_user.json @sf_tut_stage;

COPY INTO yelp_user (user_id, name, review_count, yelping_since, useful, funny, cool, elite, friends, fans,
                     average_stars,
                     compliment_hot, compliment_more, compliment_profile, compliment_cute, compliment_list,
                     compliment_note,
                     compliment_plain, compliment_cool, compliment_funny, compliment_writer, compliment_photos)
    FROM (SELECT parse_json($1):user_id,
                 parse_json($1):name,
                 parse_json($1):review_count,
                 to_timestamp_ntz(parse_json($1):yelping_since),
                 parse_json($1):useful,
                 parse_json($1):funny,
                 parse_json($1):cool,
                 parse_json($1):elite,
                 parse_json($1):friends,
                 parse_json($1):fans,
                 parse_json($1):average_stars,
                 parse_json($1):compliment_hot,
                 parse_json($1):compliment_more,
                 parse_json($1):compliment_profile,
                 parse_json($1):compliment_cute,
                 parse_json($1):compliment_list,
                 parse_json($1):compliment_note,
                 parse_json($1):compliment_plain,
                 parse_json($1):compliment_cool,
                 parse_json($1):compliment_funny,
                 parse_json($1):compliment_writer,
                 parse_json($1):compliment_photos
          FROM @sf_tut_stage/yelp_academic_dataset_user.json.gz t)
    ON_ERROR = 'continue';