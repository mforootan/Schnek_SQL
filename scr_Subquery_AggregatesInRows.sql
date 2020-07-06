
	
	USE Northwind; -- Switch to the Northwind database
	
	SELECT
		-- Sequence, --Skip displaying the sequence field... used to sort in month order
		[Month], 
		FreightCharges
		
	FROM
		(
			-- Union all the months together to create a pseudo-table of sorts...
			
			SELECT 1 AS Sequence, 'January' AS [Month], SUM(Freight) AS FreightCharges FROM dbo.Orders WHERE DATEPART(Month, OrderDate) = 1
			UNION	
			SELECT 2 AS Sequence, 'February' AS [Month], SUM(Freight) AS FreightCharges FROM dbo.Orders WHERE DATEPART(Month, OrderDate) = 2
			UNION	
			SELECT 3 AS Sequence, 'March' AS [Month], SUM(Freight) AS FreightCharges FROM dbo.Orders WHERE DATEPART(Month, OrderDate) = 3
			UNION	
			SELECT 4 AS Sequence, 'April' AS [Month], SUM(Freight) AS FreightCharges FROM dbo.Orders WHERE DATEPART(Month, OrderDate) = 4
			UNION	
			SELECT 5 AS Sequence, 'May' AS [Month], SUM(Freight) AS FreightCharges FROM dbo.Orders WHERE DATEPART(Month, OrderDate) = 5
			UNION	
			SELECT 6 AS Sequence, 'June' AS [Month], SUM(Freight) AS FreightCharges FROM dbo.Orders WHERE DATEPART(Month, OrderDate) = 6
			UNION	
			SELECT 7 AS Sequence, 'July' AS [Month], SUM(Freight) AS FreightCharges FROM dbo.Orders WHERE DATEPART(Month, OrderDate) = 7
			UNION	
			SELECT 8 AS Sequence, 'August' AS [Month], SUM(Freight) AS FreightCharges FROM dbo.Orders WHERE DATEPART(Month, OrderDate) = 8
			UNION	
			SELECT 9 AS Sequence, 'September' AS [Month], SUM(Freight) AS FreightCharges FROM dbo.Orders WHERE DATEPART(Month, OrderDate) = 9
			UNION	
			SELECT 10 AS Sequence, 'October' AS [Month], SUM(Freight) AS FreightCharges FROM dbo.Orders WHERE DATEPART(Month, OrderDate) = 10
			UNION	
			SELECT 11 AS Sequence, 'November' AS [Month], SUM(Freight) AS FreightCharges FROM dbo.Orders WHERE DATEPART(Month, OrderDate) = 11
			UNION	
			SELECT 12 AS Sequence, 'December' AS [Month], SUM(Freight) AS FreightCharges FROM dbo.Orders WHERE DATEPART(Month, OrderDate) = 12
			
		) AS AnnualSales -- Give it a table alias so we can use it as a subquery
		
	ORDER BY
		Sequence; -- Make January show up first... 
		
		
	--if we had sorted by month name we'd have got...
		
		-- April
		-- August
		-- December
		-- February
		-- January
		-- July
		-- June
		-- March
		-- May
		-- November
		-- October
		-- September

