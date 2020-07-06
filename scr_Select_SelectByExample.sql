
	USE Northwind; -- Switch to the Northwind database
	
	-- While a SELECT clause can be as simple as:
	
	SELECT * FROM dbo.Employees;
	
	-- It is common practice to be more selective about what columns of data are returned
	-- and specifically, how they are named (aliased), formatted, etc.
	-- What follows is a smathering of examples on how to display columns of data

	SELECT
			
		EmployeeID, -- Just display the column (nothing fancy here)
		LastName AS Surname, -- ANSI field name aliasing, renames the column in the output
		FamilyName = LastName, -- The T-SQL (not ANSI compliant) way to alias column names, discouraged
		FirstName AS [Given Name], -- Use square brackets to include white-space or illegal characters
		FirstName AS "What's in a Name? Everything!", -- Older; some Dbs can use "Quoted Identifiers" for illegal characters
		FirstName + ' ' + LastName AS FullName, -- Combining columns into a single composite column 		
		UPPER(TitleOfCourtesy), -- When altering column display in any way, no column name appears in the output
		UPPER(TitleOfCourtesy) AS Title, -- So, provide it an alias
		CONVERT(nvarchar, BirthDate, 106)AS [Birthday (formatted)], -- Display date in style 106 (see Help CONVERT for styles) 
		DATEPART(year, Emps.HireDate) AS HireYear, 
		YEAR(HireDate) - YEAR(BirthDate) AS HireAge, -- Columns can be calculated
		[Address], -- Protect column names that happen to be reserved words in square brackets
		Emps.City, -- It's elegant to prefix column names with table or table alias name (Emps.)
		Country, -- But not required, except to avoid ambiguity in multiple-table queries
		'Earth' AS Planet, -- Hardcoded value... all of our employees hail from planet Earth
		(SELECT COUNT(*) FROM dbo.Customers WHERE City = Emps.City) AS HometownCustomers -- Correlated subquery in column
		
	FROM
		dbo.Employees AS Emps; -- Regarding "AS Emps", aliasing the name of a table is a common practice... 
								-- (especially when the query includes multiple tables)	