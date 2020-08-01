public with sharing class WarehouseCalloutService {

    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    private static final String HTTP_METHOD_GET = 'GET';
    private static final Integer HTTP_STATUS_OK = 200;
    
    @future (callout = true)
    public static void runWarehouseEquipmentSync() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(WAREHOUSE_URL);
        request.setMethod(HTTP_METHOD_GET);
        HttpResponse response = http.send(request);
        
        if(response.getStatusCode() == HTTP_STATUS_OK) {
            List<Object> equipmentList =  (List<Object>)JSON.deserializeUntyped(response.getBody());
            List<Product2> upsertList = new List<Product2>();
            for(Object equipment : equipmentList) {
                Map<String, Object> newItem = (Map<String, Object>) equipment;
                upsertList.add(new Product2(
                		ProductCode = (String)newItem.get('_id'),
                    	Replacement_Part__c = true,
                    	Name = (String)newItem.get('name'),
                    	Maintenance_Cycle__c = (Decimal)newItem.get('maintenanceperiod'),
                    	Lifespan_Months__c = (Decimal)newItem.get('lifespan'),
            			Cost__c = (Decimal)newItem.get('cost'),
            			Warehouse_SKU__c = (String)newItem.get('sku'),
                    	Current_Inventory__c = (Decimal)newItem.get('quantity')
                ));     
                System.debug(newItem.get('name'));
            }
            if(equipmentList.size() > 0) {
                upsert upsertList Warehouse_SKU__c;
            }
        }
        
    }
}