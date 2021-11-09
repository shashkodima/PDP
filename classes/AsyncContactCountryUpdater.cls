public class AsyncContactCountryUpdater implements Queueable, Database.AllowsCallouts {
    private Map<Id, Contact> contactsToUpdate;

    public AsyncContactCountryUpdater(Map<Id, Contact> contactsToUpdate) {
        this.contactsToUpdate = contactsToUpdate;
    }

    public void execute(QueueableContext context) {
        List<Contact> contactsWithCountry = new List<Contact>();

        for (Contact contact : contactsToUpdate.values()) {
            if (!String.isBlank(contact.Phone)) {
                Contact contactToUpdate = new Contact();
                try {
                    String contactCountry = CalloutHelper.findCountryByPhone(contact.Phone);
                    contactToUpdate.Id = contact.Id;
                    contactToUpdate.Country_from_Phone__c = contactCountry;
                    contactsWithCountry.add(contactToUpdate);
                } catch(CalloutHelper.PhoneFormatException ex) {
                    System.debug(LoggingLevel.ERROR, ex.getMessage());
                }
            }
        }
        update contactsWithCountry;
    }
}