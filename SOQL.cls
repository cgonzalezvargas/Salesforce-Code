/*
* Looking in the object manager one can check the relationship between objects and that can be used for soql queries
*/

//Example of child to parent soql query

SELECT Name, Account.Name FROM Contact

//Another example of a SOQL query using one of the trailhead exercises

SELECT Contact.Name, Priority FROM Case

//This one works because contact is a child of the case object


//Example of a parent to child soql query

SELECT Name, (SELECT Name FROM Contacts) FROM Account

//in this last example I'm returning the accounts with their point of contacts becase contact is the child of account

//Another example of a Parent to child query that is more specific 

SELECT Name, (SELECT Name FROM Contacts) FROM Account

(SELECT AccountId FROM Contact WHERE LastName = ' Forbes')


//Filtered SOQL Query

SELECT Name, (SELECT Name FROM Contacts)
FROM Account
WHERE Id IN (SELECT AccountId FROM Contact WHERE LastName = 'Forbes')

//SOQL Queries for the dreamhouse

SELECT Address__c, Picture__c, Broker__c FROM Property__c

//SOQL Child to Parent Query

SELECT Address__c, Picture__c, Broker__c.Name FROM Property__c

SELECT Address__c, Picture__c, Broker__r.Name FROM Property__c

//SOQL Parent to Child Query

SELECT Name FROM Broker__c

SELECT Name, (SELECT Address__c, Price__c FROM Properties__r) FROM Broker__c