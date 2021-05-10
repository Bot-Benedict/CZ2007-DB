SELECT P_name, AVG(Rating) as "AVG"
INTO Ratings
From PIO_Feedback_Users
GROUP BY P_name

SELECT P_name, COUNT(P_name) as "Count"
INTO Aug_Ratings
FROM PIO_Feedback_Users
WHERE MONTH(Date_time)=8 AND YEAR(Date_time)=2020 AND Rating=5
GROUP BY P_name

SELECT Aug_Ratings.P_name
FROM Aug_Ratings, Ratings
WHERE "Count">=100 and Aug_Ratings.P_name=Ratings.P_name
ORDER BY "AVG" DESC
	
IF OBJECT_ID('Aug_Ratings', 'U') IS NOT NULL
DROP TABLE Aug_Ratings
GO
IF OBJECT_ID('Ratings', 'U') IS NOT NULL
DROP TABLE Ratings
GO