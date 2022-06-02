@IsTest
class WeatherForecastUpdater_Test {
    
    @testSetup
    private static void setup() {
        TestDataFactory.createSpacePoints();
    }

    //PDP use Stub object
    @IsTest
    private static void testCreateWeatherDailyForecast() {
        Space_Point__c testSpacePoint = [
                SELECT Id,
                        Latitude__c,
                        Longitude__c
                FROM Space_Point__c
                LIMIT 1
        ];
        Date controlDate = Date.today();
        WeatherForecastService stubService = (WeatherForecastService) Test.createStub(WeatherForecastService.class, new WeatherForecastStub());

        Test.startTest();
        Weather_Daily_Forecast__c resultForecast = new  WeatherForecastUpdater(stubService).createWeatherDailyForecast(testSpacePoint, controlDate);
        Test.stopTest();

        System.assertEquals(resultForecast.Space_Point__c, testSpacePoint.Id);
        System.assertEquals(resultForecast.Average_Temperature__c, 0);
        System.assertEquals(resultForecast.Date__c, controlDate);
    }
}