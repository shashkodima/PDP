public class WeatherForecastUpdater {
    WeatherForecastService forecastService;

    public WeatherForecastUpdater(WeatherForecastService forecastService) {
        this.forecastService = forecastService;
    }

    //PDP use Stub object
    public Weather_Daily_Forecast__c createWeatherDailyForecast(Space_Point__c spacePoint, Date forecastDate) {

        Weather_Daily_Forecast__c newForecast = new Weather_Daily_Forecast__c (
                Date__c = forecastDate,
                Average_Temperature__c = forecastService.getForecastForSpacePoint(spacePoint, forecastDate),
                Space_Point__c = spacePoint.Id
        );

        return newForecast;
    }
}