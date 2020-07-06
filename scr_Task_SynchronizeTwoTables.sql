
USE Northwind;

-- Hava a look at the customers table
SELECT * FROM Customers;

-- Make a fake staging table from which we'll pretend we regularly update our customers list
SELECT * INTO dbo.CustomerStaging FROM dbo.Customers;

-- Force some source data to be different so we can synchronize with it
UPDATE dbo.CustomerStaging
SET Country = 'US of A' 
WHERE CustomerID LIKE '%A%';

-- Delete a few rows from the source, so the destination has a few rows that source doesn't
DELETE FROM dbo.CustomerStaging WHERE CustomerID IN ('PARIS', 'FISSA');

-- Code that builds other code sample -- disregard... no bearing on this project
SELECT CHAR(9)+ [name] + ' = Staging.' + [name] + ', ' FROM sys.columns WHERE [object_id] = OBJECT_ID(N'dbo.Customers') ORDER BY column_id;

-- Make a sample new row in the source data (so we can add it to ours later)
INSERT INTO dbo.CustomerStaging
(
	CustomerID, 
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
SELECT
	CustomerID		= 'PATTY',
	CompanyName		= 'Pat''s Greasy Spoon',
	ContactName		= 'Pat Fuller',
	ContactTitle	= 'Cook, Bottle Washer',
	[Address]		= '123 My Way',
	City			= 'Your Town',
	Region			= 'Washington',
	PostalCode		= '12345',
	Country			= 'United States',
	Phone			= '123.234.2344',
	Fax				= '343.234.3423';

-- Make another sample new row in the source data (so we can add it to ours later)
INSERT INTO dbo.CustomerStaging
(
	CustomerID, 
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
SELECT
	CustomerID		= 'JOHNY',
	CompanyName		= 'Hungry John''s Hamburgers',
	ContactName		= 'John Hungry',
	ContactTitle	= 'Bottle Washer',
	[Address]		= '345 My Way',
	City			= 'Your Town',
	Region			= 'Washington',
	PostalCode		= '12345',
	Country			= 'United States',
	Phone			= '123.234.2346',
	Fax				= '343.234.3493';


-- UPDATE Rows That Exist Both in the Source and in our Customers Table --
-- But only if the source row has changed (is different than our row) --

	UPDATE dbo.Customers
	SET
		CustomerID 		= Staging.CustomerID, 
		CompanyName 	= Staging.CompanyName, 
		ContactName 	= Staging.ContactName, 
		ContactTitle 	= Staging.ContactTitle, 
		[Address] 		= Staging.[Address], 
		City 			= Staging.City, 
		Region 			= Staging.Region, 
		PostalCode 		= Staging.PostalCode, 
		Country 		= Staging.Country, 
		Phone 			= Staging.Phone, 
		Fax 			= Staging.Fax
		
	FROM
		(dbo.CustomerStaging AS Staging

		INNER JOIN dbo.Customers AS Custs
		ON (Staging.CustomerID = Custs.CustomerID))
		
	WHERE
		(
		(Staging.CustomerID 				<> Custs.CustomerID) 
		OR (Staging.CompanyName 			<> Custs.CompanyName)
		OR (Staging.ContactName	 			<> Custs.ContactName) 
		OR (Staging.ContactTitle 			<> Custs.ContactTitle)
		OR (ISNULL(Staging.[Address], '')	<> ISNULL(Custs.[Address], '')) --how all nullable rows should be done...
		OR (Staging.City 					<> Custs.City)
		OR (Staging.Region 					<> Custs.Region)
		OR (Staging.PostalCode 				<> Custs.PostalCode)
		OR (Staging.Country 				<> Custs.Country)
		OR (Staging.Phone 					<> Custs.Phone)
		OR (Staging.Fax 					<> Custs.Fax)
		);
		
-- Add rows that are in the source--but that we don't yet have

	INSERT INTO dbo.Customers
	(
	CustomerID, 
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
	SELECT
		Staging.CustomerID, 
		Staging.CompanyName, 
		Staging.ContactName, 
		Staging.ContactTitle, 
		Staging.[Address], 
		Staging.City, 
		Staging.Region, 
		Staging.PostalCode, 
		Staging.Country, 
		Staging.Phone, 
		Staging.Fax

	FROM (dbo.CustomerStaging AS Staging

		LEFT JOIN dbo.Customers AS Custs
		ON (Staging.CustomerID = Custs.CustomerID)
		)

	WHERE (Custs.CustomerID IS NULL);

-- Handle (Delete/change status, whatever) rows we have that source doesn't (any longer)

	-- Say we decide to keep rows deleted at the source, we might make a field to roll them to inactive
	ALTER TABLE dbo.Customers ADD blnActive bit NULL CONSTRAINT DF_dbo_Customers_Active DEFAULT(1); -- Affects only new inserts
	
	-- Hava a look at the new status field
	SELECT blnActive, * FROM Customers;
	
	-- Roll existing customers to active
	UPDATE dbo.Customers SET blnActive = 1
	
	-- Hava a look at the newly-populated status field
	SELECT blnActive, * FROM Customers;

	-- Roll customers missing in the source to inactive
	UPDATE dbo.Customers
	SET
		blnActive 	= 0

	FROM (dbo.Customers AS Custs

		LEFT JOIN dbo.CustomerStaging AS Staging
		ON (Custs.CustomerID = Staging.CustomerID))

	WHERE (Staging.CustomerID IS NULL);
	
	-- Hava a look at the newly-retired or inactivated rows
	SELECT blnActive, * FROM Customers WHERE blnActive = 0;
	
