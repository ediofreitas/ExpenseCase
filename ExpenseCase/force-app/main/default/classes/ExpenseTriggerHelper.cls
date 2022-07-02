public with sharing class ExpenseTriggerHelper {
    
    //Scheduling the class for the next friday
    public static void weeklyRecurrence(Expense__c expense){
        try {
            System.schedule('Weekly expense ' + expense.Name, '0 0 0 ? * 6', new WeeklyExpenseSchedule(expense.Name, expense.Category__c, expense.Amount__c));            
        } catch (Exception e) {   
            System.debug('Error trying to schedule the expense. ' + e.getMessage());
        }
    }
    //Scheduling the class for the next day 15th of the month
    public static void monthlyRecurrence(Expense__c expense){
        try {
            System.schedule('Monthly expense ' + expense.Name, '0 0 0 15 * ?', new MonthlyExpenseSchedule(expense.Name, expense.Category__c, expense.Amount__c));     
        } catch (Exception e) {
            System.debug('Error trying to schedule the expense. ' + e.getMessage());
            
        }
    }
}
