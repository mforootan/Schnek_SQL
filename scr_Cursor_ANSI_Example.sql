
	USE Northwind; -- Switch to the Northwind database
	
	--------------------------------
	-- Employees Cursor Variables --
	--------------------------------

	DECLARE @strFirstName	nvarchar(10)
	DECLARE @strLastName	nvarchar(20)
	
	---------------------------------------------
	-- Build a cursor to iterate through each  --
	-- unprocessed Employees record in the table --
	---------------------------------------------

	DECLARE csrEmployees INSENSITIVE CURSOR FOR

	SELECT
		FirstName, 
		LastName	
	FROM
		dbo.Employees

	------------------------------------------------
	-- Open the cursor for the selected recordset --
	------------------------------------------------

	OPEN csrEmployees

	--------------------------------------------------
	-- Endlessly loop through all selected records  --
	-- (until break criterion detected within loop) --
	--------------------------------------------------

	WHILE (1 = 1) -- Always evaluates true
	BEGIN

	-------------------------------------------------------------
	-- Go fetch the first record (to set the fetchstatus flag) --
	-------------------------------------------------------------

		FETCH NEXT FROM csrEmployees INTO

			@strFirstName, 
			@strLastName
			
		IF (@@FETCH_STATUS = -1) BREAK --Exit endless loop when no rows left

		----------------------
		-- Do Something fun --
		----------------------

		DECLARE @strCommand nvarchar(255)

		-- SELECT @strCommand = 'NET SEND Chicago "Hi! ' + @strFirstName + '"' -- Windows XP/2003 or older
		-- http://www.petri.co.il/msg-exe-net-send-vista.htm
		SELECT @strCommand = 'MSG /server:%ComputerName% administrator "Hi from ' + @strFirstName + ' \"Fast Eddie\" ' + @strLastName + '!"'

		EXEC master.dbo.xp_cmdshell @strCommand
		
	END  -- Endess While Loop

	CLOSE csrEmployees

	DEALLOCATE csrEmployees

