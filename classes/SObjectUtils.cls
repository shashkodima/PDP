/**
 * Created by Привет on 03.03.2022.
 */

public with sharing class SObjectUtils {

    public static List<SObject> getSobjectRecordsByConditions(SObject instance, Set<String> fieldsToQuery, String conditions) {
        if (instance == null || fieldsToQuery == null || fieldsToQuery.isEmpty()) return new List<SObject>();

        Schema.DescribeSObjectResult describeResult = instance.getSObjectType().getDescribe();
        String nameSObject = describeResult.getName();
        Set<String> fieldsForQuery = removeNotExistFields(instance, fieldsToQuery);

        String query = 'SELECT ' +
                String.join(new List<String>(fieldsForQuery), ',') +
                ' FROM ' + nameSObject;

        if (String.isNotBlank(conditions)) query += ' WHERE ' + conditions;

        return Database.query(query);
    }

    public static Set<String> removeNotExistFields(SObject instance, Set<String> fieldsToQuery) {
        if (instance == null || fieldsToQuery == null || fieldsToQuery.isEmpty()) return new Set<String>();

        Schema.DescribeSObjectResult describeResult = instance.getSObjectType().getDescribe();
        Map<String, Schema.SObjectField> fieldMap = describeResult.fields.getMap();

        for (String fieldName : fieldsToQuery) {
            if (!fieldMap.containsKey(fieldName)) fieldsToQuery.remove(fieldName);
        }

        return fieldsToQuery;
    }

    public static List<List<sObject>> getSObjectsByPhraseOrWord(String phraseOrWord, String returningObjectsAndFields) {
        if (String.isBlank(phraseOrWord) || String.isBlank(returningObjectsAndFields)) return new List<List<sObject>>();

        return search.query('FIND \'' + phraseOrWord + '\' IN ALL FIELDS RETURNING ' + returningObjectsAndFields);
    }
}