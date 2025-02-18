-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

-- Personal Training Queries

-- 1. List all personal training sessions for a specific trainer
-- TODO: Write a query to list all personal training sessions for a specific trainer

--8.1-
SELECT
    pt.session_id,  -- This is the unique ID of the session
    CONCAT(m.first_name, ' ', m.last_name) AS member_name,  -- Get the full name of the member
    pt.session_date,  -- The date of the session
    pt.start_time, 
    pt.end_time 
FROM 
    personal_training_sessions pt  -- Using "pt" as my alias for personal_training_sessions
JOIN 
    staff s ON pt.staff_id = s.staff_id  -- Join with the staff table to find info about the trainers
JOIN 
    members m ON pt.member_id = m.member_id 
WHERE 
    s.first_name = 'Ivy' AND s.last_name = 'Irwin';  -- Only get sessions where the trainer is "Ivy Irwin" 
