global class WeatherForecastStub implements StubProvider{

    global Object handleMethodCall(Object stubbedObject, String stubbedMethodName, System.Type returnType,
            List<System.Type> listOfParamTypes, List<String> listOfParamNames, List<Object> listOfArgs) {

        if(stubbedMethodName == 'getForecastForSpacePoint'){
            Decimal temperature = 0;

            return temperature;
        }

        return null;
    }
}