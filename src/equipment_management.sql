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


--3.1--
-- Find equipment due for maintenance in the next 30 days
SELECT 
    equipment_id,                        -- The unique identifier for each piece of equipment
    name,                                 -- The name of the equipment
    next_maintenance_date                 -- The next scheduled maintenance date
FROM equipment
WHERE next_maintenance_date BETWEEN CURDATE() AND CURDATE() + INTERVAL 30 DAY;  -- Filters dates within the next 30 days

--3.2--
SELECT 
    equipment_type,                     
    COUNT(*) AS count                    
FROM equipment
WHERE in_stock = TRUE                    -- Only include equipment that is in stock
GROUP BY equipment_type;


--3.3--
