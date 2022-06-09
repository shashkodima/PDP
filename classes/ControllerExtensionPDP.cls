public with sharing class ControllerExtensionPDP {
    private final String accountId;
    private final Account account;
    public List<Account> foundAccounts{get;set;}
    public String name{get;set;}

    public ControllerExtensionPDP(ApexPages.StandardController controllerStandard) {
        this.accountId = (String)controllerStandard.getId();
        this.account = (Account)controllerStandard.getRecord();
    }

    public void getAccountByName() {
        if (name == null || name == '') {
            foundAccounts = new List<Account>();

            return;
        }
        String searchName = '%' + name + '%';
        foundAccounts = [
                SELECT Id,
                        Name,
                        Phone,
                        BillingPostalCode
                FROM Account
                WHERE Name LIKE :searchName
        ];
    }
}