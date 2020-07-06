
	USE Northwind; -- Switch to the Northwind database

	-- Customers and Employees want to have a joint picnic
	-- Combine the two lists to make a list of company picnickers
	
	-- Because you can't union resultsets with conflicting data types,
	-- We're converting employeeID to character data, and padding it out
	-- with leading zeros, to look more like CustomerIDs
	
	-- The column name aliases used in the first SELECT statement
	-- will determine the column names of all of the data unioned together

	SELECT 
		RIGHT('00000' + CONVERT(nvarchar, EmployeeID), 5) AS PicnickerID, 
		FirstName + ' ' + LastName AS PicnickerName
	FROM 
		dbo.Employees

	UNION ------- combine the two result sets into one ---------------

	SELECT 
		CustomerID, -- Same data type as previous select statement
		ContactName  -- Same number of columns as previous select statement
	FROM 
		dbo.Customers
		
	ORDER BY -- Order By clause always on the last SELECT statement in the union
		PicnickerName; 