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
-- 7.1 --
SELECT 
    s.staff_id,        -- The unique ID for each staff member
    s.first_name,      -- The staff member's first name
    s.last_name,       -- The staff member's last name
    s.role             -- The role of the staff member (e.g., trainer, manager, etc.)
FROM 
    staff s;           -- Querying from the staff table, aliased as 's'


--7.2--
-- 7.2 --
SELECT 
    t.trainer_id, 
    t.first_name || ' ' || t.last_name AS trainer_name,  -- Concatenating first and last name
    COUNT(s.session_id) AS session_count
FROM 
    trainers t
JOIN 
    sessions s ON t.trainer_id = s.trainer_id
WHERE 
    s.session_date BETWEEN CURDATE() AND DATE(CURDATE(), '+30 day')
GROUP BY 
    t.trainer_id
HAVING 
    session_count > 0
ORDER BY 
    session_count DESC;
