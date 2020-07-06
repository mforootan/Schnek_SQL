
	USE Northwind; -- Switch to the Northwind database
	
	DECLARE @strTableYouWant varchar(30);
	SELECT @strTableYouWant = 'Customers';
	DECLARE @strExecuteThisString varchar(255);
	SELECT @strExecuteThisString = 'SELECT * FROM ' + @strTableYouWant;

	EXECUTE(@strExecuteThisString);



