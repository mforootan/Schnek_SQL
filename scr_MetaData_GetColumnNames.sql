
	USE Northwind; -- Switch to the Northwind database
	
	-- Dynamically generate column names for a particular table
	-- Best viewed with "Results to Text" (rather than grid) selected

	SELECT CHAR(9) + 'Invs.' + [Name] + ', ' FROM sys.syscolumns WHERE id = OBJECT_ID(N'dbo.Invoices') ORDER BY colid
	
	-- Same code follows, but walked down the page so we can write comments explaining it...

	SELECT
	
		CHAR(9)		-- Tab character... indent
		+ 'Invs.'	-- Table name alias
		+ [Name]	-- Columname field from the syscolumns table, protected in [] because its a reserved word
		+ ', '		-- Put a comma after every field name...
		 
	FROM 
		sys.syscolumns -- Metadata table carrying info on all columns for all database objects
		
	WHERE
	 
		id									-- Unique id of database object column maps to						
			= OBJECT_ID(					-- Built in function that returns the id of a named object
						N'dbo.Invoices'		-- Object you'd like to name -- find associated columns for
						)
		 
	ORDER BY
	 
		colid								-- Orders alphabetically if you don't specify created order
		
	-- The ANSI standard way to pull the same information

	SELECT CHAR(9) + 'Invs.' + COLUMN_NAME + ', ' 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE (TABLE_SCHEMA = N'dbo') AND (TABLE_NAME = N'Invoices') 
	ORDER BY ORDINAL_POSITION