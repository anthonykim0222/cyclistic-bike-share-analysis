-- Cyclistic Bike-Share Analysis
-- Data Cleaning and Transformation
-- Analysis period: August 2025 - July 2026

CREATE OR REPLACE TABLE
  `cyclistic-capstone-506713.cyclistic.cyclistic_clean` AS

WITH combined_data AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY ride_id
            ORDER BY _TABLE_SUFFIX
        ) AS row_num
    FROM
        `cyclistic-capstone-506713.cyclistic.trips_*`
),

cleaned_data AS (
    SELECT
        * EXCEPT(row_num),

        -- Create ride duration variables
        TIMESTAMP_DIFF(ended_at, started_at, SECOND) AS ride_length_seconds,
        TIMESTAMP_DIFF(ended_at, started_at, SECOND) / 60.0
            AS ride_length_minutes,

        -- Create variables used for time-based analysis
        EXTRACT(DAYOFWEEK FROM started_at) AS day_of_week,
        EXTRACT(MONTH FROM started_at) AS month,
        EXTRACT(HOUR FROM started_at) AS hour_of_day

    FROM combined_data

    -- Keep only one copy of each ride ID
    WHERE row_num = 1

      -- Remove rides with invalid timestamps
      AND ended_at > started_at
)

SELECT *
FROM cleaned_data;

-- Verify final row count
SELECT
    COUNT(*) AS cleaned_total_rides
FROM
    `cyclistic-capstone-506713.cyclistic.cyclistic_clean`;


-- Verify that duplicate ride IDs were removed
SELECT
    ride_id,
    COUNT(*) AS occurrences
FROM
    `cyclistic-capstone-506713.cyclistic.cyclistic_clean`
GROUP BY
    ride_id
HAVING
    COUNT(*) > 1;


-- Verify that invalid timestamps were removed
SELECT
    COUNT(*) AS invalid_timestamp_records
FROM
    `cyclistic-capstone-506713.cyclistic.cyclistic_clean`
WHERE
    ended_at <= started_at;
