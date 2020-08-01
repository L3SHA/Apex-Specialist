trigger MaintenanceRequest on Case (before update, after update) {

    private static final String CLOSE_STATUS = 'Close';
    private static final String CASE_TYPE_REPAIR = 'Repair';
    private static final String CASE_TYPE_ROUTINE_MAINTENANCE = 'Routine  Maintenance';

    List<Case> closedCases = new List<Case>();

    //Type field was edited. Repair and Routine Maintenance values were added. 
    for(Case oldCase : Trigger.New) {
        if(oldCase.Status == CLOSE_STATUS && (oldCase.Type == CASE_TYPE_REPAIR || oldCase.Type == CASE_TYPE_ROUTINE_MAINTENANCE)) {
            closedCases.add(oldCase);
        }
    }

    if(closedCases.size() > 0) {
        MaintenanceRequestHelper.updateWorkOrders(closedCases);
    }

}