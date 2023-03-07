//SOSL Queries


//Main difference is that while SOQL can query one object at a time, SOSL can query all of them

public class ContactAndLeadSearch 
{
    public static List<List<sObject>> searchContactsAndLeads(String inputPar)
    {
        List<List<sObject>> searchList = [FIND :inputPar IN ALL FIELDS RETURNING Contact(FirstName, LastName), Lead(FirstName, LastName) ];
        return searchList;
    }

}