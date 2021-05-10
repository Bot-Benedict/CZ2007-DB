WITH T1(S_name, Revenue) AS
	(SELECT S_name, SUM(Price*Quantity) AS Revenue
	 FROM Product_in_Orders
	 WHERE MONTH(Delivery_Date) = 8 AND "Status" != 'Refunded'
	 GROUP BY S_name)
	 --generate revenue of individual shops for august and remove rows with status= refunded.


SELECT S_name
FROM T1
WHERE T1.Revenue
IN (SELECT MAX (t.Revenue)
FROM T1 t)

	 --find the shop with revenue that matches the max revenue from the view T1.
