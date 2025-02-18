-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

-- Payment Management Queries

-- 1. Record a payment for a membership
-- TODO: Write a query to record a payment for a membership

-- 2c

-- 3. Find all day pass purchases
-- TODO: Write a query to find all day pass purchases

--2.1--
-- Insert a new payment for member 11
INSERT INTO payments (member_id, amount, payment_date, payment_method, payment_type)
VALUES 
(11, 50.00, CURRENT_TIMESTAMP, 'Credit Card', 'Monthly membership fee');


--2.2--
-- Summing monthly membership fee payments over the past year
SELECT substr(payment_date, 1, 7) AS month, SUM(amount) AS total_revenue -- SUBSTR gets part of a string starting from a position. 
-- Useful for dates or text.
FROM payments
WHERE payment_type = 'Monthly membership fee'
  AND payment_date >= date('now', '-1 year')---- Filters payments made in the last year by comparing payment_date to the current date minus one year.
GROUP BY month;


--2.3--
SELECT COUNT(DISTINCT member_id) AS total_members
FROM memberships;





