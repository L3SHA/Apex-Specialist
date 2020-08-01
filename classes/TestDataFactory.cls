public class TestDataFactory {
    private static final Integer NUM_OF_CASES = 300;
    //private static final String BASE_CASE_NAME = 'Test';
        
    public static void updateCaseData() {
        List<Case> cases = new List<Case>();
        for(Integer i = 0; i < NUM_OF_CASES; i++) {
            cases.add(new Case());
        }
        insert cases;
    }
}