
	USE Northwind; -- Switch to the Northwind database
	
	-- Uncomment the "FOR XML" clauses at the bottom one at a time and run the query
	-- Click on the hyperlink created (SQL 2005 and newer) and note the behavior...

	SELECT
	
		Customer.CustomerID,
		Customer.CompanyName, 
		Customer.City, 
		Customer.Region, 
		Customer.Country,
		[Order].OrderID, 
		[Order].OrderDate, 
		Item.ProductID, 
		Item.UnitPrice, 
		Item.Quantity 
	
	FROM 
		(dbo.Customers AS Customer -- Table name aliases determine some element names in XML
		
		INNER JOIN (dbo.Orders AS [Order]
			INNER JOIN dbo.[Order Details] AS Item
			ON ([Order].OrderID = Item.OrderID))
		ON (Customer.CustomerID = [Order].CustomerID))
	
	--FOR XML RAW;
	--FOR XML RAW('Customer');
	--FOR XML RAW('Customer'), ROOT('Customers');

	-- These are hierarchical, and will take a little longer to run:

	--FOR XML AUTO, ROOT('Customers'), XMLSCHEMA; -- Add a root element
	--FOR XML AUTO, ELEMENTS, ROOT('Customers'); -- Use conventional element tags
