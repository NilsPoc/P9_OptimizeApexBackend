@isTest
public with sharing class UpdateAccountsTest {
    @TestSetup
    static void makeData(){
    Account act = DataFactory.createAccount('TestAccount');
    insert act;

    Product2 prod2 = DataFactory.createProduct('Chemise Verte longue XYX', 'Chemise');
    insert prod2;

    PricebookEntry pbe = DataFactory.createPricebook (prod2.Id, 1020);
    insert pbe;

    List<Order> orders = DataFactory.createOrders (act.Id, 150);
    insert orders;

    List<OrderItem> ordItems = DataFactory.createOrderItems (orders, new Map<String, String>{'Product2ID'=>prod2.Id, 'PricebookEntryId'=>pbe.Id});
    insert ordItems; 
}

    @isTest
    static void testUpdateAccountBatch() {

        List<Order> orders = [SELECT Id, Status FROM Order LIMIT 150];
        for(Order ord: orders){
            ord.status = 'Ordered';
        }
        update orders;

        Test.startTest();
        UpdateAccounts c = new UpdateAccounts();
        Database.executeBatch(c);
        List<Account> accounts = [SELECT Id, Chiffre_d_affaire__c FROM Account LIMIT 1];
        system.assertEquals(225000, accounts[0].Chiffre_d_affaire__c, 'Turnover should be 225000, test ok'); 
        Test.stopTest();
    
    }
}
