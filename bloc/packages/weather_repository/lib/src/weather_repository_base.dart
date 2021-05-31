import 'package:weather_api/weather_api.dart' hide Weather;
import 'models/models.dart';

class WeatherFailure implements Exception {}

class WeatherRepository {
  WeatherRepository({WeatherAPIClient? weatherAPIClient})
      : _weatherAPIClient = weatherAPIClient ?? WeatherAPIClient();
  final WeatherAPIClient _weatherAPIClient;

  Future<Weather> getWeather(String city) async {
    final location = await _weatherAPIClient.locationSearch(city);
    final woeid = location.woeid;
    final weather = await _weatherAPIClient.getWeather(woeid);
    return Weather(
      temperature: weather.theTemp,
      location: location.title,
      condition: weather.weatherStateAbbr.toCondition,
    );
  }
}

extension on WeatherState {
  WeatherCondition get toCondition {
    switch (this) {
      case WeatherState.clear:
        return WeatherCondition.clear;
      case WeatherState.snow:
      case WeatherState.sleet:
      case WeatherState.hail:
        return WeatherCondition.snowy;
      case WeatherState.thunderstorm:
      case WeatherState.heavyRain:
      case WeatherState.lightRain:
      case WeatherState.showers:
        return WeatherCondition.rainy;
      case WeatherState.heavyCloud:
      case WeatherState.lightCloud:
        return WeatherCondition.cloudy;
      default:
        return WeatherCondition.unknown;
    }
  }
}
