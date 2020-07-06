
	USE Northwind; -- Switch to the Northwind database
	
	-- Here we're joining the Employees table right back to itself...
	-- One reference to the table is used to display employee data...
	-- The other reference to the Employees table is to display manager data.
	
	-- You must alias a table name any time is is used multiple times in the same query...
	-- So you should alias them to something that describes their role 
	-- (the use to which you are putting them in the present context),
	-- hence the aliases of Subordinates and Managers
	
	SELECT 
		Subordinates.FirstName,
		Subordinates.LastName,
		Subordinates.HireDate,
		Managers.FirstName + ' ' + Managers.LastName AS ManagerName
	FROM
		(dbo.Employees AS Subordinates

		LEFT JOIN dbo.Employees AS Managers
		ON (Subordinates.ReportsTo = Managers.EmployeeID))
		
	ORDER BY
		Managers.FirstName + ' ' + Managers.LastName;