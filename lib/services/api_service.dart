import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/weather.dart';
import '../providers/weather_provider.dart';

class ApiService {
  final WeatherProvider weatherProvider;
  final String weatherSearchAPI = "https://api.weatherapi.com/v1/forecast.json?key=${dotenv.env['API_KEY']}&days=4";

  ApiService(this.weatherProvider);

  Future<void> getAndUpdateWeatherData(String countryName) async {
    String requestURL = "$weatherSearchAPI&q=$countryName";
    try {
      var response = await http.get(Uri.parse(requestURL));
      // await Future.delayed(const Duration(seconds: 2));
      if (response.statusCode == 200) {
        final weatherData = Map<String, dynamic>.from(
          json.decode(response.body) ?? 'No Data',
        );
        final weather = Weather.fromJson(weatherData);
        weatherProvider.updateWeather(weather);
      } else {
        print('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}

