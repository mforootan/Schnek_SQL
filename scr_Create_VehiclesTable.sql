
	USE Northwind; -- Switch to the Northwind database
	
	-- Creating a table programmatically is not hard...
	-- Here's an example

	CREATE TABLE dbo.tblCars
	(
		intCar_ID	integer			NOT NULL	IDENTITY(1,1),
		strCarMake	nvarchar(20)	NOT NULL,
		strCarModel	nvarchar(20)	NOT NULL,
		intYear		smallint		NOT NULL,
		intDoors	tinyint			NOT NULL,
		strComments	nvarchar(255)	NULL
		
	) ON [Default];