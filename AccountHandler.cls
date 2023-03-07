public class AccountHandler
{
    public static void insertAccount(Integer accCount)
    {
        Integer counter = 1;
        List<Account> addAccounts = new List<Account>();
        while(counter <= accCount)
        {
            Account store = new Account();
            store.Name = 'Acme Inc ' + counter;
            store.AccountNumber = 'A000' + counter;

            addAccounts.add(store);
            counter++;
        }
        insert addAccounts;

    }
    public static Account insertNewAccount(String acctName)
    {
        try
        {
        Account newAcct = new Account();
        newAcct.Name = acctName;
        
        
        insert newAcct;
        return newAcct;
        }
        catch(DmlException e)
        {
            System.debug('A DML exception has ocurred ' + e.getMessage());
            return null;
        }
        
    }
}