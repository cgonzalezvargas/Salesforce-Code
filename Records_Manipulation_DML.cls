// Manipulate Records with DML

/*
* Operations available within DML 
*
* insert
* update
* upsert: creates new records and updates sObjects records within a single statement
* delete
* undelete
* merge:  statement merges up to three records of the same sObjet type into one of the records, deletes the others and reparenting records
*
*/

//Example of DML

//Create the account sObject
Account acct = new Account(Name='Acme', Phone='(415)555-1212', NumberOfEmployees=100);
//Insert the account by using DML
insert acct;


//When inserting records, the system assings an ID for each record. In addition to persisting the ID value in the database
//the ID value is also auto populated on the sObject variable that you used as an argument in the DML call

//Example shows how to get the ID on the sObject that corresponds to inserted account

//Create the account sObject
Account acct = new Account(Name='Acme', Phone='(415)555-1212',NumberOfEmployees=100);
//Insert the account by using DML
insert acct;
//Get the new ID on the inserted sObject argument
ID acctID= acct.Id;
//Display this ID in the debug log
System.debug('ID =' +acctID);
//Debug log result (the ID will be different in your case)
//DEBUG|ID = 001D000000JmKkeIAF


//Bulk DML
/*
* DML operations can be performed in a single sObject or in bulk list of sObjects
* Performing bulk operations is recommended because it avoid hitting the governor limits of 150
* per Apex transaction
*
* Performing one DML operation on a list of sObjects counts as one DML statement
* Not one statement for each sObject
* 
*/

//Example of bulk insertion

//Create a list of contacts
List<Contact> conList = new List<Contact>
{
    new Contact(FirstName='Joe',LastName='Smith',Department='Finance'),
    new Contact(FirstName='Kathy',LastName='Smith',Department='Technology'),
    new Contact(FirstName='Caroline',LastName='Roth',Department='Finance'),
    new Contact(FirstName='Kim',LastName='Shain',Department='Education')
};
//Bulk insert all contacts with one DML call
insert conList;
//List to hold the new contacts to update
List<Contact> listToUpdate = new List<Contact>();
//Iterate through the list and add a title only
//if the department is Finance
for(Contact con: conList)
{
    if(con.Department == 'Finance')
    {
        con.Title = 'Financial analyst';
        //add updated contact sObject to the list
        listToUpdate.add(con);
    }
}
//Bulk update all contacts with one DML call
update listToUpdate;

//////////////////////////////////////////////////////////////////////////////////V\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

//Upsert records if you have a list of mixed new and existing records you can process insertions and updates to all records in the list by using the upsert statement

//This statement matches the sObject with existing records by comparing values of one field, if none is specified it will use the objects ID

//For standard objects you can use any field that has the idLookup property set to true

//For custom objects specify a custom field marked as external ID

//Upsert Syntax

/*
* upsert sObject | sObject[]
* upsert sObject | sObject[] field
*/

//Example Statement

upsert sObjectList Account.Fields.MyExternalId;

//Decision tree

/*
*  key is not matched       -----------> new object record is created     
*
*  key is matched once      -----------> existing object record is updated
*
*  key match multiple times -----------> error generated, no object record inserted or updated
*                           
*/

//Example code

// Insert the Josh contact
Contact josh = new Contact(FirstName='Josh',LastName='Kaplan',Department='Finance');       
insert josh;
// Josh's record has been inserted
//   so the variable josh has now an ID
//   which will be used to match the records by upsert
josh.Description = 'Josh\'s record has been updated by the upsert operation.';
// Create the Kathy contact, but don't persist it in the database
Contact kathy = new Contact(FirstName='Kathy',LastName='Brown',Department='Technology');
// List to hold the new contacts to upsert
List<Contact> contacts = new List<Contact> { josh, kathy };
// Call upsert
upsert contacts;
// Result: Josh is updated and Kathy is created.

//Example code 2

Contact jane = new Contact(FirstName='Jane',
                         LastName='Smith',
                         Email='jane.smith@example.com',
                         Description='Contact of the day');
insert jane;
// 1. Upsert using an idLookup field
// Create a second sObject variable.
// This variable doesn’t have any ID set.
Contact jane2 = new Contact(FirstName='Jane',
                         LastName='Smith',  
                         Email='jane.smith@example.com',
                         Description='Prefers to be contacted by email.');
// Upsert the contact by using the idLookup field for matching.
upsert jane2 Contact.fields.Email;
// Verify that the contact has been updated
System.assertEquals('Prefers to be contacted by email.',
                   [SELECT Description FROM Contact WHERE Id=:jane.Id].Description);


/////////////////////////////////////////////////////////////////V\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//                                                        DELETE RECORDS

Contact[] contactsDel = [SELECT Id FROM Contact WHERE LastName='Smith'];
delete contactsDel;


////////////////////////////////////////////////////////////////V\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//                                                     EXCEPTION HANDLING

//Example code for handling DML Exceptions
try {
    // This causes an exception because 
    //   the required Name field is not provided.
    Account acct = new Account();
    // Insert the account 
    insert acct;
} catch (DmlException e) {
    System.debug('A DML exception has occurred: ' +
                e.getMessage());
}

////////////////////////////////////////////////////////////////V\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//                                                      DATABASE METHODS

/*
*
* Database.insert()
* Database.update()
* Database.upsert()
* Database.delete()
* Database.undelete()
* Database.merge()
*
* Unlike DML statements, database methods have an optional allOrNone parameter that allows you to specify whether the operation should partially succeed.
* If this is false the successful records will be committed and errors will be returned for failed records. ***No exceptions are thrown with the partial option
*/

//Calling the insert method with the allOrNone set to false

Database.insert(recordList, false);

//The database method return result objects containning success or failure information for each record

Database.SaveResult[] results = Database.insert(recordList, false);

//*By default the allOrNNone Parameter is true */

//Equivalent statements to insert recordList;

Database.insert(recordList);

Database.insert(recordList, true);

//Example code with Database methods for bulk transfer

// Create a list of contacts
List<Contact> conList = new List<Contact> {
        new Contact(FirstName='Joe',LastName='Smith',Department='Finance'),
        new Contact(FirstName='Kathy',LastName='Smith',Department='Technology'),
        new Contact(FirstName='Caroline',LastName='Roth',Department='Finance'),
        new Contact()};
// Bulk insert all contacts with one DML call
Database.SaveResult[] srList = Database.insert(conList, false);
// Iterate through each returned result
for (Database.SaveResult sr : srList) {
    if (sr.isSuccess()) {
        // Operation was successful, so get the ID of the record that was processed
        System.debug('Successfully inserted contact. Contact ID: ' + sr.getId());
    } else {
        // Operation failed, so get all errors
        for(Database.Error err : sr.getErrors()) {
            System.debug('The following error has occurred.');
            System.debug(err.getStatusCode() + ': ' + err.getMessage());
            System.debug('Contact fields that affected this error: ' + err.getFields());
	 }
    }
}


/* 
* Should you use DML statements or Database methods
* Use DML statements if you want any error that occurs to be thrown as an exception that interrupts control flow
*
* Use Database class methods if you want to allow partial success of a bulk DML operation if a record fails
* the remainder of the DML operation can still succeed
*/


/////////////////////////////////////////////////////V\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//                                       WORKING WITH RELATED RECORDS
//Insert related records

//Example code

Account acct = new Account(Name='SFDC Account');
insert acct;
// Once the account is inserted, the sObject will be 
// populated with an ID.
// Get this ID.
ID acctID = acct.ID;
// Add a contact to this account.
Contact mario = new Contact(
    FirstName='Mario',
    LastName='Ruiz',
    Phone='415.555.1212',
    AccountId=acctID);
insert mario;

//Update related records

// Query for the contact, which has been associated with an account.
Contact queriedContact = [SELECT Account.Name 
                          FROM Contact 
                          WHERE FirstName = 'Mario' AND LastName='Ruiz'
                          LIMIT 1];
// Update the contact's phone number
queriedContact.Phone = '(415)555-1213';
// Update the related account industry
queriedContact.Account.Industry = 'Technology';
// Make two separate calls 
// 1. This call is to update the contact's phone.
update queriedContact;
// 2. This call is to update the related account's Industry field.
update queriedContact.Account; 


//Delete related records

Account[] queriedAccounts = [SELECT Id FROM Account WHERE Name='SFDC Account'];
delete queriedAccounts;