Public with sharing class RollupIndicatorController {
    @AuraEnabled(cacheable=true)
    public static Map<String, Object> getRollupFieldDetails(String targetObject, String rollupFieldApiName, Id recordId) {
        Map<String, Object> result = new Map<String, Object>();

        try {
            if (!Schema.getGlobalDescribe().containsKey(targetObject)) {
                throw new AuraHandledException('Invalid object name: ' + targetObject);
            }

            Schema.SObjectType sObjectType = Schema.getGlobalDescribe().get(targetObject);
            if (!sObjectType.getDescribe().fields.getMap().containsKey(rollupFieldApiName)) {
                throw new AuraHandledException('Invalid field name: ' + rollupFieldApiName);
            }

            Schema.DescribeFieldResult fieldDescribe = sObjectType.getDescribe().fields.getMap().get(rollupFieldApiName).getDescribe();
            String fieldLabel = fieldDescribe.getLabel();
            result.put('fieldLabel', fieldLabel);

            String query = 'SELECT ' + rollupFieldApiName + ' FROM ' + targetObject + ' WHERE Id = :recordId';
            List<SObject> records = Database.query(query);
            if (!records.isEmpty()) {
                result.put('fieldValue', records[0].get(rollupFieldApiName));
            } else {
                result.put('fieldValue', null); // No value found
            }
        } catch (Exception e) {
            throw new AuraHandledException('Error fetching rollup field details: ' + e.getMessage());
        }

        return result;
    }
}
