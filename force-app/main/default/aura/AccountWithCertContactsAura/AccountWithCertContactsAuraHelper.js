({
    // helper function for sending new account data to apex
    sendDataToApex: function (component) {
        const objToSend = {
            newAccount: JSON.stringify({
                accountName: component.get("v.account"),
                newContacts: JSON.parse(JSON.stringify(component.get("v.contacts")))
            })
        };

        // call controller method
        var action = component.get('c.addNewAccount');              // set action as method from controller
        action.setParams({ newAccount: objToSend });                // set parameters to send (new account data)
        action.setCallback(this, function(response) {               // set callback on recieving
            var state = response.getState();
            if (state === "SUCCESS") {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title: 'Create New Account',
                    message: 'New Account created successfully!',
                    type: 'success'
                });
                toastEvent.fire();
            }
            else {
                const err = response.getError()[0];
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title: err.pageErrors[0].statusCode.split('_').join(' '),
                    message: err.pageErrors[0].message,
                    type: 'error'
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    }
})
