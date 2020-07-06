

	-- I put together this template to use as boilerplate
	-- when I want to create a new cursor... suppose you 
	-- want to create a cursor to iterate over employee records...
	-- search and replace the XXXs in this document with
	-- the string "Employee" ... then salt to taste.


	-----------------------------------
	-- XXX Cursor Variables --
	-----------------------------------

	DECLARE @intXXX_ID		integer
	DECLARE @strXXXName		nvarchar(30)
	DECLARE @strSomeString	nvarchar(255)
	
	---------------------------------------------
	-- Build a cursor to iterate through each  --
	-- unprocessed XXX record in the table --
	---------------------------------------------

	DECLARE csrXXX INSENSITIVE CURSOR FOR

	SELECT
		intXXX_ID, 
		strXXXName, 
		strSomeString 
		
	FROM
		dbo.tblXXX
	WHERE
		(1 = 1) -- or whatever...

	------------------------------------------------
	-- Open the cursor for the selected recordset --
	------------------------------------------------

	OPEN csrXXX

	--------------------------------------------------
	-- Endlessly loop through all selected records  --
	-- (until break criterion detected within loop) --
	--------------------------------------------------

	WHILE (1 = 1) -- Always evaluates true
	BEGIN

	-------------------------------------------------------------
	-- Go fetch the first record (to set the fetchstatus flag) --
	-------------------------------------------------------------

		FETCH NEXT FROM csrXXX INTO

			@intXXX_ID, 
			@strXXXName, 
			@strSomeString 
			
		IF (@@FETCH_STATUS = -1) BREAK --Exit endless loop when no rows left

		---------------------------------------
		-- Put the stuff you want to do here --
		---------------------------------------
		
	END  -- Endess While Loop

	CLOSE csrXXX

	DEALLOCATE csrXXX

