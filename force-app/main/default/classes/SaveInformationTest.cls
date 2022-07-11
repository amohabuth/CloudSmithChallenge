@isTest
public class SaveInformationTest {
    
    @isTest
    static void testEnterNewId(){
        String idNum = '8610134800182';

        Test.startTest();
            SaveInformation.saveIdInformation(idNum);
            South_Africa_ID__c[] sa = [SELECT Id, Number_of_Visits__c
                                       FROM South_Africa_ID__c
                                       WHERE ID_Number__c = :idNum
                                      ];
            System.assertEquals(sa[0].Number_of_Visits__c, 1, 'Assertion Failed');
        Test.stopTest();

    }
}
