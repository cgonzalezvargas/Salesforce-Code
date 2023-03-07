//Test Apex Triggers

trigger RestrictContactByName on Contact (before insert, before update) 
{
	
	//check contacts prior to insert or update for invalid data
	For (Contact c : Trigger.New) 
    {
		if(c.LastName == 'INVALIDNAME') {	//invalidname is invalid
			c.AddError('The Last Name "'+c.LastName+'" is not allowed for DML');
		}

	}



}

@isTest
public class TestRestrictContactByName 
{
    @isTest static void testSchlomo()
    {
        Contact test1 = new Contact(firstName='Schlomo',lastName='Jenkins');
        Contact test2 = new Contact(firstName='Schlomo',lastName='INVALIDNAME');
        List<Contact> testList = new List<Contact>();
        testList.add(test1);
        testList.add(test2);
        insert testList;
        insert test1;
        insert test2;
        
    }

}