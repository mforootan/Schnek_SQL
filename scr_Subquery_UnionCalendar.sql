
	USE Northwind; -- Switch to the Northwind database
	
	-- This query seeks to illustrate that using:
		-- hardcoded literals 
		-- built in functions
		-- subqueries
		-- unions
	-- You can build just about anything...

	SELECT
		
		strMonthYear		= CONVERT(nvarchar, AllMonths.intYear) 
								+ ' ' 
								+ AllMonths.strMonthName,

		Freight				= SUM(ISNULL(Orders.Freight, 0))
		
	FROM
		((
			-- This subquery builds a cartesian product of months and years
			
			SELECT
				tblMonths.*,
				tblYears.*

			FROM 
			(	-- Months pseudo-table build by unioning hard-coded months together
			
				SELECT CONVERT(tinyint,1) AS intMonthNumber, CONVERT(nvarchar(12), 'January') AS strMonthName
				UNION
				SELECT 2, 'February'
				UNION
				SELECT 3, 'March'
				UNION
				SELECT 4, 'April'
				UNION
				SELECT 5, 'May'
				UNION
				SELECT 6, 'June'
				UNION
				SELECT 7, 'July'
				UNION
				SELECT 8, 'August'
				UNION
				SELECT 9, 'September'
				UNION
				SELECT 10, 'October'
				UNION
				SELECT 11, 'November'
				UNION
				SELECT 12, 'December'
				
			) AS tblMonths,

			(	-- Years pseudo-table 
			
				SELECT CONVERT(smallint, DATEPART(year, GETDATE())-10) AS intYear
				UNION
				SELECT (DATEPART(year, GETDATE()) -11)
				UNION
				SELECT (DATEPART(year, GETDATE()) -12)
				UNION
				SELECT (DATEPART(year, GETDATE()) -13)
				UNION
				SELECT (DATEPART(year, GETDATE()) -14)
				
			) AS tblYears
			
		) AS AllMonths
		
		-- Join the aforementioned cartesian resultset to the orders table...

		LEFT JOIN dbo.Orders AS Orders
		ON (Allmonths.intMonthNumber = DATEPART(Month, Orders.OrderDate))
		AND (Allmonths.intYear = DATEPART(Year, Orders.OrderDate)))

	GROUP BY
	
		CONVERT(nvarchar, AllMonths.intYear) + ' ' + AllMonths.strMonthName,
		AllMonths.intYear,
		AllMonths.intMonthNumber,
		DATENAME(Year, Orders.OrderDate) + ' ' + DATENAME(Month, Orders.OrderDate),
		DATEPART(Year, Orders.OrderDate),
		DATEPART(Month, Orders.OrderDate)

	ORDER BY
		AllMonths.intYear,
		AllMonths.intMonthNumber