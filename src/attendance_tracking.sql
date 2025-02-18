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

--6.1

INSERT INTO attendance (member_id, location_id, check_in_time)
VALUES (7, 1, DATETIME('now'));  -- Using DATETIME to get the current timestamp

--6.2--
SELECT 
    DATE(a.check_in_time) AS visit_date,  -- Extracts the date of the visit from check-in time
    a.check_in_time,                      
    a.check_out_time                    
FROM attendance a                        
WHERE a.member_id = 5                    -- Filter by member's ID LOOKING FOR MEMBER 5
AND a.check_out_time IS NOT NULL;        -- Ensures that only records with a valid check_out_time are included

--6.3--
SELECT 
    strftime('%w', a.check_in_time) AS day_of_week,  -- Extracts the day of the week as a number (0 for Sunday, 6 for Saturday)
    COUNT(*) AS visit_count                         --This extracts the day of the week from the check_in_time column. The %w gives the format of the day as a number (0 = Sunday, 1 = Monday,
FROM attendance a                                   
GROUP BY day_of_week                                
ORDER BY visit_count DESC                           -- using the function/clause DESC for visit count from high to low
LIMIT 1;                                            -- Limit to the top 1 result (busiest day)


