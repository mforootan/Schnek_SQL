
	USE Northwind; -- Switch to the Northwind database
	
	-- Aggregating UNIONed resultsets

	-- You can do aggregations in the individual
	-- SELECT statements that are unioned, but...

	SELECT
		'Cust' AS strLocationType, -- Customer Locations
		Country,
		City,
		COUNT(*) AS intInstances
	FROM
		dbo.Customers
	GROUP BY
		Country,
		City

	UNION --------------------------------

	SELECT
		'Emp' AS strLocationType, -- Employee Locations
		Country,
		City,
		COUNT(*) AS intInstances
	FROM
		dbo.Employees

	GROUP BY
		Country,
		City
		
	ORDER BY
		intInstances DESC;

	-- To Aggregate across the entire UNIONed result...
	-- You must push the wrap the UNIONed results in a subquery...

	SELECT
		Country,
		City,
		COUNT(*) AS intInstances
	FROM
		( -- Subquery 
		
		SELECT
			'Cust' AS strLocationType,
			Country,
			City
			
		FROM
			dbo.Customers
		
		UNION ALL --(try without all, notice counts are wrong)--
		
		SELECT
			'Emp' AS strLocationType,
			Country,
			City
		FROM
			dbo.Employees

		) AS CorpLocations -- End Subquery

	GROUP BY
		Country,
		City

	ORDER BY
		COUNT(*) DESC,
		Country,
		City;

