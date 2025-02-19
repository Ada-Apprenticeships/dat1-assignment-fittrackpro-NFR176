-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

-- Equipment Management Queries

-- 1. Find equipment due for maintenance
-- TODO: Write a query to find equipment due for maintenance

-- 2. Count equipment types in stock
-- TODO: Write a query to count equipment types in stock

-- 3. Calculate average age of equipment by type (in days)
-- TODO: Write a query to calculate average age of equipment by type (in days)


--3.1

SELECT 
    equipment_id,                       
    name,                                
    next_maintenance_date                 
FROM equipment
WHERE next_maintenance_date BETWEEN DATE('now') AND DATE('now', '+30 days');  -- Filters dates within the next 30 days

--3.2--

SELECT 
    type AS equipment_type,  -- 'COUNT(*) AS count' counts how many pieces of equipment there are for each type and names it 'count'.
    COUNT(*) AS count                    
FROM equipment
WHERE location_id IS NOT NULL           
GROUP BY type;         

--3.3--
SELECT
    e.type AS equipment_type,  
    AVG( 
        (strftime('%s', 'now') - strftime('%s', e.purchase_date)) / 86400
    ) AS avg_age_days -- The average age in days
    -- '/' divides the difference between the current date and purchase date (in seconds) by 86400 to convert from seconds to days.
FROM
    equipment e  --  'equipment' table, aliased as 'e'
GROUP BY
    e.type;  -- Grouping by equipmeint type to get the average for each type
