SELECT AVG(ABS(DATEDIFF(day, Date_time, Delivery_Date))) AS Average_DeliveryTime
FROM (SELECT  pro_in.P_name, Delivery_Date, Date_time
	  FROM Product_in_Orders pro_in, PIO_in_Orders pio
	  WHERE pro_in.P_name = pio.P_name and Status = 'Delivered'
	  and MONTH(Delivery_Date) = 12 and 
	  Year(Delivery_Date) = 2020 and pro_in.O_ID = pio.O_ID) 
	  AS ProductOrder;


