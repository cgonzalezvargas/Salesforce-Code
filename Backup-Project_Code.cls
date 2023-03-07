
        for(Project__c callMap:proj_target)
        {
            //iterate through list and match the passed down record id with the id's for the users
            m.put(callMap.Id,callMap);
        }

        String id = 'a004S000007pkA5QAI';
List<Project__c> proj_target = getProjects(id);
Map<Project__c, String> m = new Map<Project__c, String>();
for(Project__c callMap:proj_target)
{
    //iterate through list and match the passed down record id with the id's for the users
    m.put(callMap,id);
}
System.debug(m);

System.debug(getProjects('a004S000007pkA5QAI'));



public static List<Project__c> getProjects(String recordId) 
{
    return [SELECT Project_Point_of_Contact__c, Project_Manager__c, Business_Owner__c, Project_Architect__c FROM Project__c WHERE Id = :recordId];
}

public static List<User> getEmployees()
{
    return [SELECT Id, Name, Email FROM User];
}
List<User> filteredEmployees = new List<User>();
for(User xuser : getEmployees())
{
    if(m. ==(xuser.Id))
    {
        System.debug(xuser.Id);
    }
}


<template>
     <template for:each={wired_filteredUsers.data} for:item="user">
         <p key={user.id}>
             {user.Name}
             {user.Email}
             {user.Phone}
             {user.Manager}
         </p>
     </template>