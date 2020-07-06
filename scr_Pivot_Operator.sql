
USE Northwind;

SELECT -- Select what you want from the now-pivoted data...

	ProductID, -- Can include non-pivoted fields
	ProductName, -- Such as product id and name
	[1995], -- These fields are pivoted...
	[1996], -- Arrrgh! these have to be hard-coded, no subqueries allowed...
	[1997], -- Only alternative is to dynamically create SQL at run time and EXEC it...
	[1998] AS ['99 Bonanza!], -- You can alias the column headings, if you desire
	[1999]
	
FROM
	( -- Subquery to pull data you want to pivot
	
		SELECT
			Prods.ProductID,
			Prods.ProductName,
			YEAR(Ords.OrderDate) AS OrderYear,
			Details.UnitPrice	
					
		FROM
			(dbo.Orders AS Ords
			
				INNER JOIN (dbo.[Order Details] AS Details
					INNER JOIN dbo.Products AS Prods
					ON (Details.ProductID = Prods.ProductID))
				ON (Ords.OrderID = Details.OrderID))	
			
	) AS SourceData
	PIVOT --Pivot the source data as per the following instructions
	(
		SUM(UnitPrice) -- Aggreged values you want to display under pivoted column headings
		FOR OrderYear IN	( -- Column whose values you want to pivot horizontally into column names
								[1995], -- List of values to use for horizontal column names (must occur in above field)
								[1996], -- Arrrgh! these have to be hard-coded, no subqueries allowed...
								[1997], -- Only alternative is to dynamically create SQL at run time and EXEC it...
								[1998], -- This hard-coding is a major limitation of the PIVOT operator...
								[1999] 
							)
	) AS PivotTable

	-- INNER JOIN dbo.OtherTables AS ExtraInfo				-- You can join other tables here, if desired...
	-- ON (PivotTable.SomeField = ExtraInfo.SomeField)

ORDER BY ProductName;

