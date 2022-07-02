public with sharing class ExpenseTriggerHelper {
    
    //Scheduling the class for the next friday
    public static void weeklyRecurrence(Expense__c expense){
        try {
            System.schedule('Weekly expense ' + expense.Name + expense.Amount__c, '0 0 0 ? * 6', new WeeklyExpenseSchedule(expense.Name, expense.Category__c, expense.Amount__c));
            // If the user try to schedule multiple expenses with the same key (name + amount) the catches will throw the error            
        } catch (Exception e) {   
            System.debug('Error trying to schedule the expense. ' + e.getMessage());
        }
    }
    //Scheduling the class for the next day 15th of the month
    public static void monthlyRecurrence(Expense__c expense){
        try {
            System.schedule('Monthly expense ' + expense.Name + expense.Amount__c, '0 0 0 15 * ?', new MonthlyExpenseSchedule(expense.Name, expense.Category__c, expense.Amount__c));     
            // If the user try to schedule multiple expenses with the same key (name + amount) the catches will throw the error     
        } catch (Exception e) {
            System.debug('Error trying to schedule the expense. ' + e.getMessage());   
        }
    }
}
