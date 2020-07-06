
	USE Vehicles; -- Switch to the Vehicles database

	-- Using WITH Common Table Expression
	-- http://msdn.microsoft.com/en-us/library/ms175972.aspx

	-- a temporary named result set, known as a common table expression (CTE)


	WITH BestVehicles
	--(		
	--		intStockNumber, -- Column names optional if all query columns have unique names...
	--		strMake,
	--		strModel,
	--		intModelYear,
	--		strColor,
	--		strBodyType,
	--		intMileage
	--) 
	AS 
	(
		SELECT
			intStockNumber,
			strMake,
			strModel,
			intModelYear,
			strBodyType,
			strColor,
			intMileage
		FROM
			dbo.tblVehicles
	)

	SELECT
		HotSellers.intStockNumber,
		HotSellers.strMake,
		HotSellers.strModel,
		HotSellers.intModelYear,
		HotSellers.strBodyType,
		HotSellers.strColor,
		SimilarVehicles.intStockNumber	AS intAltStockNo,
		SimilarVehicles.intModelYear	AS intAltYear,
		SimilarVehicles.strColor		AS strAltColor

	FROM 
		(BestVehicles AS HotSellers

		LEFT JOIN BestVehicles AS SimilarVehicles

		ON (HotSellers.strMake = SimilarVehicles.strMake)
			AND (HotSellers.strModel = SimilarVehicles.strModel)
			AND (HotSellers.intStockNumber <> SimilarVehicles.intStockNumber))

	ORDER BY 
		HotSellers.strMake,
		HotSellers.strModel,
		HotSellers.intModelYear;


