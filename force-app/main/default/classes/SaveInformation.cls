public without sharing class SaveInformation {
    @AuraEnabled
    public static void saveIdInformation(String idNumber){
        South_Africa_ID__c[] sa = [SELECT Id, Number_of_Visits__c
                                 FROM South_Africa_ID__c
                                 WHERE ID_Number__c = :idNumber
                                ];
        
        if(sa.size()  > 0){
            sa[0].Number_of_Visits__c += 1;
            update sa;
        }else{
            South_Africa_ID__c saNew = new South_Africa_ID__c();
            saNew.ID_Number__c = idNumber;
            saNew.Number_of_Visits__c = 1;
            saNew.Date_of_Birth__c = getDate(idNumber.substring(0, 6));
            saNew.Gender__c = Integer.valueOf(idNumber.substring(6, 10)) < 5000 ? 'Female': 'Male';
            saNew.SA_Citizen__c = Integer.valueOf(idNumber.substring(10, 11)) == 1? 'Permanent_Resident':'SA_Citizen';
            insert saNew;

        }
    }

    public static Date getDate(String strDate){
        Integer currentYear = Integer.valueOf(String.valueOf(Date.Today().Year()).right(2));
        Integer intYear = Integer.valueOf(strDate.substring(0,2));

        String fullYear = intYear <= currentYear ? '20':'19';
        fullYear += strDate.substring(0,2);

        Date getDOB = Date.newInstance(Integer.valueOf(fullYear), Integer.valueOf(strDate.substring(2,4)), Integer.valueOf(strDate.substring(4,6)));

        return getDOB;

    }
}
