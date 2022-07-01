trigger ExpenseTrigger on Expense__c (before insert) {

    if(Trigger.isBefore){
        if(Trigger.isInsert){
            ExpenseTriggerHandler.onBeforeInsert(Trigger.new);
        }
    }
}