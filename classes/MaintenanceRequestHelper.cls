public with sharing class MaintenanceRequestHelper {
    
    private static final String CASE_TYPE_ROUTINE_MAINTENANCE = 'Routine Maintenance';
    private static final String CASE_STATUS_NEW = 'New';
    private static final String CASE_SUBJECT = 'Some subject';

    public static void updateWorkOrders(List<Case> cases) {   

        List<Case> newCases = new List<Case>();

        for(Case oldCase : cases) {

            Case newCase = new Case();
            newCase.Type = CASE_TYPE_ROUTINE_MAINTENANCE;
            newCase.Status = CASE_STATUS_NEW;
            newCase.Subject = oldCase.Subject == null ? CASE_SUBJECT : oldCase.Subject;
            newCase.Vehicle__c = oldCase.Vehicle__c;
            newCase.Date_Reported__c = Date.today();
            newCase.Equipment__c = oldCase.Equipment__c;
            newCase.Date_Due__c = Date.today().addDays(getLeastNumberOfDays(oldCase));

            newCases.add(newCase);
            
        }

        if(newCases.size() > 0) {
        	insert newCases;
        }

    }

    private static Integer getLeastNumberOfDays(Case c) {

        List<Work_Part__c> relatedParts = [SELECT Id, Equipment__r.Maintenance_Cycle__c FROM Work_Part__c WHERE Maintenance_Request__r.Id=:c.Id];

        Integer min = 0;
        if(relatedParts.size() > 0) {
            min = Integer.valueOf(relatedParts.get(0).Equipment__r.Maintenance_Cycle__c); 
        }

        for(Work_Part__c part: relatedParts) {
            if(part.Equipment__r.Maintenance_Cycle__c < min) {
                min = Integer.valueOf(part.Equipment__r.Maintenance_Cycle__c);
            }
        }

        return min;
    }
    
}