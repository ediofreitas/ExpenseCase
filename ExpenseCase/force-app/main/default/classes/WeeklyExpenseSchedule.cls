public with sharing class WeeklyExpenseSchedule implements Schedulable{
   
    String label;
    String category;
    Decimal amount;
    
    //using the constructor to receive parameters
    public WeeklyExpenseSchedule( String label, String category, Decimal amount){
        this.label = label;
        this.category = category;
        this.amount = amount;
    }

    // insert method called every friday
    public void execute(SchedulableContext sc){

        Expense__c expense = new Expense__c();

        expense.Name = this.label;
        expense.Category__c = this.category;
        expense.Amount__c = this.amount;
        expense.Expense_Date__c = date.today();


        insert expense;
    }

}