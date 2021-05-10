IF OBJECT_ID('UserNoOfComplaints', 'U') IS NOT NULL
DROP TABLE UserNoOfComplaints
GO

IF OBJECT_ID('UserWithMaxComplaints', 'U') IS NOT NULL
DROP TABLE UserWithMaxComplaints
GO

IF OBJECT_ID('t1', 'U') IS NOT NULL
DROP TABLE t1
GO

IF OBJECT_ID('t2', 'U') IS NOT NULL
DROP TABLE t2
GO

IF OBJECT_ID('t4', 'U') IS NOT NULL
DROP TABLE t4
GO

--find the number of complaints for each user
SELECT U_ID, COUNT(C_ID) AS "NoOfComplaints"
INTO UserNoOfComplaints
FROM Complaints
GROUP BY U_ID;

--find the user with the max number of complaints
SELECT U_ID
INTO UserWithMaxComplaints
FROM UserNoOfComplaints
WHERE NoOfComplaints = (SELECT MAX(NoOfComplaints) FROM UserNoOfComplaints);

--get the price per unit as a user can order multiple of the same thing in one order
SELECT P_name, O_ID, Price/Quantity AS PricePerUnit
INTO t4
FROM Product_in_Orders;

--get the price of the most expensive product for each user
SELECT p1.U_ID, MAX(t4.PricePerUnit) AS "MaxPrice"
INTO t1
FROM Orders p1, t4
WHERE p1.O_ID = t4.O_ID AND p1.U_ID IN (SELECT * FROM UserWithMaxComplaints)
GROUP BY p1.U_ID;

--get the most expensive product
SELECT DISTINCT t3.P_name
INTO t2
FROM t1, Orders t2, Product_in_Orders t3
WHERE t1.U_ID = t2.U_ID AND t1.MaxPrice = t3.Price;

SELECT * FROM t2;