public with sharing class WizardController {
    Account account;
    Contact contact;

    public Account getAccount() {
        if(account == null) account = new Account();
        return account;
    }

    public Contact getContact() {
        if(contact == null) contact = new Contact();
        return contact;
    }

    public PageReference accountPage() {
        return Page.WizardPage1;
    }

    public PageReference contactPage() {
        return Page.WizardPage2;
    }

    public PageReference previewPage() {
        return Page.WizardPage3;
    }

    public PageReference cancel() {
        PageReference accountPage = new PageReference('/001');
        accountPage.setRedirect(true);
        return accountPage;
    }

    public PageReference save() {

        insert account;

        contact.accountId = account.id;
        insert contact;

        PageReference accountPage = new ApexPages.StandardController(account).view();
        accountPage.setRedirect(true);

        return accountPage;
    }
}