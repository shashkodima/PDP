public with sharing class ContinuationController {
    private static final String TEST_REQUEST_URL_FIVE_SECOND = 'https://postman-echo.com/delay/10';
    private static final String TEST_REQUEST_URL_TEN_SECOND = 'https://postman-echo.com/delay/5';

    @AuraEnabled(continuation=true)
    public static Object sendContinuationRequest() {
        Continuation continuationObject = new Continuation(20);
        continuationObject.continuationMethod = 'processResponse';
        continuationObject.state = 'Test info from response';

        HttpRequest requestFiveSecond = new HttpRequest();
        requestFiveSecond.setMethod('GET');
        requestFiveSecond.setEndpoint(TEST_REQUEST_URL_FIVE_SECOND);
        continuationObject.addHttpRequest(requestFiveSecond);

        HttpRequest requestTenSecond = new HttpRequest();
        requestTenSecond.setMethod('GET');
        requestTenSecond.setEndpoint(TEST_REQUEST_URL_TEN_SECOND);
        continuationObject.addHttpRequest(requestTenSecond);

        return continuationObject;
    }

    @AuraEnabled
    public static List<Object> processResponse(List<String> labels, Object state) {
        List<Object> responseList = new  List<Object>();

        for (String label : labels) {
            HttpResponse response = Continuation.getResponse(label);
            Map<String, Object> tempMap = new Map<String, Object>();
            tempMap = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            responseList.addAll(tempMap.values());
        }

        return responseList;
    }
}