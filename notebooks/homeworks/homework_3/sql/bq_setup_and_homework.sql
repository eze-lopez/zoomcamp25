------------------------------------------------------------------------------------
--BigQuery SETUP
------------------------------------------------------------------------------------
-- Creating external table referring to gcs path
CREATE OR REPLACE EXTERNAL TABLE `zoomcamp25.ny_taxi.external_yellow_tripdata`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://zoomcamp25-bucket/yellow_tripdata_2024-*.parquet']
);

-- Check yellow trip data
SELECT * FROM zoomcamp25.ny_taxi.external_yellow_tripdata limit 10;

-- Create a non partitioned table from external table
CREATE OR REPLACE TABLE zoomcamp25.ny_taxi.yellow_tripdata_non_partitioned AS
SELECT * FROM zoomcamp25.ny_taxi.external_yellow_tripdata;

-- Check non_partitioned table 
SELECT * FROM zoomcamp25.ny_taxi.yellow_tripdata_non_partitioned LIMIT 100;

------------------------------------------------------------------------------------
--HOMEWORK
------------------------------------------------------------------------------------
--QUESTION 1
SELECT COUNT(1) AS Q_ROWS --20.332.093
FROM zoomcamp25.ny_taxi.yellow_tripdata_non_partitioned 
LIMIT 100;

--QUESTION 2
----External table --> 0 B
SELECT COUNT(distinct PULocationID) AS Q_ROWS
FROM zoomcamp25.ny_taxi.external_yellow_tripdata 
LIMIT 100;
----non_partitioned Table --> 155.12 MB
SELECT COUNT(distinct PULocationID) AS Q_ROWS
FROM zoomcamp25.ny_taxi.yellow_tripdata_non_partitioned 
LIMIT 100;

--QUESTION 3
----non_partitioned Table
SELECT PULocationID
FROM zoomcamp25.ny_taxi.yellow_tripdata_non_partitioned 
LIMIT 100;

SELECT PULocationID, DOLocationID
FROM zoomcamp25.ny_taxi.yellow_tripdata_non_partitioned 
LIMIT 100;

--QUESTION 4
----non_partitioned Table
SELECT COUNT(1) AS Q_ROWS --8.333
FROM zoomcamp25.ny_taxi.yellow_tripdata_non_partitioned
WHERE fare_amount = 0 
LIMIT 100;

--QUESTION 5
-- Creating a partition and cluster table
CREATE OR REPLACE TABLE zoomcamp25.ny_taxi.yellow_tripdata_partitioned
PARTITION BY DATE(tpep_dropoff_datetime)
CLUSTER BY VendorID AS
SELECT * FROM zoomcamp25.ny_taxi.external_yellow_tripdata;

--QUESTION 6
----non_partitioned Table
--distinct VendorIDs between tpep_dropoff_datetime 2024-03-01 and 2024-03-15 (inclusive)
SELECT distinct VendorID
--FROM zoomcamp25.ny_taxi.yellow_tripdata_non_partitioned --310.24 MB
FROM zoomcamp25.ny_taxi.yellow_tripdata_partitioned --26.84 MB
WHERE tpep_dropoff_datetime >= "2024-03-01" AND tpep_dropoff_datetime < "2024-03-16"
LIMIT 100;

--QUESTION 8
--It is best practice in Big Query to always cluster your data:
-- Always is a big word, I selected False because depends in the specific scenario and use case for table design
-- If I must select a "always" option I would prefer to always partition my table instead cluster only.

--QUESTION 9 (Bonus: Not worth points)
--Write a SELECT count(*) query FROM the materialized table you created. How many bytes does it estimate will be read? Why?
SELECT COUNT(*) AS Q_ROWS -- 0 B
FROM zoomcamp25.ny_taxi.yellow_tripdata_non_partitioned 
LIMIT 100;
--Estimated bytes is 0 B because data is not stored in BigQuery, instead is in GCS (external) and will be scanned once the query is executing.
