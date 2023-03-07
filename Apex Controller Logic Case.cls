public class NewCaseListController 
{
    public List<Case> getNewCases()
    {
        List<Case> caseList = [SELECT Id, CaseNumber FROM Case Where Status='New'];
        return caseList;
    }
}