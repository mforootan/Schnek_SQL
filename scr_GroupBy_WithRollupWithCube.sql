
SELECT 
	Cats.CategoryName,
	Prods.ProductName,
	SUM(Details.Quantity) AS Quantity,
	SUM(Details.UnitPrice) AS UnitPrice,
	CASE GROUPING(Cats.CategoryName) WHEN 1 THEN '!' ELSE '' END AS CatSummary,
	CASE GROUPING(Prods.ProductName) WHEN 1 THEN 'X' ELSE '' END AS ProdSummary
	
FROM
	((dbo.Products AS Prods
	
	INNER JOIN dbo.Categories AS Cats
	ON (Prods.CategoryID = Cats.CategoryID))
	
	LEFT JOIN dbo.[Order Details] AS DETAILS
	ON (Prods.ProductID = Details.ProductID))
	
GROUP BY
	Cats.CategoryName,
	Prods.ProductName
	
	WITH ROLLUP -- CUBE <-- Try changing this to CUBE, same same.
	
	
HAVING SUM(Details.Quantity) > 1000
	
ORDER BY
	SUM(Details.Quantity) DESC,
	Prods.ProductName
	
