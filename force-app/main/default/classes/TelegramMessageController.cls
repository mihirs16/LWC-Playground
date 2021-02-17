// controller for fetching telegram message(s)
public inherited sharing class TelegramMessageController {

    @AuraEnabled
    public static List<Telegram_Bot_Message__c> getAllMessages (){
        return [SELECT Id, Name, Message__c FROM Telegram_Bot_Message__c];
    }

}