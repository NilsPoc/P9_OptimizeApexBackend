public with sharing class OrderHandler {

    public static void calculateOrderNetAmount(List<Order> Orders){

        List<Order> ordersToUpdate = new List<Order>();

        //Update order net amount for each new orders and add them to our collection
        for(Order ord : orders) {
            if(ord.ShipmentCost__c != 0 && ord.ShipmentCost__c != null){
                ord.NetAmount__c = ord.TotalAmount - ord.ShipmentCost__c;
                ordersToUpdate.add(ord);
            }
        }
    }

    public static void updateAccountTurnover(List<Order> Orders) {

        set<Id> setAccountIds = new set<Id>();

        //Add account Id in a set for each orders
        for (Order newOrder : Orders){
            setAccountIds.add(newOrder.AccountId);
        }

        // Get the list of account related to new orders
        List<Account> listOfAccount = [SELECT Id, chiffre_d_affaire__c FROM Account WHERE Id IN :setAccountIds]; 

        // Get the new orders 
        List<Order> listOfOrders =  [SELECT Id, TotalAmount, AccountId FROM Order WHERE AccountId IN :setAccountIds AND Status = 'Ordered'];

        // Update turnover for each account and add them to our collection
        for(Account act: listOfAccount) {
            act.Chiffre_d_affaire__c = 0;
            for(integer i=0; i < listOfOrders.size(); i++){
            if(listOfOrders[i].AccountId == act.Id) {
            act.Chiffre_d_affaire__c += listOfOrders[i].TotalAmount;
            }
            }
        }
        if (listOfAccount.size() > 0){
            update listOfAccount;
            }
}
}