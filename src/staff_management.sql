-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

-- Staff Management Queries

-- 1. List all staff members by role
-- TODO: Write a query to list all staff members by role

-- 2. Find trainers with one or more personal training session in the next 30 days
-- TODO: Write a query to find trainers with one or more personal training session in the next 30 days

--7,1--
-- Select the columns we want to see: staff ID, first name, last name, and role
SELECT 
    staff_id,  -- The unique ID for each staff member
    first_name,  -- The staff member's first name
    last_name,  -- The staff member's last name
    role  -- The role of the staff member (e.g., trainer, manager, etc.)
FROM 
    staff;  -- We're querying from the staff table

--7.2--
SELECT 
    t.trainer_id, 
    CONCAT(t.first_name, ' ', t.last_name) AS trainer_name, 
    COUNT(s.session_id) AS session_count
FROM 
    trainers t
JOIN 
    sessions s ON t.trainer_id = s.trainer_id
WHERE 
    s.session_date BETWEEN CURDATE() AND CURDATE() + INTERVAL 30 DAY
GROUP BY 
    t.trainer_id
ORDER BY 
    session_count DESC;
