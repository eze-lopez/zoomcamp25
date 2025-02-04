--Question 5. Three biggest pickup zones
--Which were the top pickup locations with over 13,000 in total_amount (across all trips) for 2019-10-18?
--Consider only lpep_pickup_datetime when filtering by date.

--East Harlem North, East Harlem South, Morningside Heights * CORRECT ANSWER
--East Harlem North, Morningside Heights
--Morningside Heights, Astoria Park, East Harlem South
--Bedford, East Harlem North, Astoria Park


WITH RAW_DATA AS (
  SELECT 
    trip."lpep_pickup_datetime" AS PICKUP_DTTM,
    trip."lpep_pickup_datetime"::DATE AS PICKUP_DT,
	  trip."trip_distance" AS TRIP_DISTANCE,
    trip."total_amount" AS TOTAL_AMOUNT,
    trip."PULocationID" AS PICKUP_LOCATION,
    trip."DOLocationID" AS DROPOFF_LOCATION,
    zones."Borough" AS PICKUP_BOROUGH,
    zones."Zone" AS PICKUP_ZONE,
    zones."service_zone" AS PICKUP_SERVICE_ZONE
  FROM public.ny_green_taxi AS trip
  JOIN public.ny_zones AS zones
    ON trip."PULocationID" = zones."LocationID"
  WHERE trip."lpep_pickup_datetime" >= '2019-10-18' 
    AND trip."lpep_pickup_datetime" < '2019-10-19'
)
SELECT PICKUP_ZONE, SUM(TOTAL_AMOUNT) AS SUM_TOTAL_AMOUNT
FROM RAW_DATA
GROUP BY PICKUP_ZONE
HAVING SUM(TOTAL_AMOUNT) > 13000
ORDER BY SUM_TOTAL_AMOUNT DESC 
LIMIT 1000
