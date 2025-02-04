--How many rows are there for the Green Taxi data for all CSV files in the year 2020?

--5,327,301
--936,199
--1,734,051 *CORRECT_ANSWER
--1,342,034

SELECT COUNT(1) AS Q_ROWS
FROM `zoomcamp25.ny_taxi.green_tripdata` 
WHERE lpep_pickup_datetime >= "2020-01-01"
  AND lpep_pickup_datetime < "2021-01-01"
LIMIT 1000;
