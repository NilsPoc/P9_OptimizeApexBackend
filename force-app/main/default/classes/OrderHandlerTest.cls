@isTest 
public class OrderHandlerTest{
  @TestSetup
  static void makeData(){

    Account act = DataFactory.createAccount('TestAccount');
    insert act;

    Product2 prod2 = DataFactory.createProduct('Chemise Verte longue XYX', 'Chemise');
    insert prod2;

    PricebookEntry pbe = DataFactory.createPricebook (prod2.Id, 1020);
    insert pbe;

    List<Order> orders = DataFactory.createOrders (act.Id, 1);
    insert orders;

    List<OrderItem> ordItems = DataFactory.createOrderItems (orders, new Map<String, String>{'Product2ID'=>prod2.Id, 'PricebookEntryId'=>pbe.Id});
    insert ordItems; 
  } 
  
    @istest
    static void calculateOrderNetAmountTest(){
        Order ord = new Order();
        ord = [SELECT Id, ShipmentCost__c, NetAmount__c FROM Order LIMIT 1];
        
        // Update order to start our Trigger
        Test.startTest();
        ord.ShipmentCost__c = 200;
        Update ord;
        Test.stopTest();

        Decimal result = ([SELECT NetAmount__c FROM Order WHERE Id=:ord.Id].NetAmount__c);
        system.assertEquals(1300, result, 'Net order is equal to 1300, test ok');
        
    }

    @istest
    static void calculateOrderNetAmountNegativTest(){
        Order ord = new Order();
        ord = [SELECT Id, ShipmentCost__c, NetAmount__c FROM Order LIMIT 1];
        
        // Update order to start our Trigger
        Test.startTest();
        ord.ShipmentCost__c = 0;
        Update ord;
        Test.stopTest();

        Decimal result = ord.NetAmount__c;
        system.assertEquals(null, result, 'Net order is null, no shipment cost > no trigger, test ok');
    
    }

    @istest
    static void updateAccountTurnoverTest(){

        Order ord = new Order();
        ord = [SELECT Id, Status FROM Order LIMIT 1];

        // Update order to start our Trigger
        Test.startTest();
        ord.status = 'Ordered';
        Update ord;
        Test.stopTest();

        Decimal result = ([SELECT Chiffre_d_affaire__c FROM Account WHERE Name = 'TestAccount' LIMIT 1].Chiffre_d_affaire__c); 
        system.assertEquals(1500, result, 'Order sum is equal to 1500, test ok');
    }


}
