/*
*method to insert related accounts to the accounts sObject using a while loop
*/
public class NewAccounts
{
    public static void sObjectsInsert(Interger value)
    {
        Interger counter = 1;
        //create a list to add our accounts
        List<Account> teaFactoryAccounts = new List<Account>();
        while (counter <= value)
        {
            //display the current counter value
            System.debug('Counter Value before Incrementing ' + counter);
            //create new account
            Account store = new Account();
            //append counter to the object name for differentiation
            store.Name = 'The Tea Factory' + counter;
            store.AccountNumber = '35629' + counter;
            teaFactoryAccounts.add(store);
            System.debug(teaFactoryAccounts);
            //increment the counter
            counter = counter + 1;
            System.debug('Counter Value after incrementing ' + counter);
        }
        System.debug('Size of Account List ' + teaFactoryAccounts.size());
        System.debug('Elements in Account List: ' + teaFactoryAccounts);
        //insert all of the account in the list
        insert teaFactoryAccounts;
    }
}