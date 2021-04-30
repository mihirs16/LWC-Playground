({
    selectMedium: function (component, event, helper) {
        if (component.get('v.SelectedMediumOptions').length > 0 && component.get('v.SelectedMediumOptions').includes('print')) {
            component.set('v.isMediumSelected', true);
            helper.updateProdList(component, event, helper);
        } else {
            component.set('v.isMediumSelected', false);
        }
    },

    selectCity: function (component, event, helper) {
        if (component.get('v.SelectedCityOptions').length > 0) {
            component.set('v.isCitySelected', true);
            helper.updateProdList(component, event, helper);
        } else {
            component.set('v.isCitySelected', false);
        }
    },

    selectPrint: function (component, event, helper) {
        if (component.get('v.SelectedPrintOptions')) {
            component.set('v.isPrintSelected', true);
            helper.updateProdList(component, event, helper);
        } else {
            component.set('v.isPrintSelected', false);
        }
    },

    selectPage: function (component, event, helper) {
        if (component.get('v.SelectedPageOptions')) {
            component.set('v.isPageSelected', true);
            helper.updateProdList(component, event, helper);
        } else {
            component.set('v.isPageSelected', false);
        }
    },

    selectColor: function (component, event, helper) {
        if (component.get('v.SelectedColorOptions')) {
            component.set('v.isColorSelected', true);
            helper.updateProdList(component, event, helper);
        } else {
            component.set('v.isColorSelected', false);
        }
    },
    
    handleCitySelect: function (component, event, helper) {
        var recordId = component.get('v.recordId');
        var selectedRows = event.getParam('selectedRows');
        console.log('selected rows --> ', selectedRows);
        var lstSelCity = [];
        for (var i = 0; i < selectedRows.length; i++) {
            lstSelCity.push({
                Opportunity__c: recordId,
                Cities__c: selectedRows[i].city,
                Print__c: selectedRows[i].print,
                Color__c: selectedRows[i].colorOption,
                Page_Area__c: selectedRows[i].pageArea,
                Rate__c: selectedRows[i].rate
            });
        }
        console.log(lstSelCity);
        component.set('v.SelectedCity', lstSelCity);
    },

    saveSelCity: function (component, event, helper) {
        console.log('saving cities...');
        helper.saveSelCity(component, event, helper);
    }
})
