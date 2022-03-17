USE DATABASE "YELP";
USE SCHEMA "YELP"."STAGE";

CREATE OR REPLACE FILE FORMAT sf_tut_csv_format
    FIELD_DELIMITER = NONE
    RECORD_DELIMITER = '\\n';

CREATE OR REPLACE TEMPORARY STAGE sf_tut_stage
    FILE_FORMAT = sf_tut_csv_format;

PUT file:///Users/minwoong.cho/Jo/dev/udacity/data_archtect/projects/weather_affects_restaurant/udacity-data-architect-yelp-weather/data/yelp_dataset/yelp_academic_dataset_business.json @sf_tut_stage;

COPY INTO yelp_business(business_id, name, address, city, state, postal_code, latitude, longitude, stars,
                        review_count, is_open, attributes_NoiseLevel, attributes_BikeParking, attributes_RestaurantsAttire,
                        attributes_BusinessAcceptsCreditCards, attributes_BusinessParking, attributes_RestaurantsReservations,
                        attributes_GoodForKids, attributes_RestaurantsTakeOut, attributes_Caters, attributes_WiFi,
                        attributes_RestaurantsDelivery, attributes_HasTV, attributes_RestaurantsPriceRange2, attributes_Alcohol,
                        attributes_Music, attributes_BusinessAcceptsBitcoin, attributes_GoodForDancing, attributes_DogsAllowed,
                        attributes_BestNights, attributes_RestaurantsGoodForGroups, attributes_OutdoorSeating,
                        attributes_HappyHour, attributes_RestaurantsTableService, attributes_GoodForMeal,
                        attributes_WheelchairAccessible, attributes_Ambience, attributes_CoatCheck, attributes_DriveThru,
                        attributes_Smoking, attributes_BYOB, attributes_Corkage, categories,
                        hours_Monday, hours_Tuesday, hours_Wednesday, hours_Thursday, hours_Friday, hours_Saturday, hours_Sunday)
    FROM (SELECT parse_json($1):business_id,
                 parse_json($1):name,
                 parse_json($1):address,
                 parse_json($1):city,
                 parse_json($1):state,
                 parse_json($1):postal_code,
                 parse_json($1):latitude,
                 parse_json($1):longitude,
                 parse_json($1):stars,
                 parse_json($1):review_count,
                 parse_json($1):is_open,
                 parse_json($1):attributes.NoiseLevel,
                 parse_json($1):attributes.BikeParking,
                 parse_json($1):attributes.RestaurantsAttire,
                 parse_json($1):attributes.BusinessAcceptsCreditCards,
                 parse_json($1):attributes.BusinessParking,
                 parse_json($1):attributes.RestaurantsReservations,
                 parse_json($1):attributes.GoodForKids,
                 parse_json($1):attributes.RestaurantsTakeOut,
                 parse_json($1):attributes.Caters,
                 parse_json($1):attributes.WiFi,
                 parse_json($1):attributes.RestaurantsDelivery,
                 parse_json($1):attributes.HasTV,
                 parse_json($1):attributes.RestaurantsPriceRange2,
                 parse_json($1):attributes.Alcohol,
                 parse_json($1):attributes.Music,
                 parse_json($1):attributes.BusinessAcceptsBitcoin,
                 parse_json($1):attributes.GoodForDancing,
                 parse_json($1):attributes.DogsAllowed,
                 parse_json($1):attributes.BestNights,
                 parse_json($1):attributes.RestaurantsGoodForGroups,
                 parse_json($1):attributes.OutdoorSeating,
                 parse_json($1):attributes.HappyHour,
                 parse_json($1):attributes.RestaurantsTableService,
                 parse_json($1):attributes.GoodForMeal,
                 parse_json($1):attributes.WheelchairAccessible,
                 parse_json($1):attributes.Ambience,
                 parse_json($1):attributes.CoatCheck,
                 parse_json($1):attributes.DriveThru,
                 parse_json($1):attributes.Smoking,
                 parse_json($1):attributes.BYOB,
                 parse_json($1):attributes.Corkage,
                 parse_json($1):categories,
                 parse_json($1):hours.Monday,
                 parse_json($1):hours.Tuesday,
                 parse_json($1):hours.Wednesday,
                 parse_json($1):hours.Thursday,
                 parse_json($1):hours.Friday,
                 parse_json($1):hours.Saturday,
                 parse_json($1):hours.Sunday 
          FROM @sf_tut_stage/yelp_academic_dataset_business.json.gz t)
    ON_ERROR = 'continue';