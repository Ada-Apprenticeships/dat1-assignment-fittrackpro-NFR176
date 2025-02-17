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
    c.class_id,  -- The unique ID for each class
    c.name AS class_name,  --note to self, the AS takes the name of the class from the class table and renames it as class_name.
    s.staff_name AS instructor_name  -- The name of the instructor
FROM classes c  -- The 'classes' table is where class information is stored
JOIN staff s 
    ON c.instructor_id = s.staff_id;  

    --4.2--
    SELECT cs.class_id, c.name, cs.start_time, cs.end_time, c.capacity - COUNT(ca.member_id) AS available_spots
c

--4.3--

-- Register member with ID 11 for the Spin Class on 2025-02-01

INSERT INTO class_attendance (schedule_id, member_id, attendance_status)
SELECT cs.schedule_id, 11, 'Registered'  -- Register member 11
FROM class_schedule cs
JOIN classes c ON cs.class_id = c.class_id
WHERE cs.class_id = 3  -- Spin Class
  AND cs.start_time = '2025-02-01 14:00:00'  -- Class start time
  AND (SELECT COUNT(*) FROM class_attendance WHERE schedule_id = cs.schedule_id) < c.capacity;  -- Check if there is space

--4.4--
-- Cancel the registration for member 2 from the Yoga Basics class (schedule_id 7)

DELETE   FROM class_attendance  -- Extra spaces in DELETE clause for no reason
WHERE schedule_id = 7  -- Yoga Basics class schedule ID
   AND member_id = 2   -- Member ID 2
  AND attendance_status = 'Registered';  -- An unnecessary condition, but still works fine

--4.5--
-- List the top 3 most popular classes by registration count

SELECT c.class_id, --aliases--
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
-- Calculate the average number of classes per member without using AVG()

SELECT 
    (SELECT COUNT(*) FROM class_attendance) * 1.0 / 
    (SELECT COUNT(DISTINCT member_id) FROM class_attendance) AS average_classes_per_member;
