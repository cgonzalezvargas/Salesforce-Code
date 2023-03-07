trigger ContextExampleTrigger on Account (before insert, after insert, after delete) 
{
    if(Trigger.isInsert)
    {
        //Process before insert
    }
    else if(Trigger.isAfter)
    {
        //Process after insert
    }
    else if(Trigger.isDelete)
    {
        //Process after delete
    }

}