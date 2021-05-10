SELECT P_name, COUNT(P_name) as Number, MONTH(Date_time) as Actual_Month, YEAR(Date_time) as Actual_Year
INTO SUM_MONTH
FROM PIO_in_Orders
GROUP BY P_name, MONTH(Date_time), YEAR(Date_time)

SELECT DISTINCT S1.P_name
FROM SUM_MONTH S1, SUM_MONTH S2, SUM_MONTH S3
WHERE S1.P_name=S2.P_name AND S2.P_name=S3.P_name AND S1.Number<S2.Number AND S2.Number<S3.Number AND((S1.Actual_Month+1=S2.Actual_Month and S2.Actual_Month+1=S3.Actual_Month) or (S1.Actual_Month=11 and S3.Actual_Month=1 and S1.Actual_Year+1=S3.Actual_Year and S1.Actual_Year=S2.Actual_Year and S1.Actual_Month+1=S2.Actual_Month) or (S1.Actual_Month=12 and S2.Actual_Month=1 and S2.Actual_Month+1=S3.Actual_Month and S1.Actual_Year+1=S2.Actual_Year and S2.Actual_Year=s3.Actual_Year))

IF OBJECT_ID('SUM_MONTH', 'U') IS NOT NULL
DROP TABLE SUM_MONTH
GO