@IsTest
public class RollupIndicatorControllerTest {
    @IsTest
    public static void testGetRollupFieldValue() {
        Account testAccount = new Account(Name='Test Account', AnnualRevenue=1000000);
        insert testAccount;

        Decimal rollupValue = RollupIndicatorController.getRollupFieldValue('Account', 'AnnualRevenue', testAccount.Id);
        System.assertEquals(1000000, rollupValue);
    }
}