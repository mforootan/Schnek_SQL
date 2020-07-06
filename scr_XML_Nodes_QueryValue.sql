
USE Northwind;

DECLARE @xmlSampleData xml;
DECLARE @xmlEmp1 xml;
DECLARE @xmlEmp2 xml;
DECLARE @xmlEmp3 xml;
DECLARE @xmlEmp4 xml;

SET @xmlEmp1 = (SELECT * FROM dbo.Employees AS EmployeeData WHERE EmployeeID = 1 FOR XML AUTO, ELEMENTS );
SET @xmlEmp2 = (SELECT * FROM dbo.Employees AS EmployeeData WHERE EmployeeID = 2 FOR XML AUTO, ELEMENTS );
SET @xmlEmp3 = (SELECT * FROM dbo.Employees AS EmployeeData WHERE EmployeeID = 3 FOR XML AUTO, ELEMENTS );
SET @xmlEmp4 = (SELECT * FROM dbo.Employees AS EmployeeData WHERE EmployeeID = 4 FOR XML AUTO, ELEMENTS );

SET @xmlSampleData =
	N'<Employees>
		<Employee>
			<RecordNumber>1012</RecordNumber>'
			+ CONVERT(nvarchar(max), @xmlEmp1) + 
			'<Awards>
				<Award>Best Employee Ever</Award>
				<Award>Most Likely To Succeed</Award>
				<Award>Order of the Brown Nose</Award>
			</Awards>
		</Employee>
		<Employee>
			<RecordNumber>2222</RecordNumber>'
			+ CONVERT(nvarchar(max), @xmlEmp2) + 
			'<Awards>
				<Award>Employee of the Month, May 2000</Award>
				<Award>Employee of the Month, June 2008</Award>
			</Awards>
		</Employee>		
		<Employee>
			<RecordNumber>3087</RecordNumber>'
			+ CONVERT(nvarchar(max), @xmlEmp3) + 
			'<Awards>
				<Award>Employee of the Month, July 2002</Award>
			</Awards>
		</Employee>
		<Employee>
			<RecordNumber>4174</RecordNumber>'
			+ CONVERT(nvarchar(max), @xmlEmp4) + 
			'<Awards>
				<Award>Legion of Corporate Merit</Award>
			</Awards>
		</Employee>
	</Employees>';
	
SELECT
	C.value('RecordNumber[1]','int') AS RecordNumber,
	C.value('./EmployeeData[1]/EmployeeID[1]', 'int') AS EmployeeID,
	C.value('./EmployeeData[1]/LastName[1]', 'nvarchar(30)') AS EmployeeName,
	C.query('/Employees/Employee/Awards/*') AS Awards,
	C.query('*') AS Everything

FROM @xmlSampleData.nodes('/Employees/Employee') AS T(C);	














