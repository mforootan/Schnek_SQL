

CREATE PROCEDURE dbo.prcProductsDynamicPivot
(
	@strProductName nvarchar(50) = '%',
	@strLocation nvarchar(50) = '%'
)

AS
	DECLARE @strProductList nvarchar(4000)
	DECLARE @strSqlStatement nvarchar(4000)
	
	SELECT @strProductList = STUFF(
									(
										SELECT  '],[' + ProductName  
										FROM dbo.Products 
										WHERE ProductName LIKE '%' + @strProductName + '%' 
										GROUP BY ProductName 
										FOR XML PATH('')
									)
										
									, 1, 2,'') + ']'

	SET @strSqlStatement = 
	'SELECT * 
	FROM (
			SELECT
				SalesPerson.City,
				SalesPerson.EmployeeID AS SalesPersonID,
				SalesPerson.FirstName + ' + CHAR(32) + ' + SalesPerson.LastName AS SalesPersonName,
				Prods.ProductName, 
				CASE WHEN (Quantity = 0) THEN NULL
					WHEN (Quantity > 0) AND (Quantity < 5) THEN 0
					ELSE 1
				END AS StatusCode
				

			FROM 		
				((dbo.Orders AS Ords

				INNER JOIN (dbo.[Order Details] AS Details
				
					INNER JOIN dbo.Products AS Prods	
					ON (Details.ProductID = Prods.ProductID))
					
				ON (Ords.OrderID = Details.OrderID))

				INNER JOIN dbo.Employees AS SalesPerson
				ON (Ords.EmployeeID = SalesPerson.EmployeeID)
				AND (SalesPerson.City LIKE (' + CHAR(39) + @strLocation + CHAR(39) + ')))
		
	) AS OrderDetails	
	PIVOT 
	(
		
		MIN(StatusCode)
		FOR ProductName
		IN (' + @strProductList + ')

	) AS tblPivoted
	
	ORDER BY 
		City,
		SalesPersonName'
	
	

	EXEC(@strSqlStatement)



		