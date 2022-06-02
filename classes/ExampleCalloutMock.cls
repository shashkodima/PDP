/**
 * Created by Dmitry Shashko
 */

@IsTest
global class ExampleCalloutMock implements HttpCalloutMock{
    Boolean  isMockResponseSuccessfulCode;
    Boolean isPaymentCompleted;
    Boolean isWrongRequestParameters;
    String endpointName;

    global ExampleCalloutMock(Boolean isMockResponseSuccessfulCode, String endpointName, Boolean isPaymentCompleted, Boolean isWrongRequestParameters) {
        this.isMockResponseSuccessfulCode  = isMockResponseSuccessfulCode;
        this.endpointName = endpointName;
        this.isPaymentCompleted = isPaymentCompleted;
        this.isWrongRequestParameters = isWrongRequestParameters;
    }

    global HttpResponse respond(HttpRequest request) {
        HttpResponse response = new HttpResponse();

        if (endpointName == Constants.CANCEL_PAYMENT_ENDPOINT) {
            if (isMockResponseSuccessfulCode && !isWrongRequestParameters) {
                response.setHeader('Content-Type', 'application/json');
                response.setBody('{"Success":true,"Message":null}');
                response.setStatusCode(200);
            } else {
                response.setStatusCode(400);
            }
        }

        if (endpointName == Constants.GET_COMPENSATION_ENDPOINT) {
            if (isMockResponseSuccessfulCode && isPaymentCompleted && !isWrongRequestParameters) {
                response.setHeader('Content-Type', 'application/json');
                response.setBody('{"Model": {"Reason": "Approved","CardHolderMessage":"Оплата успешно проведена"},"Success": true,"Message": null}');
                response.setStatusCode(200);
            } else if (isMockResponseSuccessfulCode && !isPaymentCompleted && !isWrongRequestParameters) {
                response.setHeader('Content-Type', 'application/json');
                response.setBody('{"Model": {"Reason": "InsufficientFunds","CardHolderMessage":"Недостаточно средств на карте"},"Success": false,"Message": null}');
                response.setStatusCode(200);
            } else if (isMockResponseSuccessfulCode && !isPaymentCompleted && isWrongRequestParameters) {
                response.setHeader('Content-Type', 'application/json');
                response.setBody('{"Success":false,"Message":"Amount is required"}');
                response.setStatusCode(200);
            } else {
                response.setStatusCode(400);
            }
        }

        return response;
    }
}