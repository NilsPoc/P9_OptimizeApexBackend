global class UpdateAllAccounts implements Database.Batchable<sObject>{
    


    // inutile ? (on a déjà updateAccount en batch)

    
   global Database.QueryLocator start(Database.BatchableContext info){ 
       //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
       return Database.getQueryLocator('SELECT Id FROM Account'); //('SELECT AccountId FROM order WHERE Status = 'ordered' ');
       //('SELECT Id FROM Account WHERE Id IN ( SELECT AccountId FROM Order WHERE Status = 'Ordered')')

   }
    
   global void execute(Database.BatchableContext info, List<Account> scope){
       Set<Id> setAccountIds = (new Map<Id,SObject>(scope)).keySet();
       // AP01Account.updateChiffreAffaire(setAccountIds);
   }    
    
   global void finish(Database.BatchableContext info){     
       
   } 
}