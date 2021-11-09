public class ExpiredTaskNotificationBatch implements Database.Batchable<SObject>, Database.Stateful {
    private final Date CONTROL_DATE = Date.today();
    private final String query = 
        'SELECT Id, ' +
        'OwnerId ' +
        'FROM Task '+
        'WHERE ActivityDate < :CONTROL_DATE AND Status = \'' + Constants.TASK_STATUS_NEW + '\'';
    private Map<Id, String> tasksWithOwner = new Map<Id, String>();
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc, List<Task> tasks) {
        for (Task task :tasks) {
            tasksWithOwner.put(task.Id, task.OwnerId);
        }
    }
    
    public void finish(Database.BatchableContext bc) {
        CustomNotificationType notificationType = [
            SELECT Id,
                   DeveloperName
            FROM CustomNotificationType 
            WHERE DeveloperName='Expire_Task_Notification'
        ];
        
        for(Id key :tasksWithOwner.keySet()) {
            Messaging.CustomNotification notification = new Messaging.CustomNotification();
            notification.setTitle(System.Label.Task_Notification_Title);
            notification.setBody(System.Label.Task_Notification_Body);
            notification.setNotificationTypeId(notificationType.Id);
            notification.setTargetId(key);
            Set<String > recipientsIds = new Set<String>();
            String ownerId = tasksWithOwner.get(key);
            recipientsIds.add(ownerId);
            try {
                notification.send(recipientsIds);
            }
            catch (Exception e) {
                System.debug(Constants.ERROR_PROBLEM_SENDING_NOTIFICATION + e.getMessage());
            }
        }      
    }
}