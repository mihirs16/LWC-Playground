public inherited sharing class AddAccountRecordController {

    public class NewCertificate {
        Integer index;
        String name;
        String url;
        String dateCert;
    }

    public class NewContact {
        Integer index; 
        String name;
        List<NewCertificate> certificates;
    }

    public class NewAccount {
        String accountName;
        List<NewContact> newContacts;
    }

    @AuraEnabled
    public static void addNewAccount(NewAccount newAccount){

        System.debug(newAccount);

    }
}
