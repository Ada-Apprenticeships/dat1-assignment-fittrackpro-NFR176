-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

-- Attendance Tracking Queries

-- 1. Record a member's gym visit
-- TODO: Write a query to record a member's gym visit

-- 2. Retrieve a member's attendance history
-- TODO: Write a query to retrieve a member's attendance history

-- 3. Find the busiest day of the week based on gym visits
-- TODO: Write a query to find the busiest day of the week based on gym visits

-- 4. Calculate the average daily attendance for each location
-- TODO: Write a query to calculate the average daily attendance for each location

--6.1--
INSERT INTO attendance (member_id, location_id, check_in_time)
VALUES (7, 1, NOW());



--6.2--
-- Retrieve attendance history for member with ID 5
SELECT 
    visit_date,           -- Date of the gym visit
    check_in_time,        -- Time when the member checked in
    check_out_time       -- Time when the member checked out
FROM attendance         -- Table where attendance records are stored
WHERE member_id = 5;    -- Filter by member's ID (ID 5 in this case)


--6.3--
-- Find the busiest day of the week based on gym visits
SELECT 
    DAYNAME(visit_date) AS day_of_week,    -- Extracts the day name (e.g., "Sunday", "Monday", etc.)
    COUNT(*) AS visit_count                 -- Counts the number of visits for each day
FROM attendance                              -- Table where attendance records are stored
GROUP BY day_of_week                        -- Group by the name of the day
ORDER BY visit_count DESC                    -- Orders by the visit count in descending order
LIMIT 1;                                     -- Limit to the top 1 result (busiest day)




--6.4--
-- Calculate the average daily attendance for each location
SELECT 
    location_name,                           -- Location name
    AVG(daily_visits) AS avg_daily_attendance -- Average of daily visits
FROM (
    SELECT 
        location_name, 
        DATE(visit_date) AS visit_day,       -- Grouping by each day
        COUNT(*) AS daily_visits             -- Count the number of visits for that day
    FROM attendance 
    JOIN locations ON attendance.location_id = locations.location_id
    GROUP BY location_name, visit_day       -- Group by location and day
) AS daily_counts
GROUP BY location_name;                    -- Final grouping by location for average

