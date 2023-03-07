/*
*   Working with SOQL and storing the results in other methods for manipulation
*
*
*/


public class ContactUtility
{
    public static void viewContacts()
    {
        List<Contact> listofContacts = [SELECT FirstName, LastName FROM Contact];
        for(Contact con: listofContacts)
        {
            String fullName = 'First Name: ' + con.FirstName + 'Last Name: ' + con.LastName;
            System.debug(fullName);
        }
    }
}
