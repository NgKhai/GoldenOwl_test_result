import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/weather.dart';

class WeatherStorage {
  static Future<void> saveWeatherData(Weather weather) async {
    final prefs = await SharedPreferences.getInstance();
    String weatherData = json.encode(weather.toJson());
    await prefs.setString('weather_data', weatherData);
  }

  static Future<Weather?> getWeatherData() async {
    final prefs = await SharedPreferences.getInstance();
    String? weatherData = prefs.getString('weather_data');
    if (weatherData != null) {
      return Weather.fromJson(json.decode(weatherData));
    }
    return null;
  }
}
