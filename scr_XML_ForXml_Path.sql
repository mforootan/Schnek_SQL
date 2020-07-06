
-- Basic Syntax of the FOR XML Clause
-- http://msdn.microsoft.com/en-us/library/ms190922.aspx

-- Using PATH Mode
-- http://msdn.microsoft.com/en-us/library/ms189885.aspx


	USE Northwind; -- Switch to the Northwind database
	
	-- Uncomment the "FOR XML" clauses at the bottom one at a time and run the query
	-- Click on the hyperlink created (SQL 2005 and newer) and note the behavior...

	SELECT
	
		Customer.CustomerID AS [@CustomerID],
		Customer.CompanyName AS [@CompanyName], 
		Customer.City AS [@City], 
		Customer.Region AS [@Region], 
		Customer.Country AS [@Country],
		[Order].OrderID AS [Order/@OrderID],
		[Order].OrderDate AS [Order/@OrderDate],
		Item.ProductID AS [Order/Item/@ProductID], 
		Item.UnitPrice AS [Order/Item/@UnitPrice], 
		Item.Quantity AS [Order/Item/@Quantity] 
	
	FROM 
		(dbo.Customers AS Customer -- Table name aliases determine some element names in XML
		
		INNER JOIN (dbo.Orders AS [Order]
			INNER JOIN dbo.[Order Details] AS Item
			ON ([Order].OrderID = Item.OrderID))
		ON (Customer.CustomerID = [Order].CustomerID))
	
	-- FOR XML PATH; -- Produces "row" wrapper element
	-- FOR XML PATH(''); --Produces no wrapper element at all
	-- FOR XML PATH('Customer'); -- Produces a "Customer" wrapper element
	-- FOR XML PATH('Customer'), ROOT('Customers'); -- Adds a "Customers" root element
	-- FOR XML PATH('Customer'), ROOT('Customers'), TYPE;

GO

-- Optionally, you can use option-explicit-like column aliases to 
-- achieve hierarchical and attribute-centric results, try this:

	WITH XMLNAMESPACES (
   'uri1' AS ns1,  
   'uri2' AS ns2,
   'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions' AS Custs)
   
	SELECT
	
		Customer.CustomerID AS [@CustomerID],
		Customer.CompanyName AS [@CompanyName], 
		Customer.City AS [@City], 
		Customer.Region AS [@Region], 
		Customer.Country AS [@Country],
		[Order].OrderID AS [Order/@OrderID],
		[Order].OrderDate AS [Order/@OrderDate],
		Item.ProductID AS [Order/Item/@ProductID], 
		Item.UnitPrice AS [Order/Item/@UnitPrice], 
		Item.Quantity AS [Order/Item/@Quantity] 
	
	FROM 
		(dbo.Customers AS Customer -- Table name aliases determine some element names in XML
		
		INNER JOIN (dbo.Orders AS [Order]
			INNER JOIN dbo.[Order Details] AS Item
			ON ([Order].OrderID = Item.OrderID))
		ON (Customer.CustomerID = [Order].CustomerID))
		
	-- FOR XML PATH; -- Produces "row" wrapper element
	-- FOR XML PATH(''); --Produces no wrapper element at all
	-- FOR XML PATH('Customer'); -- Produces a "Customer" wrapper element
	-- FOR XML PATH('Customer'), ROOT('Customers'); -- Adds a "Customers" root element
	-- FOR XML PATH('Customer'), ROOT('Customers'), TYPE;


