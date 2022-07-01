public with sharing class ExpenseTriggerHandler {
    
    public static void onBeforeInsert(List<Expense__c> expensesList){

        for(Expense__c expense : expensesList){
            if(expense.Weekly_expense__c){
                ExpenseTriggerHelper.weeklyRecurrence(expense);
                
            }else if(expense.Monthly_expense__c){
                ExpenseTriggerHelper.monthlyRecurrence(expense);
            }
        }
    }

}
