// global var
const DEBUG_MODE = true;

// module imports
import { LightningElement, track, wire } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

// wire service imports
import apexAddNewAccount from '@salesforce/apex/AddAccountRecordController.addNewAccount';

// export component
export default class CreateAccountWithCertifiedContact extends LightningElement {
    
    // account data
    @track account = {
        name: ''
    };
    
    // contacts data
    @track contacts = [
        {
            index: 0,
            name: '',
            certificates: [
                {
                    index: 0,
                    name: '',
                    url: '',
                    dateCert: ''
                }
            ]
        }
    ];
    
    // debug object values
    debugObject (obj, onConsole = DEBUG_MODE) {
        var resolvedObj = JSON.parse(JSON.stringify(obj));
        if (onConsole) {
            console.log(resolvedObj);
        }
        return resolvedObj;
    }

    // handle account lightning-input
    handleAccountInput (event) {
        this.account.id = event.target.value;
        this.debugObject(this.account);
    }

    // handle contact list lightning-input
    handleContactInput (event) {
        this.contacts[event.target.dataset.id].name = event.target.value;
        this.debugObject(this.contacts);
    }

    handleCertificateInput (event) {
        const contactIndex = event.target.dataset.contactindex;
        const certificateIndex = event.target.dataset.certindex;
        const thisElement = event.target.dataset.id;

        this.contacts[contactIndex].certificates[certificateIndex][thisElement] = event.target.value;
        this.debugObject(this.contacts);
    }

    // add new contact field
    addContactField () {
        this.contacts.push(
            {
                index: this.contacts.length,
                name: '',
                certificates: [
                    {
                        index: 0,
                        name: '',
                        url: '',
                        dateCert: ''
                    }
                ]
            }
        )

        this.debugObject(this.contacts);
    }

    // add new contact field
    addCertificateField (event) {
        const contactIndex = event.target.dataset.index;

        this.contacts[contactIndex].certificates.push(
            {
                index: this.contacts[contactIndex].certificates.length,
                name: '',
                url: '',
                dateCert: ''
                
            }
        )

        this.debugObject(this.contacts[contactIndex].certificates);
    }

    // send data to apex for creating a new account
    createAccount () {
        const objToSend = {
            newAccount: {
                accountName: this.account.name,
                newContacts: this.debugObject(this.contacts)
            }
        }

        console.log(objToSend);
    }

}