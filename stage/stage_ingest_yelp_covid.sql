CREATE OR REPLACE FILE FORMAT sf_tut_csv_format
    FIELD_DELIMITER = NONE
    RECORD_DELIMITER = '\\n';

CREATE OR REPLACE TEMPORARY STAGE sf_tut_stage
    FILE_FORMAT = sf_tut_csv_format;

PUT file:///Users/minwoong.cho/Jo/dev/udacity/data_archtect/projects/weather_affects_restaurant/udacity-data-architect-yelp-weather/data/covid_19_dataset_2020_06_10/yelp_academic_dataset_covid_features.json;

COPY INTO yelp_covid(business_id, highlights, delivery_or_takeout, grubhub_enabled, call_to_action_enabled,
                     request_a_quote_enabled, covid_banner, temporary_closed_until, virtual_services_offered)
    FROM (SELECT parse_json($1):business_id,
                 parse_json($1):highlights,
                 parse_json($1):delivery_or_takeout,
                 parse_json($1):Grubhub_enabled,
                 parse_json($1):Call_To_Action_enabled,
                 parse_json($1):Request_a_Quote_Enabled,
                 parse_json($1):Covid_Banner,
                 parse_json($1):Temporary_Closed_Until,
                 parse_json($1):Virtual_Services_Offered
          FROM @sf_tut_stage/yelp_academic_dataset_covid_features.json.gz t)
    ON_ERROR = 'continue';
