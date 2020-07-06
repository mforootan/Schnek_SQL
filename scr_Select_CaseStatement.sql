
	USE Northwind; -- Switch to the Northwind database

	SELECT
		CompanyName,
		Country,
		
		CASE
			WHEN (Country IN ('Canada', 'Mexico', 'USA')) THEN 'North America'
			WHEN (Country IN ('Argentina', 'Brazil','Venezuela')) THEN 'South America'
			WHEN (Country IN (
								'Austria', 
								'Belgium', 
								'Denmark', 
								'Finland', 
								'France', 
								'Germany', 
								'Ireland', 
								'Italy', 
								'Norway', 
								'Poland', 
								'Portugal', 
								'Spain', 
								'Sweden', 
								'Switzerland', 
								'UK')) THEN 'Europe'
							
			ELSE NULL -- Continent not specified
	
 		END AS Continent -- the "AS Continent" Gives the dynamically-generated column a name...
 		
	FROM
		dbo.Customers

 
