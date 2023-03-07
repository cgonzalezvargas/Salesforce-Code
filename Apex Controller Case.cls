<apex:page controller="NewCaseListController">
    <apex:form >
    	<apex:pageBlock title="New Cases">
    		<apex:repeat value="{! NewCases}" var="case" rendered="true">
                <li>
                    <apex:outputLink value="/{! case.ID}">{! case.CaseNumber}
                    </apex:outputLink>
                </li>
    		</apex:repeat>
    	</apex:pageBlock>
	</apex:form>
</apex:page>