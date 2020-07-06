
	USE Vehicles; -- Switch to the Vehicles database
	
	-- Showing all the details for records of a particular aggregation is a two-step process
	-- First, find the records your interested in by writing an inner group-by query...
	-- Then join the result back to the raw detail records

	SELECT 
		VehiclesSummary.*,
		Details.*

	FROM (
			-- This query identifies the records you want
			SELECT
				strMake,
				strModel,
				COUNT(*) As Hits
			FROM 
				dbo.tblVehicles

			GROUP BY
				strMake,
				strModel
				
			HAVING 
				COUNT(*) > 10

		) AS VehiclesSummary

		INNER JOIN dbo.tblVehicles AS Details
		ON (VehiclesSummary.strMake = Details.strMake)
		AND (VehiclesSummary.strModel = Details.strModel);
		
		
	