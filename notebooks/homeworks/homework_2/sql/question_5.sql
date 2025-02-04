--How many rows are there for the Yellow Taxi data for the March 2021 CSV file?

--1,428,092
--706,911
--1,925,152 *CORRECT_ANSWER
--2,561,031

SELECT COUNT(1) AS Q_ROWS
FROM `zoomcamp25.ny_taxi.yellow_tripdata` 
WHERE tpep_pickup_datetime >= "2021-03-01"
  AND tpep_pickup_datetime < "2021-04-01"
LIMIT 1000;
