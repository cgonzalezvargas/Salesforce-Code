//Working with sObjects

//the data type of the acc is Account

//Declaration of a new object

Accounnt acct = new Account();
//this is using the default constructor

//filling fields of the account object

Account acct = new Account(Name='Acme');

//Another example of filling more fields

Account acct = new Account(Name='Acme',Phone='(415)555-1212', NumberOfEmployees=100);

//Another exmaple using the constructor

Account acct = new Account();
acct.Name='Acme';
acct.Phone='(415)555-1212';
acct.NumberOfEmployees=100;


//sObjects can reference fields and records on their same object while using a generic sobject can reference all standard objects and customs

sObject sobj1 = new Account(Name='Trailhead');
sObject sobj2 = new Account(Name='Workbook 1');

//Generic sObject Reference to other objects and fields
/*
*                              Account
*                            /
*                          /
*                        /
*Generic sObject Variable - - - - - Book__c
*                        \
*                          \
*                            \
*                              Any standard or custom object record
*
*/

//Normal sObject Reference to other objects and fields

/*
* Account -------------------->  Account
*
* Book__c Variable ----------->  Book__c
*
* Account Variable     =/=       Any standard or custom object
*
* Book__c Variable     =/=       Any standard or custom object
*
*
*/

//Casting objects to another type of object (from generic--> standard & custom)

//Cast a generic sObject to an Account
Accounnt acct = (Account)myGenericSObject;
//you can use the dot notation to access fields on Account
String name = acct.Name;
String phone = acct.Phone;

// the fields of a generic sObject can be accessed only through put() & get() methods