-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

-- Personal Training Queries

-- 1. List all personal training sessions for a specific trainer
-- TODO: Write a query to list all personal training sessions for a specific trainer

--8.1--
-- Select the columns we want to see: session ID, member name, session date, start time, and end time
SELECT 
    pts.session_id,  -- This is the unique ID of the session
    CONCAT(m.first_name, ' ', m.last_name) AS member_name,  -- Combines the member's first and last name into one column
    pts.session_date,  -- The date when the session happens
    pts.start_time,  -- The time when the session starts
    pts.end_time  -- The time when the session ends
FROM 
    personal_training_sessions pts  -- We're working with the personal_training_sessions table (sessions)
JOIN 
    staff s ON pts.staff_id = s.staff_id  -- Join with the staff table so we can get trainer information
JOIN 
    members m ON pts.member_id = m.member_id  -- Join with the members table to get member names
WHERE 
    s.first_name = 'Ivy' AND s.last_name = 'Irwin';  -- Only get sessions where the trainer is "Ivy Irwin"
