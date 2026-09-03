-- Cyclistic Bike-Share Analysis
-- Analysis Queries
-- Analysis period: August 2025 - July 2026


-- 1. Average and median ride duration by rider type

SELECT
    member_casual,
    AVG(ride_length_minutes) AS avg_ride_length_minutes,
    APPROX_QUANTILES(ride_length_minutes, 2)[OFFSET(1)]
        AS median_ride_length_minutes
FROM
    `cyclistic-capstone-506713.cyclistic.cyclistic_clean`
GROUP BY
    member_casual
ORDER BY
    member_casual;


-- 2. Number of rides by day of week

SELECT
    member_casual,
    day_of_week,
    CASE day_of_week
        WHEN 1 THEN 'Sunday'
        WHEN 2 THEN 'Monday'
        WHEN 3 THEN 'Tuesday'
        WHEN 4 THEN 'Wednesday'
        WHEN 5 THEN 'Thursday'
        WHEN 6 THEN 'Friday'
        WHEN 7 THEN 'Saturday'
    END AS day_name,
    COUNT(*) AS number_of_rides
FROM
    `cyclistic-capstone-506713.cyclistic.cyclistic_clean`
GROUP BY
    member_casual,
    day_of_week,
    day_name
ORDER BY
    day_of_week,
    member_casual;


-- 3. Weekday vs weekend ride share

SELECT
    member_casual,
    CASE
        WHEN day_of_week IN (1, 7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    COUNT(*) AS number_of_rides,
    ROUND(
        COUNT(*) * 100.0
        / SUM(COUNT(*)) OVER (PARTITION BY member_casual),
        2
    ) AS percentage_of_rider_type
FROM
    `cyclistic-capstone-506713.cyclistic.cyclistic_clean`
GROUP BY
    member_casual,
    day_type
ORDER BY
    member_casual,
    day_type;


-- 4. Average ride duration by day of week

SELECT
    member_casual,
    day_of_week,
    CASE day_of_week
        WHEN 1 THEN 'Sunday'
        WHEN 2 THEN 'Monday'
        WHEN 3 THEN 'Tuesday'
        WHEN 4 THEN 'Wednesday'
        WHEN 5 THEN 'Thursday'
        WHEN 6 THEN 'Friday'
        WHEN 7 THEN 'Saturday'
    END AS day_name,
    AVG(ride_length_minutes) AS avg_ride_length_minutes
FROM
    `cyclistic-capstone-506713.cyclistic.cyclistic_clean`
GROUP BY
    member_casual,
    day_of_week,
    day_name
ORDER BY
    day_of_week,
    member_casual;


-- 5. Ride volume by hour of day

SELECT
    member_casual,
    hour_of_day,
    COUNT(*) AS number_of_rides
FROM
    `cyclistic-capstone-506713.cyclistic.cyclistic_clean`
GROUP BY
    member_casual,
    hour_of_day
ORDER BY
    hour_of_day,
    member_casual;


-- 6. Weekday ride volume by hour of day

SELECT
    member_casual,
    hour_of_day,
    COUNT(*) AS number_of_rides
FROM
    `cyclistic-capstone-506713.cyclistic.cyclistic_clean`
WHERE
    day_of_week BETWEEN 2 AND 6
GROUP BY
    member_casual,
    hour_of_day
ORDER BY
    hour_of_day,
    member_casual;


-- 7. Monthly ridership

SELECT
    member_casual,
    month,
    COUNT(*) AS number_of_rides
FROM
    `cyclistic-capstone-506713.cyclistic.cyclistic_clean`
GROUP BY
    member_casual,
    month
ORDER BY
    month,
    member_casual;


-- 8. Bike type preference

SELECT
    member_casual,
    rideable_type,
    COUNT(*) AS number_of_rides,
    ROUND(
        COUNT(*) * 100.0
        / SUM(COUNT(*)) OVER (PARTITION BY member_casual),
        2
    ) AS percentage_of_rider_type
FROM
    `cyclistic-capstone-506713.cyclistic.cyclistic_clean`
GROUP BY
    member_casual,
    rideable_type
ORDER BY
    member_casual,
    rideable_type;
