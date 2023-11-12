USE DATABASE "YELP";
USE SCHEMA "YELP"."DWH_SCHEMA";

-- report business name, temperature, precipitation, ratings
SELECT fr.business_id,
       fr.date,
       db.name,
       AVG(fr.stars)    as ratinngs,
       dt.temperature,
       dp.precipitation as precipitation
FROM FACT_REVIEW AS fr
         LEFT JOIN DIM_BUSINESS AS db ON fr.business_id = db.business_id
         LEFT JOIN (SELECT idt.date, AVG((idt.temp_min + idt.temp_max) / 2) AS temperature
                    FROM dim_temperature as idt
                    GROUP BY idt.date) AS dt ON fr.date = dt.date
         LEFT JOIN DIM_PRECIPITATION AS dp ON fr.date = dp.date
GROUP BY fr.business_id, db.name, fr.date, dt.temperature, dp.precipitation;
