WITH Samsung_Products(P_name) AS
	(SELECT DISTINCT P_name
	FROM Product_in_Shops
	WHERE Maker='Samsung') --select distinct products with maker as samsung
SELECT pis.P_name, COUNT(pis.S_name) as "Shop Count"
FROM Samsung_Products sp
JOIN Product_in_Shops pis
ON pis.P_name = sp.P_name
GROUP BY pis.P_name
