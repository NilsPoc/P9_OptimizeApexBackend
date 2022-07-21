global class UpdateAccounts implements Database.Batchable<sObject>{
    
   global Database.QueryLocator start(Database.BatchableContext info){ 
       //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
       return Database.getQueryLocator ('SELECT Id FROM Account WHERE Id IN ( SELECT AccountId FROM Order WHERE Status = \'Ordered\')');

   }
    
   global void execute(Database.BatchableContext info, List<Account> scope){      
       list<Order> listOrders =  [SELECT Id, TotalAmount, AccountId FROM Order WHERE Status = 'Ordered'];
       
        for(Account account : scope){
            account.Chiffre_d_affaire__c = 0;
            for(Order order : listOrders){
                if(order.AccountId == account.Id){
                    account.Chiffre_d_affaire__c = account.Chiffre_d_affaire__c + order.TotalAmount;
                }
            }
        }
        if (scope.size() > 0){
        update scope;
        }
    }   
   
   global void finish(Database.BatchableContext info){     
       
   } 
}