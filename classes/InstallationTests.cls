@IsTest
private class InstallationTests {
    @IsTest
    private static void TestCaseUpdate() {
        TestDataFactory.updateCaseData();
        
        List<Case> cases = [SELECT Id FROM Case];
        //System.debug(cases.get(0).Status);
		
        for(Case oldCase : cases) {
            oldCase.Subject = 'Some subject';
            oldCase.Type = 'Repair';
            oldCase.Status = 'Closed';
        }
        
        Test.startTest();
        update cases;
        Test.stopTest();
        
        System.assertEquals(300, [SELECT count() FROM Case WHERE Status = 'New']);
    }
}