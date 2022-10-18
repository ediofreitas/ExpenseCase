import { LightningElement, track, api } from 'lwc';
import getExpenses from '@salesforce/apex/ExpenseController.getExpenses';
import { refreshApex } from '@salesforce/apex';

export default class ExpenseList extends LightningElement {

    @track expenses;
    @track listContains = false;

    @track columns = [
        { label: 'Label', fieldName: 'nameUrl', type: 'url', typeAttributes: {label: { fieldName: 'Name' }, 
            target: '_blank'}},
        { label: 'Category', fieldName: 'Category__c', type: 'text' },
        { label: 'Date', fieldName: 'Expense_Date__c', type: 'date' },
        { label: 'Amount', fieldName: 'Amount__c', type: 'currency' },
        { label: 'Weekly Total Amount', fieldName: 'Weekly_Total_Amount__c', type: 'currency' },
        { label: 'Monthly Total Amount', fieldName: 'Monthly_Total_Amount__c', type: 'currency' }
    ];

    connectedCallback(){
        this.getExpenses();
    }

    @api
    refreshView(){
        this.getExpenses();
    }

    getExpenses(){
        getExpenses()
        .then(result =>{
            let nameUrl;
            this.listContains = true;
            this.expenses = result.map(row => { 
                nameUrl = `/${row.Id}`;
                return {...row , nameUrl}
                })
            
        }).catch(err =>{
            console.log('Error getting expenses: Check your data and try again.' + err);
        })

    }


}
