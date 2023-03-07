//Only activates in one record accordinng to the trigger (before insert)

//My trigger not bulk
trigger MyTriggerNotBulk on Account (before insert) 
{
    Account a = Trigger.New[0];
    a.Description = 'New Description';

}


//Version of the trigger that activates on multiple records

trigger MyTriggerBulk on Account (before insert) 
{
    for(Account a:Trigger.New)
    {
        a.Description = 'New description';
    }

}

//Version of the trigger that acts on bulk records

trigger SoqlTriggerNotBulk on Account (after update) 
{
    //Trigger.New filters the records to records where the trigger was applied(after update onn Accounts)
    for(Account a: Trigger.New)
    {
        //Get child records for each account
        //Ineffficient SOQL query as it runs once for each account!
        Opportunity[] opps =[SELECT Id, Name, CloseDate FROM Opportunity WHERE AccountId=:a.Id];
    }

}


//Version of the trigger that's efficient with SOQL queries

trigger SoqlTriggerBulk on Account(after update)
{
    //Perform SOQL query once
    //Get the accounts and their related oppotunities

    List<Account> acctWithOpps = [SELECT Id,(SELECT Id, Name, CloseDate From Opportunities)FROM Account WHERE ID IN:Trigger.New];

    //Iterate over the returned accounts
    for(Account a : acctWithOpps)
    {
        Opportunity[] relatedOpps = a.Opportunities;
        //Do some processing
    }
}


//Version that doesnt fetch the related parent accounts records

trigger SoqlTriggerBulk on Account(after update)
{
    //Perform SOQL query once
    //Get relaeted opportunities for the account in this trigger.
    List<Opportunity> related Opps = [SELECT Id, Name, CloseDate FROM Opportunity WHERE AccountId IN:Trigger.New];

    //Iterate over the related opportunities
    for(Opportunity opp:relatedOpps)
    {
        //Do some voodo magic with these records
    }
}

//Another exmaple rewritten to use less code

trigger SoqlTriggerBulk on Account(after update)
{
    //Perform SOQL query once
    //Get the related records for the accounts in this trigger
    //iterate over those records

    for(Opportunity opp : [SELECT Id, Name, CloseDate FROM Opportunity WHERE AccountId IN : Trigger.New])
    {
        //perform action in here
    }
}

/*
* Triggers execute on batches of 200 records at a time so if 400 records cause a trigger to fitre the trigger
*   fires twice once for each 200 records.
* When performing DML calls in a trigger or in a class perform DML calls on a collection of sObjects whenever
*   possible. Apex runtime allows up to 150 DML calls in one transaction
*/

//   V  Inefficient DML call using triggers example  V

trigger DmlTriggerNotBulk on Account(after update) {   
    // Get the related opportunities for the accounts in this trigger.        
    List<Opportunity> relatedOpps = [SELECT Id,Name,Probability FROM Opportunity
        WHERE AccountId IN :Trigger.New];          
    // Iterate over the related opportunities
    for(Opportunity opp : relatedOpps) {      
        // Update the description when probability is greater 
        // than 50% but less than 100% 
        if ((opp.Probability >= 50) && (opp.Probability < 100)) {
            opp.Description = 'New description for opportunity.';
            // Update once for each opportunity -- not efficient!
            update opp;
        }
    }    
}

//Fixed code example that uses efficient DML transactions
//Uses a condition statement to add items to a collection
//at the end the collection is pushed in a single DML statement

trigger DmlTriggerBulk on Account(after update) {   
    // Get the related opportunities for the accounts in this trigger.        
    List<Opportunity> relatedOpps = [SELECT Id,Name,Probability FROM Opportunity
        WHERE AccountId IN :Trigger.New];
          
    List<Opportunity> oppsToUpdate = new List<Opportunity>();
    // Iterate over the related opportunities
    for(Opportunity opp : relatedOpps) {      
        // Update the description when probability is greater 
        // than 50% but less than 100% 
        if ((opp.Probability >= 50) && (opp.Probability < 100)) {
            opp.Description = 'New description for opportunity.';
            oppsToUpdate.add(opp);
        }
    }
    
    // Perform DML on a collection
    update oppsToUpdate;
}