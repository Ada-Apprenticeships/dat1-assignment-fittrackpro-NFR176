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
(11, 50.00, NOW(), 'Credit Card', 'Monthly membership fee');

--2.2--

SELECT 
    MONTH(payment_date) AS month,        -- Extract the month from the payment date
    YEAR(payment_date) AS year,          -- Extract the year from the payment date
    SUM(amount) AS total_revenue         -- Sum the payments for each month
FROM payments
WHERE payment_type = 'Monthly membership fee'  -- Filter for membership fee payments
  AND payment_date >= CURDATE() - INTERVAL 1 YEAR  -- Consider payments from the last year
GROUP BY year, month                      -- Group by year and month
ORDER BY year DESC, month DESC;            -- Sort by year and month (most recent first)

--2.3--
-- Count total number of members

SELECT COUNT(*) AS total_members
FROM memberships;




