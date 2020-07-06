
	USE Northwind; -- Switch to the Northwind database

	-- While SQL Server will let you get away with saying INSERT
	-- You should prefer the ANSI standard, INSERT INTO

	INSERT INTO dbo.Customers
	(
		CustomerID, -- Comma-delimited list of columns that will be inserted into
		CompanyName, 
		ContactName, 
		ContactTitle, 
		[Address], 
		City, 
		Region, 
		PostalCode, 
		Country, 
		Phone, 
		Fax
	)
	
	SELECT -- Write a SELECT statement that produces the records you want to insert

		CustomerID		= 'WXYZQ', 
		CompanyName		= 'Amalgamated Lemon Stands', 
		ContactName		= 'Limey Brown', 
		ContactTitle	= 'Chief Squeezer', 
		[Address]		= '123 Lemony Way', 
		City			= 'Sour Ridge', 
		Region			= 'Western', 
		PostalCode		= '01234-6789', 
		Country			= 'USA', 
		Phone			= '615.223.6789', 
		Fax				= '615.223.0176';


	-- Let's see if it worked... you should see your new customer

	SELECT * FROM Customers WHERE CustomerID = 'WXYZQ';
	
	
	-- Some thoughts on style... any of the following approaches will work....
	
	---------------------------------------------------------------------------------------
	
	INSERT INTO dbo.Employees
	(
		FirstName,
		LastName,
		City
	)
	SELECT
		'Joel' 		AS FirstName, -- ANSI column aliasing unnecessary, but provides clarity
		'Smithy'	AS LastName,
		'BigTown'	AS City;
			
	---------------------------------------------------------------------------------------
	
	INSERT INTO dbo.Employees
	(
		FirstName,
		LastName,
		City
	)
	SELECT
		FirstName	= 'Joel',	-- T-SQL column aliasing unnecessary, but provides clarity
		LastName	='Smithy',
		City		='BigTown';
		
	---------------------------------------------------------------------------------------
		
	INSERT INTO dbo.Employees
	(
		FirstName,
		LastName,
		City
	)
	SELECT
		'Joel', -- No column names required, just data...
		'Smithy',
		'BigTown';

	---------------------------------------------------------------------------------------


