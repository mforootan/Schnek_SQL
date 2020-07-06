
-- OPENXML (Transact-SQL)
-- http://msdn.microsoft.com/en-us/library/ms186918.aspx

DECLARE @idoc int;
DECLARE @doc varchar(1000);
SET @doc ='
<ROOT>
<Customer CustomerID="VINET" ContactName="Paul Henriot">
   <Order CustomerID="VINET" EmployeeID="5" OrderDate="1996-07-04T00:00:00">
      <OrderDetail OrderID="10248" ProductID="11" Quantity="12"/>
      <OrderDetail OrderID="10248" ProductID="42" Quantity="10"/>
   </Order>
</Customer>
<Customer CustomerID="LILAS" ContactName="Carlos Gonzlez">
   <Order CustomerID="LILAS" EmployeeID="3" OrderDate="1996-08-16T00:00:00">
      <OrderDetail OrderID="10283" ProductID="72" Quantity="3"/>
   </Order>
</Customer>
</ROOT>';

--Create an internal representation of the XML document
EXEC sp_xml_preparedocument @idoc OUTPUT, @doc;

-- Execute a SELECT statement that uses the OPENXML rowset provider
SELECT    *
FROM OPENXML (@idoc, '/ROOT/Customer', 1) --0 or 1 is attribute-centric by default, 2 is element-centric
            WITH (
					CustomerID  varchar(10) 'CustomerID',
					ContactName varchar(20) '@ContactName',
					OrderDate datetime2 './Order'
                  );