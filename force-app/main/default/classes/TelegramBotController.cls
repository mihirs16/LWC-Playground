// public Rest API for handling Telegram Integration
@RestResource(urlMapping = '/telegram')
global inherited sharing class TelegramBotController {

    // recieve messages through a POST request
    // made by the telegram webhook
    @httpPost
    global static Telegram_Bot_Message__c recieveMessage () {

        // deserialize object
        Map<String, Object> dataReceived = (Map<String, Object>) JSON.deserializeUntyped(RestContext.request.requestBody.toString());
        Map<String, Object> message = (Map<String, Object>) dataReceived.get('message');
        Map<String, Object> chat = (Map<String, Object>) message.get('chat');
        Map<String, Object> fromUser = (Map<String, Object>) message.get('from');

        // create a new message record
        Telegram_Bot_Message__c newMessage = new Telegram_Bot_Message__c (
            Name = (String) fromUser.get('first_name')
            ,Message__c = (String) message.get('text')
        );

        // save message
        insert newMessage;
        return newMessage;

    }



}
