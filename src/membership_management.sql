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
SELECT m.member_id, m.first_name, m.last_name, ms.type AS membership_type, ms.start_date AS join_date
FROM members m
JOIN memberships ms ON m.member_id = ms.member_id
WHERE ms.status = 'Active';


--5.2--
SELECT ms.type AS membership_type, 
       AVG(gv.visit_duration) AS avg_visit_duration_minutes
FROM gym_visits gv
JOIN memberships ms ON gv.member_id = ms.member_id
WHERE ms.status = 'Active'
GROUP BY ms.type
ORDER BY membership_type;

--5.3--
SELECT m.member_id, m.first_name, m.last_name, m.email, ms.end_date
FROM members m, memberships ms
WHERE m.member_id = ms.member_id
  AND ms.status = 'Active'
  AND ms.end_date >= CURRENT_DATE
  AND ms.end_date <= CURRENT_DATE + INTERVAL 1 YEAR;

