<apex:page standardController="Account" recordSetVar="accounts">
    <apex:form >
        <apex:pageBlock title="Account List" id="accounts_list">
            Filter:
            <apex:selectList value="{! filterId }" size="1">
                <apex:selectOptions value="{! listViewOptions }"/>
                <apex:actionSupport event="onchange" reRender="accounts_list"/>
            </apex:selectList>
            <!-- Contacts List -->
            <apex:pageBlockTable value="{! accounts }" var="a">
                <apex:column value="{! a.Name }"/>
                <apex:column value="{! a.Owner.Contact.Name }"/>
                <apex:column value="{! a.AccountNumber }"/>
                <apex:column value="{! a.Industry }"/>
            </apex:pageBlockTable>
            <!-- Pagination -->
            <table style="width: 100%"><tr>
                <td>
                    Page: <apex:outputText value=" {!PageNumber} of {! CEILING(ResultSize / PageSize) }"/>
                </td>
                <td align="center">
                  <!-- Previous page -->
                    <!-- active -->
                    <apex:commandLink action="{! Previous }" value="« Previous"
                         rendered="{! HasPrevious }"/>
                    <!-- inactive (no earlier pages) -->
                    <apex:outputText style="color: #ccc;" value="« Previous"
                         rendered="{! NOT(HasPrevious) }"/>
                    &nbsp;&nbsp;
                    <!-- Next page -->
                    <!-- active -->
                    <apex:commandLink action="{! Next }" value="Next »"
                         rendered="{! HasNext }"/>
                    <!-- inactive (no more pages) -->
                    <apex:outputText style="color: #ccc;" value="Next »"
                         rendered="{! NOT(HasNext) }"/>
                                    </td>
                <td align="right">
                    Records per page:
                        <apex:selectList value="{! PageSize }" size="1">
                            <apex:selectOption itemValue="5" itemLabel="5"/>
                            <apex:selectOption itemValue="20" itemLabel="20"/>
                            <apex:actionSupport event="onchange" reRender="contacts_list"/>
</apex:selectList>
                </td>
            </tr></table>
        </apex:pageBlock>
        <apex:pageBlock >
        <apex:pageBlockSection >
        <apex:repeat value="{! accounts}" var="a" >
            <li>
                <apex:outputLink value="/{! a.ID}">{! a.ID}
                </apex:outputLink>
            </li>
            
        </apex:repeat>
            </apex:pageBlockSection>
        </apex:pageBlock>
    </apex:form>
</apex:page>