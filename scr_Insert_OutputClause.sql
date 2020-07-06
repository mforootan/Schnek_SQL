
-- OUTPUT Clause (Transact-SQL)
-- http://msdn.microsoft.com/en-us/library/ms177564.aspx

DECLARE @tblNewHires TABLE
(
	EmployeeID	integer			NOT NULL,
	FirstName	nvarchar(10)	NOT NULL,
	LastName	nvarchar(20)	NOT NULL
);

INSERT INTO dbo.Employees
(
	FirstName,
	LastName
)
OUTPUT 
	inserted.EmployeeID,
	inserted.FirstName,
	inserted.LastName
INTO 
	@tblNewHires
VALUES
	('Alice','Cooper'),
	('Carlos','Santana'),
	('Chet','Adkins');
	
SELECT * FROM @tblNewHires;