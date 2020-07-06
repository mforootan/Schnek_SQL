



MERGE dbo.Employees AS target

    USING (
			SELECT 
				'BillyJoe',
				'Royal'
    
		) AS source (FirstName, LastName)
		
    ON (Source.FirstName = target.FirstName)
    AND (Source.LastName = target.LastName)
    
   -- WHEN MATCHED THEN 
   --     UPDATE SET 
			--FirstName = source.Name
        
	WHEN NOT MATCHED THEN	
	
	    INSERT (FirstName, LastName)
	    VALUES (Source.FirstName, Source.FirstName)
	    
	OUTPUT deleted.*, $action, inserted.*;

	