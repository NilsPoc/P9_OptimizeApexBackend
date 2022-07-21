trigger OrderCalculation on Order (before update, after update) {
    if (Trigger.isBefore){ 
        OrderHandler.calculateOrderNetAmount(Trigger.new);
    }
    if (Trigger.isAfter ){ 
        OrderHandler.updateAccountTurnover(Trigger.New);
    } 
}