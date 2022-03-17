USE DATABASE "YELP";
CREATE SCHEMA IF NOT EXISTS "YELP"."STAGE";
USE SCHEMA "YELP"."STAGE";

CREATE OR REPLACE TABLE precipitation (
    date DATE,
    precipitation FLOAT,
    precipitation_normal FLOAT
);


CREATE OR REPLACE TABLE temperature (
    date DATE,
    min FLOAT,
    max FLOAT,
    normal_min FLOAT,
    normal_max FLOAT
);


CREATE OR REPLACE TABLE yelp_business (
    business_id TEXT,
    name TEXT,
    address TEXT,
    city TEXT,
    state TEXT,
    postal_code INT,
    latitude FLOAT,
    longitude FLOAT,
    stars NUMERIC(3,2),
    review_count INT,
    is_open INT,
    attributes_NoiseLevel TEXT,
    attributes_BikeParking BOOLEAN,
    attributes_RestaurantsAttire TEXT,
    attributes_BusinessAcceptsCreditCards BOOLEAN,
    attributes_BusinessParking TEXT,
    attributes_RestaurantsReservations TEXT,
    attributes_GoodForKids BOOLEAN,
    attributes_RestaurantsTakeOut BOOLEAN,
    attributes_Caters BOOLEAN,
    attributes_WiFi TEXT,
    attributes_RestaurantsDelivery BOOLEAN,
    attributes_HasTV BOOLEAN,
    attributes_RestaurantsPriceRange2 INT,
    attributes_Alcohol TEXT,
    attributes_Music TEXT,
    attributes_BusinessAcceptsBitcoin BOOLEAN,
    attributes_GoodForDancing BOOLEAN,
    attributes_DogsAllowed BOOLEAN,
    attributes_BestNights TEXT,
    attributes_RestaurantsGoodForGroups BOOLEAN,
    attributes_OutdoorSeating BOOLEAN,
    attributes_HappyHour BOOLEAN,
    attributes_RestaurantsTableService BOOLEAN,
    attributes_GoodForMeal TEXT,
    attributes_WheelchairAccessible BOOLEAN,
    attributes_Ambience TEXT,
    attributes_CoatCheck BOOLEAN,
    attributes_DriveThru BOOLEAN,
    attributes_Smoking TEXT,
    attributes_BYOB BOOLEAN,
    attributes_Corkage BOOLEAN,
    categories TEXT,
    hours_Monday TEXT,
    hours_Tuesday TEXT,
    hours_Wednesday TEXT,
    hours_Thursday TEXT,
    hours_Friday TEXT,
    hours_Saturday TEXT,
    hours_Sunday TEXT
);



CREATE OR REPLACE TABLE yelp_checkin (
    business_id TEXT,
    date TEXT
);


CREATE OR REPLACE TABLE yelp_covid (
    business_id TEXT,
    highlights TEXT,
    delivery_or_takeout TEXT,
    grubhub_enabled TEXT,
    call_to_action_enabled TEXT,
    request_a_quote_enabled TEXT,
    covid_banner TEXT,
    temporary_closed_until TEXT,
    virtual_services_offered TEXT
);


CREATE OR REPLACE TABLE yelp_review (
    review_id TEXT,
    user_id TEXT,
    business_id TEXT,
    stars NUMERIC(3,2),
    useful INT,
    funny INT,
    cool INT,
    text TEXT,
    timestamp DATETIME
);


CREATE OR REPLACE TABLE yelp_tip (
    user_id TEXT,
    business_id TEXT,
    text TEXT,
    timestamp DATETIME,
    compliment_count INT
);



CREATE OR REPLACE TABLE yelp_user (
    user_id TEXT,
    name TEXT,
    review_count INT,
    yelping_since DATETIME,
    useful INT,
    funny INT,
    cool INT,
    elite TEXT,
    friends TEXT,
    fans INT,
    average_stars NUMERIC(3,2),
    compliment_hot INT,
    compliment_more INT,
    compliment_profile INT,
    compliment_cute INT,
    compliment_list INT,
    compliment_note INT,
    compliment_plain INT,
    compliment_cool INT,
    compliment_funny INT,
    compliment_writer INT,
    compliment_photos INT
);