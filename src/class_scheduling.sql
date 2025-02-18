-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

-- Class Scheduling Queries

-- 1. List all classes with their instructors
-- TODO: Write a query to list all classes with their instructors

-- 2. Find available classes for a specific date
-- TODO: Write a query to find available classes for a specific date

-- 3. Register a member for a class
-- TODO: Write a query to register a member for a class

-- 4. Cancel a class registration
-- TODO: Write a query to cancel a class registration

-- 5. List top 5 most popular classes
-- TODO: Write a query to list top 5 most popular classes

-- 6. Calculate average number of classes per member
-- TODO: Write a query to calculate average number of classes per member




--4.1--
SELECT 
    c.class_id, 
    c.name AS class_name, 
    CONCAT(s.first_name, ' ', s.last_name) AS instructor_name -- note to self CONCAt used to combine/concatenates things together- in this instance the instructors  1st and last name 
FROM 
    classes c
JOIN 
    class_schedule cs ON c.class_id = cs.class_id -- inner join used to ensure that only scheduled classses and ones with an instructor are presented-
JOIN 
    staff s ON cs.staff_id = s.staff_id;
   
   -- 4.2: 
SELECT cs.class_id, c.name, cs.start_time, cs.end_time, c.capacity - COUNT(ca.member_id) AS available_spots
FROM class_schedule cs
JOIN classes c ON cs.class_id = c.class_id
LEFT JOIN class_attendance ca ON cs.schedule_id = ca.schedule_id
GROUP BY cs.class_id, c.name, cs.start_time, cs.end_time, c.capacity;

-- 4.3: 
INSERT INTO class_attendance (schedule_id, member_id, attendance_status)
SELECT cs.schedule_id, 11, 'Registered'
FROM class_schedule cs
JOIN classes c ON cs.class_id = c.class_id
WHERE cs.class_id = 3  
  AND cs.start_time = '2025-02-01 14:00:00'  -- Class start time
  AND (SELECT COUNT(*) FROM class_attendance WHERE schedule_id = cs.schedule_id) < c.capacity; 

--4.4--


DELETE   FROM class_attendance  
WHERE schedule_id = 7 
  AND attendance_status = 'Registered'; 

--4.5--


SELECT c.class_id, 
       c.name AS class_name, 
       COUNT(ca.member_id) AS registration_count
FROM classes c
JOIN class_schedule cs  
   ON c.class_id = cs.class_id
JOIN class_attendance ca  
   ON cs.schedule_id = ca.schedule_id --joins the cs and ca tables on the schedule id column-
WHERE c.capacity > 0  --the 0 is showing greater than 0-- --filtering the data to include only the rows where the class has available space/capacity--
GROUP BY c.class_id, c.name
ORDER BY registration_count DESC--note to self, DESC is used to put the data in desending order--
LIMIT 3;  -- shows the top 3 classes--

--4.6--
SELECT AVG(class_count) AS avg_classes_per_member
FROM (
    -- Count how many classes each member has attended
    SELECT member_id, COUNT(*) AS class_count
    FROM class_attendance
    GROUP BY member_id  -- group by-- groups rows together with certain values into summary rows--
);
