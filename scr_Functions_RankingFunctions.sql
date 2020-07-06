

-- SQL Server Ranking Functions


SELECT
	-- Number the resultset in 10 approximately equal chunks...
	NTILE(10) OVER(ORDER BY Custs.CompanyName ASC) AS NTileTenChunks,

	-- You can do ranking functions by nested orders as below
	ROW_NUMBER() OVER(ORDER BY Custs.CompanyName, Cats.CategoryName ASC) AS RowNumber, -- Just number them
	RANK() OVER(ORDER BY Custs.CompanyName, Cats.CategoryName ASC) AS Ranking, -- Equal values tie... leaving hole in sequence
	DENSE_RANK() OVER(ORDER BY Custs.CompanyName, Cats.CategoryName ASC) AS DenseRanking, -- Equal values tie... but no hole in sequence

	-- You can partition them (tell them to start over based on some column / column combination)
	ROW_NUMBER() OVER(PARTITION BY Custs.CompanyName ORDER BY Cats.CategoryName ASC) AS P_RowNumber, -- Just number them
	RANK() OVER(PARTITION BY Custs.CompanyName ORDER BY Cats.CategoryName ASC) AS P_Ranking, -- Equal values tie... leaving hole in sequence
	DENSE_RANK() OVER(PARTITION BY Custs.CompanyName ORDER BY Cats.CategoryName ASC) AS P_DenseRanking, -- Equal values tie... but no hole in sequence

	Custs.CompanyName,
	Cats.CategoryName,
	Prods.ProductName
	
FROM
	(dbo.Customers AS Custs
	
	LEFT JOIN (dbo.Orders AS Ords	
		INNER JOIN (dbo.[Order Details] AS Details		
			INNER JOIN (dbo.Products AS Prods			
				INNER JOIN dbo.Categories AS Cats
				ON (Prods.CategoryID = Cats.CategoryID))				
			ON (Details.ProductID = Prods.ProductID))			
		ON (Ords.OrderID = Details.OrderID))		
	ON (Custs.CustomerID = Ords.CustomerID))
	
ORDER BY 
	Custs.CompanyName;