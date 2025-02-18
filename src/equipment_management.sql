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
-- List all equipment with next_maintenance_date in the next 30 days
SELECT 
    equipment_id,                       
    name,                                
    next_maintenance_date                 
FROM equipment
WHERE next_maintenance_date BETWEEN DATE('now') AND DATE('now', '+30 days');  -- Filters dates within the next 30 days
