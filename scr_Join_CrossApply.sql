


ALTER FUNCTION dbo.fniEmployeeSales
(
	@intEmployeeID	int	= NULL
)
RETURNS TABLE

AS

RETURN (

	SELECT
		Ords.OrderDate,
		Ords.ShipCity,
		Details.Quantity,
		Details.UnitPrice,
		Prods.ProductName
		
	FROM (dbo.Orders AS Ords

		INNER JOIN (dbo.[Order Details] AS Details
		
			INNER JOIN dbo.Products AS Prods
			ON (Details.ProductID = Prods.ProductID))
			
		ON (Ords.OrderID = Details.OrderID))

	WHERE
		(Ords.EmployeeID = ISNULL(@intEmployeeID, Ords.EmployeeID))
	

	) -- Done.
	
GO

SELECT
	--Emps.EmployeeID,
	Emps.FirstName,
	Emps.LastName,
	Emps.City,
	Sales.*
		
FROM
	dbo.Employees AS Emps
	
	OUTER APPLY dbo.fniEmployeeSales(Emps.EmployeeID) AS Sales

WHERE
	(Emps.City = 'YourTown');