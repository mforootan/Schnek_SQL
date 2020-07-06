
	USE Northwind; -- Switch to the Northwind database

	-- You want to be careful not to update rows you didn't intend to update,
	-- so, I usually write a select statement that produces the rows i'd like to create
	-- (before I actually modify the code to cause updating to occur), for example:

	-- This is what I wish would happen...

	SELECT
		LastName	= LastName + ', Esq.',  -- Prefer T-SQL column name aliasing here--not ANSI Aliasing
		City		= 'London Towne'		-- (Use "LastName = ColumnName" rather than "ColunmName AS LastName")
	FROM
		dbo.Employees
	WHERE
		City = 'London';

	-- Once the above query is producing the results I'd like to see,
	-- I edit the word SELECT to say SET, and put the UPDATE clause in above it...
	
	UPDATE dbo.Employees
	
	SET -- <-- Used to say SELECT
	
		LastName	= LastName + ', Esq.',  -- TSQL columnname aliasing requires no modification
		City		= 'London Towne'		-- when converting a SELECT statement to an UPDATE statement 
	FROM
		dbo.Employees
	WHERE
		City = 'London';
		
