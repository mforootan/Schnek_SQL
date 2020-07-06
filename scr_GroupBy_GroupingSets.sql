
-- Using GROUP BY with ROLLUP, CUBE, and GROUPING SETS
-- http://msdn.microsoft.com/en-us/library/bb522495.aspx

	
----------------------------------------------------------
-- Using a Grouping Set (where we used to union groups) --
----------------------------------------------------------
	
SELECT 
	Cats.CategoryName,
	Prods.ProductName,
	SUM(Details.Quantity) AS Quantity,
	SUM(Details.UnitPrice) AS UnitPrice
FROM
	((dbo.Products AS Prods
	
	INNER JOIN dbo.Categories AS Cats
	ON (Prods.CategoryID = Cats.CategoryID))
	
	LEFT JOIN dbo.[Order Details] AS DETAILS
	ON (Prods.ProductID = Details.ProductID))
	
GROUP BY GROUPING SETS ((Cats.CategoryName), (Prods.ProductName))	
	
------------------------------------------------------
-- Using GROUP BY and UNION ALL to Achieve the Same --
-- (What we used to have to do to accomplish this)  --
------------------------------------------------------
	
SELECT 
	Cats.CategoryName,
	NULL AS ProductName, -- Dummy field to humor UNION
	SUM(Details.Quantity) AS Quantity,
	SUM(Details.UnitPrice) AS UnitPrice
FROM
	((dbo.Products AS Prods
	
	INNER JOIN dbo.Categories AS Cats
	ON (Prods.CategoryID = Cats.CategoryID))
	
	LEFT JOIN dbo.[Order Details] AS DETAILS
	ON (Prods.ProductID = Details.ProductID))

GROUP BY 
	Cats.CategoryName
	
UNION ALL ---------------------------------------------	

SELECT 
	NULL AS CategoryName, -- Dummy field to humor UNION
	Prods.ProductName,
	SUM(Details.Quantity) AS Quantity,
	SUM(Details.UnitPrice) AS UnitPrice
FROM
	((dbo.Products AS Prods
	
	INNER JOIN dbo.Categories AS Cats
	ON (Prods.CategoryID = Cats.CategoryID))
	
	LEFT JOIN dbo.[Order Details] AS DETAILS
	ON (Prods.ProductID = Details.ProductID))

GROUP BY 
	Prods.ProductName
