//Random name generator
public class RandomContactFactory 
{
    public static List<Contact> generateRandomContacts(integer genNum,String strlastName)
    {
        integer i = 1;
        List<Contact> conList = new List<Contact>();
        while(genNum >= i)
        {
            Contact con = new Contact(firstName='Test '+i,lastName=strlastName);
            conList.add(con);
            i++;
            
        }
        return conList;
    }

}