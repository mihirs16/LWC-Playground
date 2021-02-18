// controller for fetching telegram message(s)
public with sharing class TelegramMessageController {

    // fetch received messages
    public static List<Telegram_Message__c> getAllMessages (){
        return [SELECT Id, Name, Message__c FROM Telegram_Message__c];
    }

    // save the reply to a telegram message
    public static Telegram_Reply__c replyToMessage (String replyText, Telegram_Message__c messageToReply) {

        Telegram_Reply__c replyToSend = new Telegram_Reply__c (
            Message__c = replyText
            ,Telegram_Feed__c = messageToReply.Telegram_Feed__c
            ,OriginalMessageId__c = messageToReply.Id
            ,Name = messageToReply.Name + '_Reply'
        );
        insert Telegram_Reply__c;

    }

    // send a reply to the the telegram message
    public static Boolean sendReply (Telegram_Reply__c replyToSend) {

        Http http = new Http ();
        HttpRequest request = new HttpRequest ();
        
        Integer chatId = replyToSend.Telegram_Feed__c.ChatId__c;    // chat - id
        String textReply = replyToSend.Message__c;                  // text
        Integer messageId = replyToSend.OriginalMessageId__c        // message to reply - id
        String botToken = // bot-id


    }

}
