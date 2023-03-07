//SOQL Queries

/*
*   To read records from Salesforce you have to read data using SOQL
*   SOQL is similiar in syntax to SQL and interacts with Salesforce Directly
*   Since the interaction is direct SOQL queries can be embedded in APEX
*   These statements are referred as inline SOQL
*   Example of using SOQL to query Salesforce and embed the results in an array of sObjects
*/

Account[] accts = [SELECT Name, Phone FROM Account];

//Some queries in this unit expect the org to have account and contacts. Make sample data available

//Add account and related contact

Account acct = new Account
(
    Name='SDFC Computing',
    Phone='(415)555-1212',
    NumberOfEmployees=50,
    BillingCity='San Francisco'
);

insert acct;

//Once the account is inserted, the sObject will be populated with an ID
//Get this ID

ID acctID= acct.ID;
//Add contact to this account

Contact con = new Contact
(
    FirstName='Carol',
    LastName='Ruiz',
    Phone='(415)555-1212',
    Department='Wingo',
    AccountId=acctID
);

insert con;

//Add account with no contact
Account acct2 = new Account
(
    Name='The SDFC Query Man',
    Phone='(310)555-1213',
    NumberOfEmployees=50,
    BillingCity='Los Angeles',
    Description='Expert in wing technologies.'
);
insert acct2;

//Filtering results using SOQL

SELECT Name, Phone FROM Account WHERE Name='SFDC Computing'

SELECT Name, Phone FROM Account WHERE(Name='SFDC Computing' AND NumberOfEmployees>25)

SELECT Name, Phone FROM Account WHERE(Name='SFDC Computing' OR (NumberOfEmployees>25 AND BillingCity='Los Angeles'))

//Ordering Query Results

SELECT Name, Phone FROM Account ORDER BY Name

SELECT Name, Phone FROM Account ORDER BY Name accts

SELECT Name,Phone FROM Account ORDER BY Name Description

//Limit the Number of Records Returned

Account oneAccountOnly = [SELECT Name, Phone FROM Account LIMIT 1];

//Example of Complete Statements

SELECT Name,Phone FROM Account 
                   WHERE (Name = 'SFDC Computing' AND NumberOfEmployees>25)
                   ORDER BY Name
                   LIMIT 10

Account[] accts = [SELECT Name,Phone FROM Account 
                   WHERE (Name='SFDC Computing' AND NumberOfEmployees>25)
                   ORDER BY Name
                   LIMIT 10];
System.debug(accts.size() + ' account(s) returned.');
// Write all account array info
System.debug(accts);


//Binding a variable to a SOQL statement for intelligent queries

String targetDepartment = 'Wingo';
Contact[] techContacts = [SELECT FirstName,LastName 
                          FROM Contact WHERE Department=:targetDepartment];