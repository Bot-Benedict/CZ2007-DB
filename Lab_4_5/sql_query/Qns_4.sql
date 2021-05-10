-- Let us define the “latency” of an employee by the average that he/she takes to process a complaint.
-- Find the employee with the smallest latency. 

-- Subquery creates an extra column Latency that is the average absolute difference between Handled_date_time and Filed_date_time.
-- Order by Latency (ascending) and choose the first row. That will contain the E_ID and the employee’s Latency.
IF OBJECT_ID('X1', 'U') IS NOT NULL
DROP TABLE X1
GO

SELECT E_ID, AVG(ABS(DATEDIFF(minute, Handled_date_time, Filed_date_time))) as Latency
INTO X1
FROM Complaints
GROUP BY E_ID

select * from X1 where (Latency) IN (select min(Latency) from X1);