/*
*   Snippet of code used to mass update parent Accounts on VA related accounts
*
*/
List<Account> updateList = [SELECT Id, Name FROM Account WHERE Type = 'Acute Care - Veterans Administration'];
List<Account> updatedList = new List<Account>();

for(Account bro:updateList)
{
    Account store1 = new Account();
    store1.ParentId = '0014S00000AayHoQAJ';
    store1.Id = bro.Id;
    updatedList.add(store1);
    
}
upsert updatedList;

SELECT Id, Name FROM Account WHERE Type = 'Acute Care - Veterans Administration'mD0cZC_l7M0HG7gpj08BAA