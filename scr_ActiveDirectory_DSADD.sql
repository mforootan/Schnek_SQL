

-- Create command-line DSADD commands to add users to Active Directory

USE Pubs;


SELECT
 'DSADD USER "CN=' + au_fname + au_lname + ',OU=NewHires,DC=Acme,DC=Com" ' 
 + '-samid ' + au_fname + au_lname + ' '
 + '-upn "' + au_fname + au_lname + '@Acme.Com" ' 
 + '-fn "' + au_fname + '" ' 
 + '-ln "' + au_lname + '" ' 
 + '-display "' + au_fname + ' ' + au_lname + '" '
 + '-pwd "Pa$$w0rd" ' 
 + '-desc "' + au_fname + ' ' +  au_lname + ' user account" ' 
 + '-email "' + au_fname + au_lname + '@Acme.com" ' 
 + '-company "Acme, Inc." ' 
 + '-mustchpwd yes ' 
 + '-canchpwd yes ' 
 + '-pwdneverexpires no ' 
 + '-disabled no ' AS DsAddCommand
 
 FROM dbo.Authors
