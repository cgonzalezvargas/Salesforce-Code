// trigger to work on closed opportunities

trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) 
{   
    List<Task> taskList = new List<Task>();
    
    for(Opportunity opp : [SELECT Id, StageName FROM Opportunity WHERE StageName='Closed Won' AND Id IN: Trigger.New])
    {
        taskList.add(new Task(Subject='Follow Up Test Task',WhatId=opp.id));
    }
    
    if(taskList.size() != 0)
    {
        insert taskList;
    }

}