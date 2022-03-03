public with sharing class SObjectSharingUtils {

    public static boolean shareRecords(List<SObject> recordsToShare, Id userOrGroupId, String accessLevel, String rowCauseName) {
        if (recordsToShare == null || recordsToShare.isEmpty() || userOrGroupId == null || String.isBlank(accessLevel)) {
            return null;
        }
        List<SObject> shareObjects = new List<SObject>();
        List<Database.SaveResult> saveResults = new List<Database.SaveResult>();
        Schema.DescribeSObjectResult describeResult = recordsToShare.getSObjectType().getDescribe();
        String sObjectName = describeResult.getName();
        Boolean isCustomSObject = describeResult.isCustom();
        Schema.sObjectType shareObjectToken = getShareObjectToken(sObjectName, isCustomSObject);

        String parentIdFieldName = isCustomSObject ? 'ParentId' : sObjectName + 'Id';
        String accessLevelFieldName = isCustomSObject ? 'AccessLevel' : sObjectName + 'AccessLevel';
        String rawCauseValue = String.isBlank(rowCauseName) ? 'Manual' : rowCauseName;

        for (SObject record : recordsToShare) {
            SObject shareObject = shareObjectToken.newSObject();
            shareObject.put(parentIdFieldName, record.Id);
            shareObject.put('UserOrGroupId', userOrGroupId);
            shareObject.put(accessLevelFieldName, accessLevel);
            shareObject.put('RowCause', rawCauseValue);

            shareObjects.add(shareObject);
        }

        if (shareObjects.size() > 0) saveResults = Database.insert(shareObjects,false);

        return checkSharingSuccess(saveResults);
    }

    public static Schema.sObjectType getShareObjectToken(String sObjectName, Boolean isCustomSObject) {
        if (String.isBlank(sObjectName) || isCustomSObject == null) {
            return null;
        }
        String shareObjectName;

        if (isCustomSObject) {
            shareObjectName = sObjectName.removeEnd('__c') + '__Share';
        } else {
            shareObjectName = sObjectName + 'Share';
        }

        return Schema.getGlobalDescribe().get(shareObjectName);
    }

    public static boolean checkSharingSuccess(List<Database.SaveResult> saveResults) {
        if (saveResults == null || saveResults.IsEmpty()) {
            return null;
        }
        Integer listSize = saveResults.size();
        Boolean isSuccess = true;

        for (Integer i = 0; i < listSize; i++) {
            if(saveResults[i].isSuccess()) continue;
            Database.Error error = saveResults[i].getErrors()[0];

            if (!(error.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION  &&
                    error.getMessage().contains('AccessLevel'))) {
                isSuccess = false;
                break;
            }
        }

        return isSuccess;
    }
}