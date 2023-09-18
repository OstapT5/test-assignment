public with sharing class EmailSettingsNameUpdateController {
    
    @AuraEnabled
    public static string getCurrentName() {
        return [SELECT Id, Name, SenderName FROM User WHERE Id =: UserInfo.getUserId()].SenderName;
    }

    @AuraEnabled
    public static void setNewName(String newName) {
        User u = [SELECT Id, Name, SenderName FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
        u.SenderName = newName;
        update u;
    }
}