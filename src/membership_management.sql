-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

-- Membership Management Queries

-- 1. List all active memberships
-- TODO: Write a query to list all active memberships

-- 2. Calculate the average duration of gym visits for each membership type
-- TODO: Write a query to calculate the average duration of gym visits for each membership type

-- 3. Identify members with expiring memberships this year
-- TODO: Write a query to identify members with expiring memberships this year


--5.1--
SELECT 
    m.member_id, 
    m.first_name, 
    m.last_name, 
    mem.type AS membership_type, 
    mem.start_date AS join_date
FROM 
    members m
JOIN 
    memberships mem ON m.member_id = mem.member_id
WHERE 
    mem.status = 'Active';


--5.2
SELECT 
    mem.type AS membership_type, 
    AVG(strftime('%s', a.check_out_time) - strftime('%s', a.check_in_time)) / 60.0 AS avg_visit_duration_minutes -- Selecting membership type and calculating the average visit duration in minutes by subtracting check-in time from check-out time.
  -- the (strftime etc....) convert the check-in and check-out times to seconds.
-- Subtracting the two gives the duration in seconds, which is then divided by 60 to get the duration in minutes.)

FROM 
    attendance a
JOIN 
    members m ON a.member_id = m.member_id
JOIN 
    memberships mem ON m.member_id = mem.member_id
WHERE 
    a.check_in_time IS NOT NULL AND a.check_out_time IS NOT NULL -- -- NOT NULL is used to make sure the column always has a value – it can’t be left blank. 
-- So, for columns like 'username' or 'email', we’re saying they must always have something filled in.

GROUP BY 
    mem.type;


--5.3
SELECT 
    m.member_id, 
    m.first_name, 
    m.last_name, 
    m.email, 
    mem.end_date
FROM 
    members m
JOIN 
    memberships mem ON m.member_id = mem.member_id
WHERE 
    mem.end_date BETWEEN date('now') AND date('now', '+1 year');
