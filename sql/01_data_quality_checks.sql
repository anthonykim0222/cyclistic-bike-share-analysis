-- Cyclistic Bike-Share Analysis
-- Initial Data Quality Checks
-- Analysis period: August 2025 - July 2026

-- Count total records across the 12 monthly tables
SELECT
    COUNT(*) AS total_rides
FROM
    `cyclistic-capstone-506713.cyclistic.trips_*`;


-- Check for missing station names
SELECT
    COUNTIF(start_station_name IS NULL) AS missing_start_station,
    COUNTIF(end_station_name IS NULL) AS missing_end_station
FROM
    `cyclistic-capstone-506713.cyclistic.trips_*`;


-- Identify duplicate ride IDs
SELECT
    ride_id,
    COUNT(*) AS occurrences
FROM
    `cyclistic-capstone-506713.cyclistic.trips_*`
GROUP BY
    ride_id
HAVING
    COUNT(*) > 1
ORDER BY
    occurrences DESC;


-- Check for rides with invalid timestamps
SELECT
    COUNT(*) AS invalid_rides
FROM
    `cyclistic-capstone-506713.cyclistic.trips_*`
WHERE
    ended_at <= started_at;


-- Examine ride duration range
SELECT
    MIN(TIMESTAMP_DIFF(ended_at, started_at, SECOND)) AS shortest_ride_seconds,
    MAX(TIMESTAMP_DIFF(ended_at, started_at, SECOND)) AS longest_ride_seconds,
    AVG(TIMESTAMP_DIFF(ended_at, started_at, SECOND)) AS avg_ride_seconds
FROM
    `cyclistic-capstone-506713.cyclistic.trips_*`;
