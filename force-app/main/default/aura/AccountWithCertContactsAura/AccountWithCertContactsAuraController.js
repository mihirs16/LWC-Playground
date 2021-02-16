({
    // add new contact field
    addContactField: function (component, event) {
        var contacts = component.get("v.contacts");

        contacts.push({
            index: contacts.length,
            name: '',
            certificates: [
                {
                    index: 0,
                    name: '',
                    url: '',
                    dateCert: ''
                }
            ]
        });

        component.set('v.contacts', contacts);
    },

    // add new component field
    addCertificateField: function (component, event) {
        const contactIndex = event.getSource().get('v.name');
        var contacts = component.get('v.contacts');

        contacts[contactIndex].certificates.push(
            {
                index: contacts[contactIndex].certificates.length,
                name: '',
                url: '',
                dateCert: ''
            }
        )

        component.set('v.contacts', contacts);
    },

    // to update account attribute from input field
    handleAccountInput: function (component, event) {
        var accountNameData = event.getSource().get("v.value");
        component.set('v.account', accountNameData.toString());
    },

    // to update contact attributes from input fields
    handleContactInput: function (component, event) {
        var contactsData = component.get("v.contacts");
        var newContactData = {
            value: event.getSource().get('v.value'),
            index: event.getSource().get('v.id')
        };

        contactsData[newContactData.index].name = newContactData.value;
        component.set('v.contacts', contactsData);
    },

    // to update certificates of contacts from input fields
    handleCertificateInput: function (component, event) {
        var contactsData = component.get("v.contacts");
        var newCertData = {
            contactIndex: event.getSource().get('v.id'),
            index: parseInt(event.getSource().get('v.name').split("_")[0]),
            value: event.getSource().get('v.value'),
            field: event.getSource().get('v.name').split("_")[1]
        }

        contactsData[newCertData.contactIndex].certificates[newCertData.index][newCertData.field] = newCertData.value;
    },

    // send data to apex for creating a new account
    createAccount: function (component, event, helper) {
        helper.sendDataToApex(component);
    }

})
