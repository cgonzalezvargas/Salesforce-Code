trigger ExampleTrigger on Contact (after insert, after delete) 
{
    if(Trigger.isInsert)
    {
        Integer recordCount = Trigger.New.size();
        //Call utility method from another class
    	
        EmailManager.sendMail('c.gonzalez@encetech.org', 'Trailhead Trigger Tutorial', recordCount + 'contact(s) were inserted.');
    }
    else if(Trigger.isDelete)
    {
       	Integer recordCount = Trigger.New.size();
        System.debug(recordCount +' Records deleted.');
    }

}