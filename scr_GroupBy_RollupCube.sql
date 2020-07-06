
-- Using GROUP BY with ROLLUP, CUBE, and GROUPING SETS
-- http://msdn.microsoft.com/en-us/library/bb522495.aspx

SELECT 
	Cats.CategoryName,
	Prods.ProductName,
	SUM(Details.Quantity) AS Quantity,
	SUM(Details.UnitPrice) AS UnitPrice,
	CASE GROUPING(Cats.CategoryName) WHEN 1 THEN 'ALL' ELSE '' END AS CatSummary,
	CASE GROUPING(Prods.ProductName) WHEN 1 THEN 'ALL' ELSE '' END AS ProdSummary
	
FROM
	((dbo.Products AS Prods
	
	INNER JOIN dbo.Categories AS Cats
	ON (Prods.CategoryID = Cats.CategoryID))
	
	LEFT JOIN dbo.[Order Details] AS DETAILS
	ON (Prods.ProductID = Details.ProductID))
	
GROUP BY ROLLUP -- CUBE <-- Try changing this to CUBE, same same.
	(
	Cats.CategoryName,
	Prods.ProductName
	)
		
HAVING SUM(Details.Quantity) > 1000
	
ORDER BY
	SUM(Details.Quantity) DESC,
	Prods.ProductName
	
