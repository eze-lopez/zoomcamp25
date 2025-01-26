--Question 3. Trip Segmentation Count
--During the period of October 1st 2019 (inclusive) and November 1st 2019 (exclusive), how many trips, respectively, happened:
  --Up to 1 mile
  --In between 1 (exclusive) and 3 miles (inclusive),
  --In between 3 (exclusive) and 7 miles (inclusive),
  --In between 7 (exclusive) and 10 miles (inclusive),
  --Over 10 miles

--Answers:
--104,802; 197,670; 110,612; 27,831; 35,281
--104,802; 198,924; 109,603; 27,678; 35,189 * CORRECT ANSWER
--104,793; 201,407; 110,612; 27,831; 35,281
--104,793; 202,661; 109,603; 27,678; 35,189
--104,838; 199,013; 109,645; 27,688; 35,202

WITH RAW_DATA AS (
  SELECT 
    lpep_pickup_datetime AS PICKUP_DTTM,
	  lpep_dropoff_datetime AS DROPOFF_DTTM,
	  trip_distance AS TRIP_DISTANCE,
		CASE
			WHEN trip_distance <= 1 THEN '1. Up to 1 mile'
			WHEN trip_distance > 1 AND trip_distance <= 3 THEN '2. In between 1 (exclusive) and 3 miles (inclusive)'
			WHEN trip_distance > 3 AND trip_distance <= 7 THEN '3. In between 3 (exclusive) and 7 miles (inclusive)'
			WHEN trip_distance > 7 AND trip_distance <= 10 THEN '4. In between 7 (exclusive) and 10 miles (inclusive)'
			WHEN trip_distance > 10 THEN '5. Over 10 miles'
  END AS MILES_RANGE
  FROM public.ny_green_taxi
  WHERE lpep_pickup_datetime >= '2019-10-01' 
    AND lpep_dropoff_datetime < '2019-11-01'
)
SELECT MILES_RANGE, COUNT(1) AS Q_ROWS
FROM RAW_DATA
GROUP BY MILES_RANGE 
LIMIT 1000
