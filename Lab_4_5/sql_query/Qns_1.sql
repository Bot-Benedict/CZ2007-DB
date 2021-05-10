SELECT AVG(Price) as AvgPrice
FROM Price_History 
WHERE P_name = 'iPhone X' AND "End_date" >= '2020-08-01 00:00:00' AND End_date <= '2020-08-31 23:59:59'
