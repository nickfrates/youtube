public class AccountBatch implements Database.Batchable<Sobject>, Database.Stateful {
    public integer recordsProcessed = 0;

    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Id, Name, Description FROM Account');
        
    }

    public void execute(Database.BatchableContext bc, List<Account> scope){
        for(Account acc : scope) acc.Batch_Description__c = 'Processed ' + system.now();
        update scope;
        recordsProcessed += scope.size();
    }

    public void finish(Database.BatchableContext bc){
        System.debug('Processed ' + recordsProcessed + 'records');
    }


}