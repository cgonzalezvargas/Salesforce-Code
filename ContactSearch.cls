public class ContactSearch 
{
    public static List<Contact> searchForContacts(String lastName, String zipCode)
    {
        List<Contact> conList =[SELECT Name, ID FROM Contact WHERE (LastName=:lastName AND MailingPostalCode=:zipCode)];
        return conList;
        
    }

}