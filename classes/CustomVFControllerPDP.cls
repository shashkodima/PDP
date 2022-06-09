public with sharing class CustomVFControllerPDP {
    public Account accountRecord { get; private set; }

    public CustomVFControllerPDP() {
        Id recordId = ApexPages.currentPage().getParameters().get('id');
        accountRecord = recordId == null? new Account() : [SELECT Name, Phone, BillingPostalCode FROM Account WHERE Id = :recordId];
    }

    public Account getAccount() {
        return accountRecord;
    }

    public PageReference saveAccount() {
        try {
            upsert accountRecord;
        } catch (Exception ex) {
            ApexPages.addMessages(ex);
            return null;
        }
        PageReference successResult = new ApexPages.StandardController(accountRecord).view();

        return successResult;
    }
}