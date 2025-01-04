public with sharing class RollupIndicatorController {
    @AuraEnabled(cacheable=true)
    public static Decimal getRollupFieldValue(String targetObject, String rollupFieldApiName, Id recordId) {
        try {
            String query = 'SELECT ' + rollupFieldApiName + ' FROM ' + targetObject + ' WHERE Id = :recordId';
            SObject result = Database.query(query);
            return (Decimal)result.get(rollupFieldApiName);
        } catch (Exception e) {
            throw new AuraHandledException('Error fetching rollup field value: ' + e.getMessage());
        }
    }
}