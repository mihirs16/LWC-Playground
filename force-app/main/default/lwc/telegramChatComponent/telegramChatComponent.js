import { LightningElement, track } from 'lwc';
import getAllMessages from '@salesforce/apex/TelegramMessageController.getAllMessages';


export default class TelegramChatComponent extends LightningElement {

    @track listOfMessages;
    @track error;

    renderedCallback () {
        getAllMessages()
        .then(result => {
            this.listOfMessages = result;
        })
        .catch(error => {
            this.error = error;
        });
    }
    
}