--Question 4. Longest trip for each day
--Which was the pick up day with the longest trip distance? Use the pick up time for your calculations.
--Tip: For every day, we only care about one single trip with the longest distance.

--2019-10-11
--2019-10-24
--2019-10-26
--2019-10-31 * CORRECT ANSWER


WITH RAW_DATA AS (
  SELECT 
    lpep_pickup_datetime AS PICKUP_DTTM,
	  trip_distance AS TRIP_DISTANCE,
    lpep_pickup_datetime::DATE AS DS
  FROM public.ny_green_taxi
)
SELECT DS, MAX(trip_distance) AS MAX_TRIP_DISTANCE
FROM RAW_DATA 
GROUP BY DS
ORDER BY MAX_TRIP_DISTANCE DESC
LIMIT 1
