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

SELECT 
    s.staff_id,        -- The unique ID for each staff member
    s.first_name,     --the s. is my alias for staff table--
    s.last_name,       
    s.position         
FROM 
    staff s;           



--7.2--
SELECT 
    s.staff_id,                                     
    s.first_name || ' ' || s.last_name AS trainer_name, -- Concatenating first and last name to get the trainer's full name
    COUNT(pts.session_id) AS session_count           
FROM 
    staff s                                           
JOIN 
    personal_training_sessions pts                
    ON s.staff_id = pts.staff_id                    
WHERE 
    s.position = 'Trainer'                            -- We only want to get trainers
    AND pts.session_date BETWEEN date('now') AND date('now', '+30 days')  -- Session date is within the next 30 days
GROUP BY 
    s.staff_id                                       
HAVING 
    session_count > 0                                
ORDER BY 
    session_count DESC;                               --  DESC-- Ordering by session count in descending order
