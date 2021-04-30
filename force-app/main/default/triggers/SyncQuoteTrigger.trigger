/**
 * This trigger is only for demo purposes.
 * It has not been tested for edge cases.
 */

trigger SyncQuoteTrigger on Quote (after insert) {
    
    List<Quote_Line_City__c> qlCity = new List<Quote_Line_City__c>();
    for (Quote eachQ: Trigger.New) {

        // get list of selected cities from quote parent 
        Opportunity selCityToAdd = [SELECT Id, (SELECT Id, Cities__c, Rate__c FROM Selected_Cities__r) FROM Opportunity WHERE Id = :eachQ.OpportunityId]; 

        // add new qli w/ sel cities and quote
        for (Integer i = 0; i < selCityToAdd.Selected_Cities__r.size(); i++) {
            qlCity.add(new Quote_Line_City__c(
                Selected_City__c = selCityToAdd.Selected_Cities__r[i].Id,
                Quote__c = eachQ.Id,
                Rate__c = selCityToAdd.Selected_Cities__r[i].Rate__c
            ));
        }
    }

    insert qlCity;

}