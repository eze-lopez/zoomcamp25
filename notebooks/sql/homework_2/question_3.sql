--How many rows are there for the Yellow Taxi data for all CSV files in the year 2020?
--13,537.299
--24,648,499 * CORRECT ANSWER
--18,324,219
--29,430,127

SELECT COUNT(1) AS Q_ROWS
FROM `zoomcamp25.ny_taxi.yellow_tripdata` 
WHERE tpep_pickup_datetime >= "2020-01-01"
  AND tpep_pickup_datetime < "2021-01-01"
LIMIT 1000;
