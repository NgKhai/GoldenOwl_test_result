// import 'package:flutter/material.dart';
// import '../models/weather.dart';
//
// class WeatherProvider with ChangeNotifier {
//   Weather _weather = Weather();
//
//   Weather get weather => _weather;
//
//   void updateWeather(Weather newWeather) {
//     _weather = newWeather;
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import '../models/dayforecast.dart';
import '../models/weather.dart';
import '../storages/weather_storage.dart';

class WeatherProvider extends ChangeNotifier {
  Weather _weather = Weather();

  WeatherProvider() {
    _loadWeatherData();
  }

  Weather get weather => _weather;

  void updateWeather(Weather newWeather) {
    _weather = newWeather;
    notifyListeners();
    WeatherStorage.saveWeatherData(newWeather); // Save weather data
  }

  void updateSelectedDayForecast(DayForecast newForecast) {
    _weather.hourlyWeatherForecast = newForecast.hourlyWeatherForecast;
    _weather.currentWeatherCondition = newForecast.currentWeatherCondition;
    _weather.temperature = (newForecast.minTemperature + newForecast.maxTemperature) / 2;
    notifyListeners();
  }

  Future<void> _loadWeatherData() async {
    Weather? savedWeather = await WeatherStorage.getWeatherData();
    if (savedWeather != null) {
      _weather = savedWeather;
      notifyListeners();
    }
  }
}

