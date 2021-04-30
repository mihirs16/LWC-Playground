public with sharing class Manorama_SelectCity {

    public class SelCity {
        @AuraEnabled public List<Selected_City__c> lstSelCity;
    }

    public class RequestData {
        @AuraEnabled public List<String> city;
        @AuraEnabled public String pageArea;
        @AuraEnabled public String colorOption;
        @AuraEnabled public String printMedium;
    }

    public class RateCard {
        @AuraEnabled public String sno;
        @AuraEnabled public String city;
        @AuraEnabled public String print;
        @AuraEnabled public String pageArea;
        @AuraEnabled public String colorOption;
        @AuraEnabled public Decimal rate;
    }

    @AuraEnabled
    public static List<RateCard> calculateRateCard(String requestDataJSON) {
        
        Map<String, Decimal> cityMultiplier = new Map<String, Decimal>();
        cityMultiplier.put('delhi', 10.12);
        cityMultiplier.put('bangalore', 12.11);
        cityMultiplier.put('mumbai', 18.43);
        cityMultiplier.put('kochi', 8.21);
        cityMultiplier.put('chennai', 17.2);

        Map<String, Decimal> pageAreaMultiplier = new Map<String, Decimal>();
        pageAreaMultiplier.put('front_page', 10);
        pageAreaMultiplier.put('full_page', 8);
        pageAreaMultiplier.put('half_page', 5);
        pageAreaMultiplier.put('quarter_page', 3);

        Map<String, Decimal> printMultiplier = new Map<String, Decimal>();
        printMultiplier.put('daily', 7.5);
        printMultiplier.put('magazine', 6.2);

        Map<String, Decimal> colorMultiplier = new Map<String, Decimal>();
        colorMultiplier.put('color', 10);
        colorMultiplier.put('b_w', 5);

        Map<String, String> cityMap = new Map<String, String>();
        cityMap.put('delhi', 'Delhi');
        cityMap.put('bangalore', 'Bangalore');
        cityMap.put('mumbai', 'Mumbai');
        cityMap.put('kochi', 'Kochi');
        cityMap.put('chennai', 'Chennai');

        Map<String, String> pageAreaMap = new Map<String, String>();
        pageAreaMap.put('front_page', 'Front Page');
        pageAreaMap.put('full_page', 'Full Page');
        pageAreaMap.put('half_page', 'Half Page');
        pageAreaMap.put('quarter_page', 'Quarter Page');

        Map<String, String> printMap = new Map<String, String>();
        printMap.put('daily', 'Daily');
        printMap.put('magazine', 'Magazine');

        Map<String, String> colorMap = new Map<String, String>();
        colorMap.put('color', 'Colored');
        colorMap.put('b_w', 'Black and White');

        List<RateCard> rateCard = new List<RateCard>();

        System.debug('recvd --> ' + requestDataJSON);
        RequestData requestData = (RequestData) JSON.deserialize(requestDataJSON, RequestData.class);
        System.debug('reqst --> ' + requestData);

        if (requestData != null && requestData.city != null && requestData.printMedium != null && requestData.pageArea != null && requestData.colorOption != null) {

            for (Integer i = 0; i < requestData.city.size(); i++) {
                RateCard eachRateCard = new RateCard();
                eachRateCard.sno = String.valueOf(i);
                eachRateCard.city = cityMap.get(requestData.city[i]);
                eachRateCard.pageArea = pageAreaMap.get(requestData.pageArea);
                eachRateCard.print = printMap.get(requestData.printMedium);
                eachRateCard.colorOption = colorMap.get(requestData.colorOption);
                eachRateCard.rate = (
                    pageAreaMultiplier.get(requestData.pageArea) 
                    + printMultiplier.get(requestData.printMedium)
                    + colorMultiplier.get(requestData.colorOption)
                ) * cityMultiplier.get(requestData.city[i]);
    
                rateCard.add(eachRateCard);
            }

        }

        system.debug('rates --> ' + rateCard);
        return rateCard;
    }

    @AuraEnabled
    public static List<Selected_City__c> saveAsSelectedCity(String selCityJSON){
        
        System.debug('recvd --> ' + selCityJSON);
        SelCity selCity = (SelCity) JSON.deserialize(selCityJSON, SelCity.class);
        System.debug('reqst --> ' + selCity);

        insert selCity.lstSelCity;
        return selCity.lstSelCity;
    }
}
