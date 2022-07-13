trigger UpdateAccountCA on Order (after update) {
	
    set<Id> setAccountIds = new set<Id>();
    
    for(integer i=0; i< trigger.new.size(); i++){
        Order newOrder= trigger.new[i];
       
        Account acc = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id =:newOrder.AccountId ];
        acc.Chiffre_d_affaire__c = acc.Chiffre_d_affaire__c + newOrder.TotalAmount;
        update acc;
    }
}


/* trigger ABC on Order (before update, after update) {
    if (Trigger.isBefore){}   // Créer une classe "TriggerHandler" avec la méthode pour : - la mise à jour de l'ordre (en déduisant shipment cost)
    if (Trigger.isAfter ){} // Créer une classe "TriggerHandler" avec la méthode pour : - la mise à jour du chiffre d'affaire de l'account


    */