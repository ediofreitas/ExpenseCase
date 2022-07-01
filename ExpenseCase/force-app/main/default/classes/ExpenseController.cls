public with sharing class ExpenseController {
    
    // Method called to insert the expense and call the schedule when needed
    @AuraEnabled
    public static void createExpense(String label, String category, Date dateTerm, Decimal amount, String isRecurrent){
        System.debug(label + category + dateTerm + amount + isRecurrent);
        
        Expense__c expense = new Expense__c();
        expense.Name = label;
        expense.Category__c = category;
        expense.Amount__c = amount;
        

        // If the expense is recurrent im creating a schedule to repeat the insertion of the expense every friday for weekly expenses and every 15th of each month for monthly expenses.
        //If the expense is recurrent im ignoring the date inputed by the user and im inserting in the date specified in the document for recurrent expenses.
        if(isRecurrent == 'Weekly'){
            System.schedule('Weekly expense ' + label, '0 0 0 ? * 6', new WeeklyExpenseSchedule(label, category, amount));
            // im always considering weekly expenses at fridays of the same week
            expense.Expense_Date__c = dateTerm.toStartOfWeek().addDays(5);
            expense.Weekly_expense__c = true;
        }else if(isRecurrent == 'Monthly'){
            //check if the date inputed is after day 15 or before, im always considering the next 15th day for the insert.
            if(dateTerm <= date.newInstance(dateTerm.year(), dateTerm.month(), 15)){
                expense.Expense_Date__c = date.newInstance(dateTerm.year(), dateTerm.month(), 15);
            }else{
                expense.Expense_Date__c = date.newInstance(dateTerm.year(), dateTerm.month()+1, 15);               
            }
            System.schedule('Monthly expense ' + label, '0 0 0 15 * ?', new MonthlyExpenseSchedule(label, category, amount));
            expense.Monthly_expense__c = true;

        }else{
            expense.Expense_Date__c = dateTerm;
        }
        
        insert expense;
    }

    // Method called to retrieve all the expenses in the database
    @AuraEnabled //(cacheable=true) --- obs: removed the cacheable true because this is the only way to refresh the table after insert a new value
    public static List<Expense__c> getExpenses(){
        List<Expense__c> expensesList = [SELECT Id, Name, Category__c, Amount__c, Expense_Date__c, Weekly_Total_Amount__c, Monthly_Total_Amount__c FROM Expense__c ORDER BY Expense_Date__c];

        return expensesList;
    }

    // ----------------- IMPORTANT---------------------
    //not using try/catches here because i already have them in each method on the LWC
}
