
	USE Northwind; -- Switch to the Northwind database

	-- Flow control: a simple program loop

	DECLARE @intSomeValue integer;

	SELECT @intSomeValue = 1;

	WHILE (@intSomeValue < 100)
	BEGIN

		PRINT @intSomeValue;
		SELECT @intSomeValue = @intSomeValue + 1;

	END
