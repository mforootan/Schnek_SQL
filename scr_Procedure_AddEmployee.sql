
------------------------------------------------------------------
-- Calling the stored procedure defined later on in this script --
------------------------------------------------------------------

DECLARE @intEmpNoWeGotBack int = NULL;
DECLARE @intReturnValueWeGotBack int = NULL;


EXECUTE @intReturnValueWeGotBack = dbo.prcAddEmployee

	@intEmployeeID	= @intEmpNoWeGotBack OUTPUT,	
	@strFirstName	= 'BillyBob',
	@strLastName	= 'Thornton'	
	
SELECT 
	@intReturnValueWeGotBack AS ReturnValue, 
	@intEmpNoWeGotBack AS NewHireID, 
	Emps.* 
FROM 
	dbo.Employees  AS Emps
	
WHERE 
	(EmployeeID = @intEmpNoWeGotBack)

-----------------------------------------------------------------------------
-- You'll have to create the procedure (by executing the code that follows --
-- Before calling the code that executes this procedure (shown above)      --
-----------------------------------------------------------------------------

CREATE PROCEDURE dbo.prcAddEmployee
(
	@intEmployeeID	int				= NULL	OUTPUT,
	@strFirstName	nvarchar(10)	= NULL,
	@strLastName	nvarchar(20)	= NULL		
)
WITH ENCRYPTION

AS
	DECLARE @intErrorValue int = 0;
	DECLARE @intRowCount int = 0;
	DECLARE @intReturnValue int = 0;

	IF (@intEmployeeID IS NOT NULL)
	BEGIN
	
		------------------------------------------------------
		-- Attention all planets of the solar federation...	--
		-- We have assumed control of EmployeeIDs			--
		------------------------------------------------------
	
		SET IDENTITY_INSERT dbo.Employees ON;
	
		INSERT INTO dbo.Employees
		(
		EmployeeID,
		FirstName,
		LastName
		)
		SELECT
			@intEmployeeID AS EmployeeID,
			@strFirstName AS FirstName,
			@strLastName AS LastName;
			
		SELECT 
			@intErrorValue = @@ERROR,
			@intRowCount = @@ROWCOUNT;
			
		SET IDENTITY_INSERT dbo.Employees OFF;
		
	END		---------------------------------
	ELSE	-- Just autonumber the new guy --
	BEGIN	---------------------------------
	
		INSERT INTO dbo.Employees
		(
		FirstName,
		LastName
		)
		SELECT
			@strFirstName AS FirstName,
			@strLastName AS LastName;
			
		SELECT 
			@intErrorValue = @@ERROR,
			@intRowCount = @@ROWCOUNT,
			@intEmployeeID = SCOPE_IDENTITY();
	
	END
	
	-- Not because we should, but to prove we can...
	SELECT * FROM dbo.Employees WHERE (EmployeeID = @intEmployeeID);
	
	IF((@intRowCount = 1) AND (@intErrorValue = 0))
	BEGIN
		SELECT @intReturnValue = 0;
		RAISERROR('Things went wonderful!', 10, -1) WITH LOG;
	END
	ELSE	-- Stuff blew the big colorful chunks...
	BEGIN
		SELECT @intReturnValue = 3; -- or the actual error code, etc.
		RAISERROR('Things went awful!', 16, -1) WITH LOG;
	END

	RETURN(@intReturnValue);
	
GO
