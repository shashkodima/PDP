public with sharing class SendEmailVFController {
    private final String contactId;
    public Contact contact {get; private set;}
    public String subject {get; set;}
    public String body {get; set;}

    public SendEmailVFController (ApexPages.StandardController controller) {
        contactId = (String)controller.getId();
        contact = contactId == null? new Contact() : [SELECT Name, AccountId, Phone, Email FROM Contact WHERE Id = :contactId];
    }

    public PageReference sendEmail() {
        Messaging.SingleEmailMessage newEmail = new Messaging.SingleEmailMessage();
        List<String> toAddresses = new List<String>{contact.Email};

        newEmail.setSubject(subject);
        newEmail.setToAddresses(toAddresses);
        newEmail.setPlainTextBody(body);

        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {newEmail});

        PageReference redirect = new ApexPages.StandardController(contact).view();

        return redirect;
    }

}