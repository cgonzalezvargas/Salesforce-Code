//Exmaple of binding a variable to narrow down search within an SOQL query
Integer maxHomeValue = 200000;
List<Property__c> property = [SELECT Name, Price__c FROM Property__c WHERE Price__c < :maxHomeValue];

//Aggregate functions

//MIN() MAX() AVG() SUM()

//Can combine these aggregate functions with HAVING

SELECT MAX(Status__c), Broker__r.Name
FROM Property__c
GROUP BY Broker__r.Name
HAVING MAX(Status__c) = 'Closed'