// api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
// 9b618d87c8b3115ab9a13047091beba5
// api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:new_weather_app/network_helper/models.dart';

class DataService {
  Future<WeatherResponce> getCityWeather(String cityName) async {
    final queryParamters = {
      'q': cityName,
      'appid': '9b618d87c8b3115ab9a13047091beba5',
      'units': 'metric',
    };
    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParamters);
    final responce = await http.get(uri);
    final json = jsonDecode(responce.body);
    return WeatherResponce.fromJson(json);
  }

  Future<WeatherResponce> getCurrrentLocationWeather(
      String latitude, String longitude) async {
    final queryParamters = {
      'lat': latitude,
      'lon': longitude,
      'appid': '9b618d87c8b3115ab9a13047091beba5',
      'units': 'metric',
    };
    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParamters);
    final responce = await http.get(uri);
    final json = jsonDecode(responce.body);
    return WeatherResponce.fromJson(json);  
  }
}
