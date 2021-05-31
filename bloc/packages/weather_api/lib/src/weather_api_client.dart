import 'dart:convert';
import 'dart:html';
import 'dart:io';

import 'package:http/http.dart';

import 'models/models.dart';

/// Exception thrown when locationSearch fails.
class LocationIdRequestFailure implements Exception {}

/// Exception thrown when getWeather fails.
class WeatherRequestFailure implements Exception {}

class WeatherAPIClient {
  WeatherAPIClient({ Client? httpClient}) : _httpClient = httpClient ?? Client();

  final Client _httpClient;
  static const _baseUrl = 'www.metaweather.com';

  Future<Location> locationSearch(String query) async {
    final locationRequest = Uri.https(_baseUrl, '/api/location/search', <String, String>{'query': query});
    final locationResponse = await _httpClient.get(locationRequest);
    if (locationResponse.statusCode != 200){
      throw LocationIdRequestFailure();
    }
    final locationJson = jsonDecode(locationResponse.body) as List;
    if (locationJson.isEmpty){
      throw LocationIdRequestFailure();
    }
    return Location.fromJson(locationJson.first as Map<String, dynamic>);
  }

  Future<Weather> getWeather(int locationId) async{
    final req = Uri.https(_baseUrl, '/api/location/locationId');
    final res = await _httpClient.get(req);
    if (res.statusCode != 200){
      throw LocationIdRequestFailure();
    }


    final weatherJson = jsonDecode(
      res.body,
    )['consolidated_weather'] as List;

    if (weatherJson.isEmpty) {
      throw WeatherRequestFailure();
    }

    return Weather.fromJson(weatherJson.first as Map<String, dynamic>);
  }
}
