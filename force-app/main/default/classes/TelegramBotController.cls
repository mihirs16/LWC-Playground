// public Rest API for handling Telegram Integration
@RestResource(urlMapping = '/telegram')
global class TelegramBotController {

    // recieve messages through a POST request
    // made by the telegram webhook
    @httpPost
    global static Boolean recieveMessage () {

        // deserialize object
        Map<String, Object> dataReceived = (Map<String, Object>) JSON.deserializeUntyped(RestContext.request.requestBody.toString());
        Map<String, Object> message = (Map<String, Object>) dataReceived.get('message');
        Map<String, Object> chat = (Map<String, Object>) message.get('chat');
        Map<String, Object> fromUser = (Map<String, Object>) message.get('from');

        // don't save message if bot or not
        if ((Boolean) fromUser.get('is_bot')) {
            return false;            
        }

        // save incoming message
        Telegram_Feed__c telegramFeed = getFeed (
            String.valueOf(chat.get('id')),
            String.valueOf(fromUser.get('id')), 
            String.valueOf(fromUser.get('first_name')
        ));
        Telegram_Message__c telegramMessage = new Telegram_Message__c (
            Message__c = (String) message.get('text')
            ,MessageId__c = (Integer) message.get('message_id')
            ,Telegram_Feed__c = telegramFeed.Id
            ,Name = String.valueOf(fromUser.get('id')) + '_' + String.valueOf(message.get('message_id'))
        );
        insert telegramMessage;

        return true;

    }

    // fetch or create feed with contact having the recieved telegram-id
    global static Telegram_Feed__c getFeed (String recvdChatId, String rcvdId, String rcvdLastName) {
        
        // fetch contacts w/ telegram-id
        Integer teleId = Integer.valueOf(rcvdId);
        List<Telegram_Feed__c> thisFeed = [SELECT Contact__c FROM Telegram_Feed__c WHERE Telegram_UserID__c = :teleId];

        // if no contact w/ telegram-id exists
        if (thisFeed.size() == 0) {
            
            // create new contact
            contact newContact = new Contact(
                LastName = rcvdLastName
            );
            insert newContact;

            // create new feed for contact
            thisFeed.add(new Telegram_Feed__c (
                Contact__c = newContact.Id
                ,Name = rcvdLastName
                ,Telegram_UserID__c = teleId
                ,ChatId__c = 
            ));            
            insert thisFeed[0];

        }

        return thisFeed[0];

    }

}
