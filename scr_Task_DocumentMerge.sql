
	USE Northwind; -- Switch to the Northwind database

	-- You can use SQL to merge traditional document text with column data... up to 8000 characters
	
	-- You'll first need to setup your query tool to display more than the typical 256 chars per column
	-- Query analyzer-->Tools-->Options-->QueryResults-->SQLServer-->ResultsToText-->MaxChars-->8000
	-- You'll need to exit and reenter Query Analyzer for the change to take effect
	
	-- Best viewed with "Results to Text" button selected (as opposed to Grid)
	
	SELECT
	
		'--------------------------------------------------------'  + CHAR(13) + CHAR(10)
		
		+ DATENAME(MONTH,CURRENT_TIMESTAMP) + ' ' 
		+ CONVERT(nvarchar, DAY(CURRENT_TIMESTAMP)) + ', ' 
		+ CONVERT(nvarchar, YEAR(CURRENT_TIMESTAMP)) + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
		+ 'Amalgamated Lemon Stands International, LLC' + CHAR(13) + CHAR(10)
		+ 'One Lemon Tree Plaza' + CHAR(13) + CHAR(10)
		+ 'Sour Town, USA 00000-9999' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
		+ TitleOfCourtesy + ' '
		+ FirstName + ' ' + LastName + CHAR(13) + CHAR(10)
		+ [Address] + CHAR(13) + CHAR(10)
		+ City  + ', '
		+ ISNULL(Region,'') + ' '
		+ ISNULL(PostalCode, '') + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
		+ 'Dear ' + FirstName + ',' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
		+ CHAR(9) + 'We would like to offer you the opportunity to participate in the company''s'
		+ CHAR(9) + '401K plan... assuming you''ll pony up the dough...' + CHAR(13) + CHAR(10)
		+ CHAR(9) + 'Blather blather...' + CHAR(13) + CHAR(10)
		
	FROM 
		dbo.Employees;
	
