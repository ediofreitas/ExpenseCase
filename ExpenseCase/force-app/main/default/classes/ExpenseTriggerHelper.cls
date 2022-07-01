public with sharing class ExpenseTriggerHelper {
    
    public static void weeklyRecurrence(Expense__c expense){
        System.schedule('Weekly expense ' + expense.Name, '0 0 0 ? * 6', new WeeklyExpenseSchedule(expense.Name, expense.Category__c, expense.Amount__c));
    }

    public static void monthlyRecurrence(Expense__c expense){
        System.schedule('Monthly expense ' + expense.Name, '0 0 0 15 * ?', new MonthlyExpenseSchedule(expense.Name, expense.Category__c, expense.Amount__c));
    }
}
