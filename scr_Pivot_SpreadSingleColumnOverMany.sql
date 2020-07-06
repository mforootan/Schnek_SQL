
	USE Northwind; -- Switch to the Northwind database

	-- While it is often not the most efficient or compact way to display data...
	-- Spreading the variations that exist in a single field of data across many columns is popular

	SELECT
		Prods.ProductName,
		
		(SELECT 'X' FROM dbo.Categories WHERE CategoryID = Prods.CategoryID AND CategoryName ='Beverages') AS Beverages,
		(SELECT 'X' FROM dbo.Categories WHERE CategoryID = Prods.CategoryID AND CategoryName ='Condiments') AS Condiments,
		(SELECT 'X' FROM dbo.Categories WHERE CategoryID = Prods.CategoryID AND CategoryName ='Confections') AS Confections,
		(SELECT 'X' FROM dbo.Categories WHERE CategoryID = Prods.CategoryID AND CategoryName ='Dairy Products') AS [Dairy Products],
		(SELECT 'X' FROM dbo.Categories WHERE CategoryID = Prods.CategoryID AND CategoryName ='Grains/Cereals') AS [Grains/Cereals],
		(SELECT 'X' FROM dbo.Categories WHERE CategoryID = Prods.CategoryID AND CategoryName ='Meats/Poultry') AS [Meats/Poultry],
		(SELECT 'X' FROM dbo.Categories WHERE CategoryID = Prods.CategoryID AND CategoryName ='Produce') AS Produce,
		(SELECT 'X' FROM dbo.Categories WHERE CategoryID = Prods.CategoryID AND CategoryName ='Seafood') AS Seafood	
	FROM
		dbo.Products AS Prods
		
	ORDER BY
		Prods.ProductName;
		
	-- Below, we replaced the 'X' with some other attribute about the Category... 
	-- There isn't much in Northwind to work with, but you'll get the idea when you run it
		
	SELECT
		Prods.ProductName,
		
		(SELECT [Description] FROM dbo.Categories WHERE CategoryID = Prods.CategoryID AND CategoryName ='Beverages') AS Beverages,
		(SELECT [Description] FROM dbo.Categories WHERE CategoryID = Prods.CategoryID AND CategoryName ='Condiments') AS Condiments,
		(SELECT [Description] FROM dbo.Categories WHERE CategoryID = Prods.CategoryID AND CategoryName ='Confections') AS Confections,
		(SELECT [Description] FROM dbo.Categories WHERE CategoryID = Prods.CategoryID AND CategoryName ='Dairy Products') AS [Dairy Products],
		(SELECT [Description] FROM dbo.Categories WHERE CategoryID = Prods.CategoryID AND CategoryName ='Grains/Cereals') AS [Grains/Cereals],
		(SELECT [Description] FROM dbo.Categories WHERE CategoryID = Prods.CategoryID AND CategoryName ='Meats/Poultry') AS [Meats/Poultry],
		(SELECT [Description] FROM dbo.Categories WHERE CategoryID = Prods.CategoryID AND CategoryName ='Produce') AS Produce,
		(SELECT [Description] FROM dbo.Categories WHERE CategoryID = Prods.CategoryID AND CategoryName ='Seafood') AS Seafood	
	FROM
		dbo.Products AS Prods
		
	ORDER BY
		Prods.ProductName;		