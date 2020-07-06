


CREATE PROCEDURE dbo.prcSyncCustomers

AS
	DECLARE @strMessage nvarchar(440) = '';

-----------------------------------------------------------------------------
-- UPDATE rows that exist both in the Source table and the Customers Table --
-- But only if the source row has changed (is different the existing row). --
-----------------------------------------------------------------------------

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
		([Atlanta,7734].Northwind.dbo.CustomerStaging AS Staging

		INNER JOIN dbo.Customers AS Custs
		ON (Staging.CustomerID = Custs.CustomerID))
		
	WHERE
		( -- For want of delta detection data, timestamp, etc., compare all columns...

			(Staging.CustomerID 				<> Custs.CustomerID) 
			OR (Staging.CompanyName 			<> Custs.CompanyName)
			OR (Staging.ContactName	 			<> Custs.ContactName) 
			OR (Staging.ContactTitle 			<> Custs.ContactTitle)
			OR (ISNULL(Staging.[Address], '')	<> ISNULL(Custs.[Address], '')) --Nothing equals a NULL, not even a NULL
			OR (Staging.City 					<> Custs.City)
			OR (Staging.Region 					<> Custs.Region)
			OR (Staging.PostalCode 				<> Custs.PostalCode)
			OR (Staging.Country 				<> Custs.Country)
			OR (Staging.Phone 					<> Custs.Phone)
			OR (Staging.Fax 					<> Custs.Fax)
		);
		
		SELECT @strMessage = @strMessage + ' Updated ' + CONVERT(nvarchar, @@ROWCOUNT) + CHAR(13) + CHAR(10);
	
------------------------------------------------------------------------------
-- Add rows that are in the source--but that we don't yet have in our table --
------------------------------------------------------------------------------

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

	FROM ([Atlanta,7734].Northwind.dbo.CustomerStaging AS Staging

		LEFT JOIN dbo.Customers AS Custs
		ON (Staging.CustomerID = Custs.CustomerID))
		
	WHERE (Custs.CustomerID IS NULL);
	
	SELECT @strMessage = @strMessage + ' INSERTED ' + CONVERT(nvarchar, @@ROWCOUNT) + CHAR(13) + CHAR(10);

-------------------------------------------------------------------------------------------
-- Handle (Delete/change status, whatever) rows we have that source doesn't (any longer) --
-------------------------------------------------------------------------------------------

	-- Roll customers missing in the source to inactive status, for example

	UPDATE dbo.Customers
	SET
		blnActive 	= 0

	FROM (dbo.Customers AS Custs

		LEFT JOIN [Atlanta,7734].Northwind.dbo.CustomerStaging AS Staging
		ON (Custs.CustomerID = Staging.CustomerID))

	WHERE (Staging.CustomerID IS NULL);
	
	SELECT @strMessage = @strMessage + ' RETIRED ' + CONVERT(nvarchar, @@ROWCOUNT) + CHAR(13) + CHAR(10);
	
	SELECT @strMessage;

	
