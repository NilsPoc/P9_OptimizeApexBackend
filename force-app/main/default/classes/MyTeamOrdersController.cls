public without sharing class MyTeamOrdersController {
    public decimal sumOrders{
        get{
			AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order WHERE Status = 'ordered']; 
			return (decimal)groupedResults.get('total');
        }
        set;
    }
}