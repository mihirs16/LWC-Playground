({
    updateProdList: function (component, event, helper) {
        var columns = [
            {label: 'City', fieldName: 'city', type: 'text'},
            {label: 'Print', fieldName: 'print', type: 'text'},
            {label: 'Page Area', fieldName: 'pageArea', type: 'text'},
            {label: 'Color', fieldName: 'colorOption', type: 'text'},
            {label: 'Rate', fieldName: 'rate', type: 'currency', typeAttributes: { currencyCode: 'INR' } }
        ];
        component.set('v.columns', columns);

        var selectedCities = component.get('v.SelectedCityOptions');
        var selectedPage = component.get('v.SelectedPageOptions');
        var selectedColor = component.get('v.SelectedColorOptions');
        var selectedPrint = component.get('v.SelectedPrintOptions');

        var action = component.get('c.calculateRateCard');
        action.setParams({
            requestDataJSON: JSON.stringify({
                city: selectedCities,
                pageArea: selectedPage,
                colorOption: selectedColor,
                printMedium: selectedPrint
            })
        }); 
        action.setCallback(this, function(response) {
            if(response.getState() == 'SUCCESS') {
                console.log(response.getReturnValue());
                component.set('v.data', response.getReturnValue());
            }
        });
        $A.enqueueAction(action);

    },

    saveSelCity: function (component, event, helper) {
        var rowsToSave = component.get('v.SelectedCity');
        
        var action = component.get('c.saveAsSelectedCity');
        action.setParams({
            selCityJSON: JSON.stringify({
                lstSelCity: rowsToSave
            })
        });
        action.setCallback(this, function(response) {
            if(response.getState() == 'SUCCESS') {
                console.log('saved-rows --> ' + response.getReturnValue());
                $A.get("e.force:closeQuickAction").fire();
                $A.get('e.force:refreshView').fire();
            }
        });
        $A.enqueueAction(action);
    }
})
