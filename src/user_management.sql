-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

-- User Management Queries

-- 1. Retrieve all members
-- TODO: Write a query to retrieve all members

-- 2. Update a member's contact information
-- TODO: Write a query to update a member's contact information

-- 3. Count total number of members
-- TODO: Write a query to count the total number of members

-- 4. Find member with the most class registrations
-- TODO: Write a query to find the member with the most class registrations

-- 5. Find member with the least class registrations
-- TODO: Write a query to find the member with the least class registrations

-- 6. Calculate the percentage of members who have attended at least one class
-- TODO: Write a query to calculate the percentage of members who have attended at least one class


--1.1--
SELECT m.member_id, m.first_name, m.last_name, m.email, m.join_date
FROM members m;

--1.2--
UPDATE members
SET phone_number = '555-9876', email = 'emily.jones.updated@email.com'
WHERE member_id = 5;

--1.3--
SELECT COUNT(*) total_members FROM members;

--1.4--
SELECT m.member_id, m.first_name, m.last_name, COUNT(*) AS registration_count
FROM members m, class_attendance ca
WHERE m.member_id = ca.member_id
  AND ca.attendance_status = 'Registered'
GROUP BY m.member_id
ORDER BY registration_count DESC
LIMIT 1;

--1.5--
SELECT m.member_id, m.first_name, m.last_name, COUNT(*) AS registration_count
FROM members m, class_attendance ca
WHERE m.member_id = ca.member_id
  AND ca.attendance_status = 'Registered'
GROUP BY m.member_id
ORDER BY registration_count ASC
LIMIT 1;


--1.6--
SELECT 
    (COUNT(DISTINCT a.member_id) * 100.0 / (SELECT COUNT(*) FROM members)) AS attendance_percentage
FROM attendance a;

