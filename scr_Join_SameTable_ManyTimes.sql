

-- Sometimes you'll need to use the same table over and over again in the same query
-- Here's a little insight into how to get that done

-- Create a table do demo the circumstance

CREATE TABLE dbo.SalesTracking
(
intSalesPerson_ID	int		NOT NULL,
intCustCareRep_ID	int		NOT NULL,
intWarrantyMgr_ID	int		NOT NULL,
intClerk_ID			int		NOT NULL,
intOtherBozo_ID		int		NOT NULL
)

-- Put some rows of data into the table

INSERT INTO dbo.SalesTracking
(
intSalesPerson_ID,
intCustCareRep_ID,
intWarrantyMgr_ID,
intClerk_ID,
intOtherBozo_ID
)
SELECT 1, 2, 3, 4, 5 UNION
SELECT 6, 7, 8, 9, 2 UNION
SELECT 5, 4, 3, 2, 1 UNION
SELECT 9, 8, 7, 6, 5 UNION
SELECT 4, 4, 8, 8, 8 UNION
SELECT 6, 6, 6, 5, 7;

-- Display the result

SELECT
	Tracking.intSalesPerson_ID,
	SalesPerson.FirstName + ' ' + SalesPerson.LastName AS SalesPersonName,
	Tracking.intCustCareRep_ID,
	CustCareRep.FirstName + ' ' + CustCareRep.LastName AS CareRepName,
	Tracking.intWarrantyMgr_ID,
	WarrMgr.FirstName + ' ' + WarrMgr.LastName AS WarrMgrName,
	Tracking.intClerk_ID,
	Clerk.FirstName + ' ' + Clerk.LastName AS ClerkName,
	Tracking.intOtherBozo_ID,
	Bozo.FirstName + ' ' + Bozo.LastName AS BozoName


FROM (((((dbo.SalesTracking AS Tracking

	INNER JOIN dbo.Employees AS SalesPerson
	ON (Tracking.intSalesPerson_ID = SalesPerson.EmployeeID))
	
	INNER JOIN dbo.Employees AS CustCareRep
	ON (Tracking.intCustCareRep_ID = CustCareRep.EmployeeID))
	
	INNER JOIN dbo.Employees AS WarrMgr
	ON (Tracking.intWarrantyMgr_ID = WarrMgr.EmployeeID))
	
	INNER JOIN dbo.Employees AS Clerk
	ON (Tracking.intClerk_ID = Clerk.EmployeeID))
	
	INNER JOIN dbo.Employees AS Bozo
	ON (Tracking.intOtherBozo_ID = Bozo.EmployeeID))




