public class PropertyUtility 
{
    public static void newListedProperties()
    {
        //Why does refering to an object sometimes done via the appending of __r at the rather than __c

        //all custom objects are referred by the __c and all custom relationship fields are referred by __r
        List<Property__c> newPropList = [SELECT Name, Broker__r.Email__c FROM Property__c WHERE Days_On_Market__c <= 30];
        for(Property__c pro: newPropList)
        {
            String propEmail = pro.Name + ' : ' + pro.Broker__r.Email__c;
            System.debug(propEmail);
        }
    }

}