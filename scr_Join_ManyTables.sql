
	USE Northwind; -- Switch to the Northwind database

	-- Joins are hard for most people new to SQL
	-- Here is some sample code written against the Northwind database
	-- to give you a feel for how it goes...
	
	-- Let's say you wanted to see some basic facts about customers...
	-- You might write something like what follows:
	
	SELECT
	
		CustomerID, 
		CompanyName, 
		ContactName, 
		ContactTitle, 
		City, 
		Region, 
		Country
		
	FROM 
		dbo.Customers;
		
	-- Having decided you'd like to know what orders these customers have placed
	-- you might modify the above query to look as follows:
	
	SELECT
	
		Custs.CustomerID, -- Notice we've added table name aliases, now... "Custs."
		Custs.CompanyName, 
		Custs.ContactName, 
		Custs.ContactTitle, 
		Custs.City, 
		Custs.Region, 
		Custs.Country,
		
		Ords.OrderID, 
		Ords.EmployeeID AS SalesPersonID, -- To clarify that this is the employee credited for the order
		Ords.OrderDate, 
		Ords.ShipCity, 
		Ords.ShipCountry
		
	FROM 
		(dbo.Customers AS Custs -- We're usually going to alias table names in multi-table queries
		
		LEFT JOIN dbo.Orders AS Ords
		ON (Custs.CustomerID = Ords.CustomerID));	-- It doesn't matter which table's column is named first,
													-- but naming the parent table's column first is popular
				
	-- Gee, it'd be great if we could see some detail about each order,
	-- but that'd require that we in turn join to the Orders table to the Order Details table...
	
	SELECT
	
		Custs.CustomerID,
		Custs.CompanyName, 
		Custs.ContactName, 
		Custs.ContactTitle, 
		Custs.City, 
		Custs.Region, 
		Custs.Country,
		
		Ords.OrderID, 
		Ords.EmployeeID AS SalesPersonID,
		Ords.OrderDate, 
		Ords.ShipCity, 
		Ords.ShipCountry,
		
		Details.ProductID, 
		Details.UnitPrice, 
		Details.Quantity 
	
	FROM 
		(dbo.Customers AS Custs 
		
		INNER JOIN (dbo.Orders AS Ords -- <-- Note the addition of the open parenthesis here
		
			--------- begin new join code here -------------------
		
			INNER JOIN dbo.[Order Details] AS Details -- Alas, some insist on white space in object names, protect with []
			ON (Ords.OrderID = Details.OrderID)) -- <-- Note the closing parenthesis here
		
			--------- end new join code here ---------------------
			
		ON (Custs.CustomerID = Ords.CustomerID));
		
	-- Who sold that order, anyway? We'll have to join to Employees to see...
	
	SELECT
	
		Custs.CustomerID,
		Custs.CompanyName, 
		Custs.ContactName, 
		Custs.ContactTitle, 
		Custs.City, 
		Custs.Region, 
		Custs.Country,
		
		Ords.OrderID, 
		Ords.EmployeeID AS SalesPersonID,
		SalesPerson.FirstName + ' ' + SalesPerson.LastName AS SalesPersonName, -- <-- LOOK
		Ords.OrderDate, 
		Ords.ShipCity, 
		Ords.ShipCountry,
		
		Details.ProductID, 
		Details.UnitPrice, 
		Details.Quantity 
	
	FROM 
		(dbo.Customers AS Custs 
		
		INNER JOIN ((dbo.Orders AS Ords -- <-- Note yet another open parenthesis here

			INNER JOIN dbo.[Order Details] AS Details
			ON (Ords.OrderID = Details.OrderID))
		
			--------- begin new join code here -------------------
			
			INNER JOIN dbo.Employees AS SalesPerson
			ON (Ords.EmployeeID = SalesPerson.EmployeeID))	
			
			--------- end new join code here ---------------------		
			
		ON (Custs.CustomerID = Ords.CustomerID));
		
		
	-- We can carry this technique to extremes...
	
	SELECT
	
		Custs.CustomerID,
		Custs.CompanyName, 
		Custs.ContactName, 
		Custs.ContactTitle, 
		Custs.City, 
		Custs.Region, 
		Custs.Country,
		Ords.OrderID, 
		Ords.EmployeeID AS SalesPersonID,
		SalesPerson.FirstName + ' ' + SalesPerson.LastName AS SalesPersonName,
		Ords.OrderDate, 
		Ords.ShipCity, 
		Ords.ShipCountry,
		Details.ProductID,
		Prods.ProductName, 
		Prods.SupplierID,
		Supps.CompanyName, 
		Prods.CategoryID,
		Cats.CategoryName,  
		Details.UnitPrice, 
		Details.Quantity 
	
	FROM 
		(dbo.Customers AS Custs 
		
		INNER JOIN ((dbo.Orders AS Ords

			INNER JOIN (dbo.[Order Details] AS Details
			
				INNER JOIN ((dbo.Products AS Prods
				
					INNER JOIN dbo.Suppliers AS Supps
					ON (Prods.SupplierID = Supps.SupplierID))
					
					INNER JOIN dbo.Categories AS Cats
					ON (Prods.CategoryID = Cats.CategoryID))
					
				ON (Details.ProductID = Prods.ProductID))
				
			ON (Ords.OrderID = Details.OrderID))

			INNER JOIN dbo.Employees AS SalesPerson
			ON (Ords.EmployeeID = SalesPerson.EmployeeID))		
			
		ON (Custs.CustomerID = Ords.CustomerID));
		
	-- Pay attention to the indenting of the join clauses... SQL Server could care less, but I do.
	-- This sql LOOKs like it works... the Orders table is childed under the Customers table...
	-- The Order Details and Employees tables are both connected directly to the Orders table...
	-- The Products table is childed under the Order Details table... as that is where it connects
	-- The Suppliers and Categories tables both connect to the Products table, and are thusly indented
	
	-- I've been accused of being an extreme convention, format, and style guy...
	-- Here's the SAME CODE at the other extreme... 
	-- (for those of you who don't get hung up on standards and convention)
		
		select Custs.CustomerID, [Custs].CompanyName, Custs.[ContactName], custs.contactTitle, custs.City, 
	Custs.Region, Custs.Country, Ords.ORDERID, Ords.EmployeeID AS SalesPersonID, SalesPerson.FirstName + 
	' ' + SalesPerson.LastName as SalesPersonName, Ords.[OrderDate], Ords.ShipCity,   Ords.ShipCountry
	, Details.ProductID, prods.productname, Prods.SupplierID, supps.CompanyName,	Prods.Categoryid, Cats.CategoryName, 
	Details.UnitPrice, Details.Quantity from         dbo.Customers AS Custs INNER JOIN dbo.Orders Ords inner 
	  JOIN dbo.[Order Details] AS Details INNER join [dbo].Products AS Prods on (Details.ProductID = Prods.ProductID) ON 
	(Ords.OrderID = Details.OrderID)  on (Custs.CustomerID = Ords.CustomerID) join dbo.Suppliers Supps On (Prods.SupplierID
	 = Supps.SupplierID) INNER JOIN dbo.Employees AS SalesPerson ON (Ords.EmployeeID = SalesPerson.EmployeeID) inner 
	   JOIN dbo.Categories Cats ON (Prods.CategoryID = Cats.CategoryID);	
	
	-- BTW, people send me this sort of mess with notes like, "Jeff, I'm having trouble figuring this out..." --you think?
	-- Your biggest friends when writing complex queries are carriage-returns and tab characters... use them liberally.										 