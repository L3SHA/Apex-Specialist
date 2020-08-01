@isTest
public class WarehouseSyncScheduleTest {
    @isTest
    public static void testScheduleJob() {
        
        WarehouseSyncSchedule wss = new WarehouseSyncSchedule();
        
        Test.startTest();
        String jobId = System.schedule('Update maintenance info', '0 0 1 * * ? *', wss);
        Test.stopTest();
        
        System.assertEquals(1, [SELECT count() FROM AsyncApexJob]);
    }
}