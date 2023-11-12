USE
    DATABASE "YELP";
USE
    SCHEMA "YELP"."ODS_SCHEMA";

INSERT INTO location (address, city, state, postal_code, latitude, longitude)
SELECT s_yb.address, s_yb.city, s_yb.state, s_yb.postal_code, s_yb.latitude, s_yb.longitude
FROM STAGE.yelp_business AS s_yb
QUALIFY ROW_NUMBER() OVER (PARTITION BY s_yb.state, s_yb.postal_code, s_yb.city, s_yb.address ORDER BY s_yb.state, s_yb.postal_code, s_yb.city, s_yb.address) =
        1;


INSERT INTO business (business_id, name, location_id, stars, review_count, is_open)
SELECT s_yb.business_id,
       s_yb.name,
       lo.location_id,
       s_yb.stars,
       s_yb.review_count,
       s_yb.is_open
FROM STAGE.yelp_business AS s_yb
         LEFT JOIN location AS lo
                   ON s_yb.address = lo.address AND
                      s_yb.city = lo.city AND
                      s_yb.state = lo.state AND
                      s_yb.postal_code = lo.postal_code
WHERE s_yb.business_id NOT IN (SELECT business_id FROM business);


INSERT INTO table_timestamp (timestamp, date, day, week, month, year)
SELECT s_yu.yelping_since,
       DATE(s_yu.yelping_since),
       DAY(s_yu.yelping_since),
       WEEK(s_yu.yelping_since),
       MONTH(s_yu.yelping_since),
       YEAR(s_yu.yelping_since)
FROM STAGE.yelp_user AS s_yu
WHERE s_yu.yelping_since NOT IN (SELECT timestamp FROM table_timestamp);


INSERT INTO user (user_id, name, review_count, yelping_since, useful, funny, cool, elite, friends,
                  fans, average_stars, compliment_hot, compliment_more, compliment_profile, compliment_cute,
                  compliment_list, compliment_note, compliment_plain, compliment_cool, compliment_funny,
                  compliment_writer, compliment_photos)
SELECT s_yu.user_id,
       s_yu.name,
       s_yu.review_count,
       s_yu.yelping_since,
       s_yu.useful,
       s_yu.funny,
       s_yu.cool,
       s_yu.elite,
       s_yu.friends,
       s_yu.fans,
       s_yu.average_stars,
       s_yu.compliment_hot,
       s_yu.compliment_more,
       s_yu.compliment_profile,
       s_yu.compliment_cute,
       s_yu.compliment_list,
       s_yu.compliment_note,
       s_yu.compliment_plain,
       s_yu.compliment_cool,
       s_yu.compliment_funny,
       s_yu.compliment_writer,
       s_yu.compliment_photos
FROM STAGE.yelp_user AS s_yu
WHERE s_yu.user_id NOT IN (SELECT user_id FROM user);


INSERT INTO table_timestamp (timestamp, date, day, week, month, year)
SELECT s_yt.timestamp,
       DATE(s_yt.timestamp),
       DAY(s_yt.timestamp),
       WEEK(s_yt.timestamp),
       MONTH(s_yt.timestamp),
       YEAR(s_yt.timestamp)
FROM STAGE.yelp_tip AS s_yt
WHERE s_yt.timestamp NOT IN (SELECT timestamp FROM table_timestamp);


INSERT INTO tip (user_id, business_id, text, timestamp, compliment_count)
SELECT s_yt.user_id, s_yt.business_id, s_yt.text, s_yt.timestamp, s_yt.compliment_count
FROM STAGE.yelp_tip AS s_yt;


INSERT INTO checkin (business_id, date)
SELECT yc.business_id, yc.date
FROM STAGE.yelp_checkin AS yc;


INSERT INTO covid (business_id, highlights, delivery_or_takeout, grubhub_enabled,
                   call_to_action_enabled, request_a_quote_enabled, covid_banner,
                   temporary_closed_until, virtual_services_offered)
SELECT yc.business_id,
       yc.highlights,
       yc.delivery_or_takeout,
       yc.grubhub_enabled,
       yc.call_to_action_enabled,
       yc.request_a_quote_enabled,
       yc.covid_banner,
       yc.temporary_closed_until,
       yc.virtual_services_offered
FROM STAGE.yelp_covid AS yc;


INSERT INTO table_timestamp (timestamp, date, day, week, month, year)
SELECT s_yr.timestamp,
       DATE(s_yr.timestamp),
       DAY(s_yr.timestamp),
       WEEK(s_yr.timestamp),
       MONTH(s_yr.timestamp),
       YEAR(s_yr.timestamp)
FROM STAGE.yelp_review AS s_yr
WHERE s_yr.timestamp NOT IN (SELECT timestamp FROM table_timestamp);


INSERT INTO review (review_id, user_id, business_id, stars, useful,
                    funny, cool, text, timestamp)
SELECT s_yr.review_id,
       s_yr.user_id,
       s_yr.business_id,
       s_yr.stars,
       s_yr.useful,
       s_yr.funny,
       s_yr.cool,
       s_yr.text,
       s_yr.timestamp
FROM STAGE.yelp_review AS s_yr
WHERE s_yr.review_id NOT IN (SELECT review_id FROM review);


INSERT INTO table_timestamp (timestamp, date, day, week, month, year)
SELECT s_yr.timestamp,
       DATE(s_yr.timestamp),
       DAY(s_yr.timestamp),
       WEEK(s_yr.timestamp),
       MONTH(s_yr.timestamp),
       YEAR(s_yr.timestamp)
FROM STAGE.yelp_review AS s_yr
WHERE s_yt.timestamp NOT IN (SELECT timestamp FROM table_timestamp);


INSERT INTO temperature (date, temp_min, temp_max, temp_normal_min, temp_normal_max)
SELECT s_t.date, s_t.min, s_t.max, s_t.normal_min, s_t.normal_max
FROM STAGE.temperature AS s_t;


INSERT INTO table_timestamp (timestamp, date, day, week, month, year)
SELECT te.date, DATE(te.date), DAY(te.date), WEEK(te.date), MONTH(te.date), YEAR(te.date)
FROM "YELP"."STAGE"."TEMPERATURE" AS te
WHERE te.date NOT IN (SELECT timestamp FROM table_timestamp);


INSERT INTO precipitation (date, precipitation, precipitation_normal)
SELECT s_p.date, TRY_CAST(s_p.precipitation AS FLOAT), s_p.precipitation_normal
FROM STAGE.precipitation AS s_p;

INSERT INTO table_timestamp (timestamp, date, day, week, month, year)
SELECT pr.date, DATE(pr.date), DAY(pr.date), WEEK(pr.date), MONTH(pr.date), YEAR(pr.date)
FROM "YELP"."STAGE"."PRECIPITATION" AS pr
WHERE pr.date NOT IN (SELECT timestamp FROM table_timestamp);

INSERT INTO table_timestamp (timestamp, date, day, week, month, year)
SELECT s_yt.timestamp,
       DATE(s_yt.timestamp),
       DAY(s_yt.timestamp),
       WEEK(s_yt.timestamp),
       MONTH(s_yt.timestamp),
       YEAR(s_yt.timestamp)
FROM STAGE.yelp_tip AS s_yt
WHERE s_yt.timestamp NOT IN (SELECT timestamp FROM table_timestamp);
