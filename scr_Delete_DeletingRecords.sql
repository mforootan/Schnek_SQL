
	USE Northwind; -- Switch to the Northwind database

	-- DELETE

	-- The big thing here is not to put anything between the word DELETE and the word FROM
	-- SQL newbies are tempted to say things like DELETE * FROM or DELETE FirstName FROM...
	-- We don't delete columns... we delete rows... don't embed column information--just DELETE FROM

	DELETE FROM dbo.Employees WHERE FirstName LIKE 'Joe%';

	-- Well, unless we've joining multiple tables to figure out which record to delete...
	-- Even now, we say which TABLE's records to delete... never which columns to delete...

	-- For example, we might need to join to the Territories table to figure out
	-- which records in the EmployeeTerritories table to delete...
	
	DELETE
		EmpTerritories	-- Name the table whose matching records are to be deleted here
	FROM
		(dbo.EmployeeTerritories AS EmpTerritories
		
		INNER JOIN dbo.Territories AS Territories 
		ON (EmpTerritories.TerritoryID = Territories.TerritoryID))
		
	WHERE
		(Territories.TerritoryDescription = 'Atlanta');
		


