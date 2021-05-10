SELECT TOP (5) pio1.P_name	-- Get the top 5 Product Name
FROM PIO_in_Orders pio1, Product_in_Orders pio2, Orders o
WHERE pio1.O_ID = pio2.O_ID AND pio2.O_ID = o.O_ID AND MONTH(pio1.Date_time) = 8 -- Get August data
GROUP BY pio1.P_name
HAVING COUNT(DISTINCT o.U_ID) < (SELECT COUNT(*) -- Some user did not buy the product
 								 FROM Users)
ORDER BY SUM(pio2.Quantity) DESC;

