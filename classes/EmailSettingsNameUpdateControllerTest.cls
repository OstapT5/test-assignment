@IsTest
public with sharing class EmailSettingsNameUpdateControllerTest {
    @TestSetup
    static void makeData(){
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        User u = new User(
            Alias = 'standt', 
            Email ='standarduser@testorg.com', 
            EmailEncodingKey = 'UTF-8', 
            LastName = 'TestUser', 
            LanguageLocaleKey = 'en_US', 
            LocaleSidKey = 'en_US', 
            ProfileId = p.Id, 
            TimeZoneSidKey = 'America/Los_Angeles', 
            UserName = 'standarduser@railsware.com',
            SenderName = 'TestName'
        );
        insert u;
    }

    @IsTest
    static void getCurrentNameTest() {
        User testUser = [SELECT Id FROM User WHERE LastName = 'TestUser' LIMIT 1];
        System.runAs(testUser) {
            String nameToVerify = EmailSettingsNameUpdateController.getCurrentName();
            Assert.areEqual('TestName', nameToVerify, 'Names should be equal');
        }
    }

    @IsTest
    static void setNewNameTest() {
        User testUser = [SELECT Id FROM User WHERE LastName = 'TestUser' LIMIT 1];
        System.runAs(testUser) {
            EmailSettingsNameUpdateController.setNewName('TestNameUpdate');
            String nameToVerify = EmailSettingsNameUpdateController.getCurrentName();
            Assert.areEqual('TestNameUpdate', nameToVerify, 'Name should be updated');
        }
    }
}