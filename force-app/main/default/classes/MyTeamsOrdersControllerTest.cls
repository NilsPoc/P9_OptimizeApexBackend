@isTest 
public class MyTeamsOrdersControllerTest{
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
    static void sumOrdersTest(){
        MyTeamOrdersController instance = new MyteamOrdersController();
        Order ord = [SELECT Id, Status FROM Order LIMIT 1];
        ord.status = 'Ordered';
        
        Test.startTest();
        Update ord;        
        Test.stopTest();

        Decimal result = instance.sumOrders;
        system.assert(result == 1500, 'Order sum is equal to 1500, test ok');
    }


}
