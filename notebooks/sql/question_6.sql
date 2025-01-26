--Question 6. Largest tip
--For the passengers picked up in October 2019 in the zone named "East Harlem North" which was 
--the drop off zone that had the largest tip?

--Note: it's tip , not trip
--We need the name of the zone, not the ID.

--Yorkville West
--JFK Airport * CORRECT ANSWER
--East Harlem North
--East Harlem South


WITH RAW_DATA AS (
  SELECT 
    trip."lpep_pickup_datetime" AS PICKUP_DTTM,
    trip."lpep_pickup_datetime"::DATE AS PICKUP_DT,
	  trip."trip_distance" AS TRIP_DISTANCE,
    trip."total_amount" AS TOTAL_AMOUNT,
    trip."tip_amount" AS TIP_AMOUNT,
    trip."PULocationID" AS PICKUP_LOCATION,
    trip."DOLocationID" AS DROPOFF_LOCATION,
    pu_zones."Borough" AS PICKUP_BOROUGH,
    pu_zones."Zone" AS PICKUP_ZONE,
    pu_zones."service_zone" AS PICKUP_SERVICE_ZONE,
    do_zones."Borough" AS DROPOFF_BOROUGH,
    do_zones."Zone" AS DROPOFF_ZONE,
    do_zones."service_zone" AS DROPOFF_SERVICE_ZONE
  FROM public.ny_green_taxi AS trip
  JOIN public.ny_zones AS pu_zones
    ON trip."PULocationID" = pu_zones."LocationID"
  JOIN public.ny_zones AS do_zones
    ON trip."DOLocationID" = do_zones."LocationID"
  WHERE trip."lpep_pickup_datetime" >= '2019-10-01' 
    AND trip."lpep_pickup_datetime" < '2019-11-01'
    AND pu_zones."Zone" = 'East Harlem North'
)
SELECT DROPOFF_ZONE, MAX(TIP_AMOUNT) AS MAX_TIP_AMOUNT
FROM RAW_DATA
GROUP BY DROPOFF_ZONE
ORDER BY MAX_TIP_AMOUNT DESC
LIMIT 1000
