// controller class to create new accounts
public inherited sharing class AddAccountRecordController {

    // wrapper class for incoming certificates
    public class NewCertificate {
        Integer index;
        String name;
        String url;
        String dateCert;
    }

    // wrapper class for incoming contacts
    public class NewContact {
        Integer index; 
        String name;
        List<NewCertificate> certificates;
    }

    // wrapper class for incoming accounts
    public class NewAccountToAdd {
        public String accountName;
        public List<NewContact> newContacts;
    }

    // function to add new account w/ certified contacts
    @AuraEnabled
    public static void addNewAccount(Map<String, String> newAccount){
        String newAccountJSON = newAccount.get('newAccount');
        NewAccountToAdd newAccountToAdd = (NewAccountToAdd) JSON.deserialize(newAccountJSON, NewAccountToAdd.class);
        System.debug(newAccountToAdd.newContacts[0].certificates[0].name);

        // new account
        Account account = new Account(
            Name = newAccountToAdd.accountName
        );
        insert account;

        // list of new contacts for account
        List<Contact> contactsToAdd = new List<Contact> ();
        for (NewContact thisContactToAdd : newAccountToAdd.newContacts) {
            Contact thisContact = new Contact (
                LastName = thisContactToAdd.name
                ,AccountId = account.id
            );
            contactsToAdd.add(thisContact);
            insert thisContact;

            // list of new certificates for each new contact added to account
            List<Contact_Certificate__c> certificatesToAdd = new List<Contact_Certificate__c> ();
            for (NewCertificate thisCertToAdd : thisContactToAdd.certificates) {
                Contact_Certificate__c thisCert = new Contact_Certificate__c (
                    Name = thisCertToAdd.name
                    ,Certification_URL__c = thisCertToAdd.url
                    ,Certified_On__c = Date.valueOf(thisCertToAdd.dateCert)
                    ,ContactId__c = thisContact.id
                );
                certificatesToAdd.add(thisCert);
            }
            insert certificatesToAdd;
        }
    }

}
