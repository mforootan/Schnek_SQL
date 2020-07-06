
	USE Northwind; -- Switch to the Northwind database

	-- Walk monthly sales across the screen in columns
	-- Note that this example pulls January freight charges for all years... not just one...
	-- You'd have to write a WHERE clause that was more-specific to pull a specific year

	SELECT
		(SELECT SUM(Freight) FROM dbo.Orders WHERE MONTH(OrderDate) = 1) AS January,
		(SELECT SUM(Freight) FROM dbo.Orders WHERE MONTH(OrderDate) = 2) AS February,
		(SELECT SUM(Freight) FROM dbo.Orders WHERE MONTH(OrderDate) = 3) AS March,
		(SELECT SUM(Freight) FROM dbo.Orders WHERE MONTH(OrderDate) = 4) AS April,
		(SELECT SUM(Freight) FROM dbo.Orders WHERE MONTH(OrderDate) = 5) AS May,
		(SELECT SUM(Freight) FROM dbo.Orders WHERE MONTH(OrderDate) = 6) AS June,	
		(SELECT SUM(Freight) FROM dbo.Orders WHERE MONTH(OrderDate) = 7) AS July,
		(SELECT SUM(Freight) FROM dbo.Orders WHERE MONTH(OrderDate) = 8) AS August,
		(SELECT SUM(Freight) FROM dbo.Orders WHERE MONTH(OrderDate) = 9) AS September,
		(SELECT SUM(Freight) FROM dbo.Orders WHERE MONTH(OrderDate) = 10) AS October,
		(SELECT SUM(Freight) FROM dbo.Orders WHERE MONTH(OrderDate) = 11) AS November,
		(SELECT SUM(Freight) FROM dbo.Orders WHERE MONTH(OrderDate) = 12) AS December;

	-- No FROM clause... In T-SQL you aren't necessarily required to have a FROM clause
	
	
	-- Of course you could have mapped other aggregates (instead of SUM) here...
	-- MIN, MAX, AVG, COUNT, etc.