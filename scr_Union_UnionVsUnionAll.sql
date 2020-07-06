
	USE Northwind; -- Switch to the Northwind database

	-- UNION (combine two resultsets removing duplicates)
	-- UNION ALL (combine two resultsets preserving duplicates)

	SELECT
		EmployeeID,
		FirstName,
		LastName
	FROM
		dbo.Employees
	WHERE
		City = 'London'

	UNION ALL -- Toggle from UNION to UNION ALL -- Notice Employee 9 --

	SELECT
		EmployeeID,
		FirstName,
		LastName
	FROM
		dbo.Employees
	WHERE
		TitleOfCourtesy = 'Ms.'

	ORDER BY
		EmployeeID;
