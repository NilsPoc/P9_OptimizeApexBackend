   @isTest 
  public class UpdateMultipleAccountTest{
    @TestSetup
    static void makeData(){

    //Tester +100 commandes 
    Account act = DataFactory.createAccount('TestAccount');
    insert act;

    Product2 prod2 = DataFactory.createProduct('Chemise Verte longue XYX', 'Chemise');
    insert prod2;

    PricebookEntry pbe = DataFactory.createPricebook (prod2.Id, 1020);
    insert pbe;

    List<Order> orders = DataFactory.createOrders (act.Id, 102);
    insert orders;

    List<OrderItem> ordItems = DataFactory.createOrderItems (orders, new Map<String, String>{'Product2ID'=>prod2.Id, 'PricebookEntryId'=>pbe.Id});
    insert ordItems; 
    }

    @istest
    static void updateMultipleAccountTurnoverTest(){

        List<Order> ordList = new List<Order>();
        ordList = [SELECT Id, Status FROM Order LIMIT 102];
        for(Order ord: ordList){
          ord.status = 'Ordered';
        }
      
        Test.startTest();
        Update ordList;
        Test.stopTest();

        Decimal result = ([SELECT Chiffre_d_affaire__c FROM Account WHERE Name = 'TestAccount' LIMIT 1].Chiffre_d_affaire__c); 
        system.assertEquals(153000, result, 'Order sum is equal to 153000, test ok');
    }

  }