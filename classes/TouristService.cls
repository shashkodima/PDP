public class TouristService {
    
    @future
    public static void markDuplicatesAsync(Set<Id> newTouristIds) {
        List<Tourist__c> newTourists = TouristManager.getByIds(newTouristIds);
        List<String> names = new List<String>();
        List<String> mails = new List<String>();
        
        for (Tourist__c tourist : newTourists) {
            names.add(tourist.Name);
            mails.add(tourist.Tourist_EMail__c);
        }
        List<Tourist__c> duplicateTourists = TouristManager.getDuplicate(names, mails, newTouristIds);
        
        for (Tourist__c newTourist : newTourists) {
            for (Tourist__c duplicateTourist : duplicateTourists) {
                if (newTourist.Name == duplicateTourist.Name && newTourist.Tourist_EMail__c == duplicateTourist.Tourist_EMail__c) {
                    newTourist.IsDuplicate__c = true;
                }
            }
        }
        update newTourists;
    }
}