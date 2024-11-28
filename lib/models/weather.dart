import '../utils/countries.dart';
import '../utils/helpers.dart';

class Weather {
  String? locationName;
  String? weatherIcon;
  String? weatherIconUrl;
  double? temperature;
  double? windSpeed;
  int? humidity;
  int? cloud;
  double? pressure;
  double? visibility;
  String? currentDate;
  bool? isDay;
  List<dynamic>? hourlyWeatherForecast;
  List<dynamic>? dailyWeatherForecast;
  String? currentWeatherCondition;

  Weather({
    this.locationName = '',
    this.weatherIcon = '',
    this.weatherIconUrl = '',
    this.temperature = 0.0,
    this.windSpeed = 0.0,
    this.humidity = 0,
    this.cloud = 0,
    this.pressure = 0.0,
    this.visibility = 0.0,
    this.currentDate = '',
    this.isDay = false,
    this.hourlyWeatherForecast = const [],
    this.dailyWeatherForecast = const [],
    this.currentWeatherCondition = '',
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final current = json['current'] as Map<String, dynamic>? ?? {};
    final condition = current['condition'] as Map<String, dynamic>? ?? {};
    final location = json['location'] as Map<String, dynamic>? ?? {};
    final forecast = json['forecast'] as Map<String, dynamic>? ?? {};
    final forecastDay = (forecast['forecastday'] as List<dynamic>?)?.firstOrNull ?? {};

    String weatherIconPath = '${(condition["text"]?.toString().replaceAll(' ', '').toLowerCase() ?? '')}.png';
    String countryShortenedName = Helpers.getShortNameByName(
        countries, location["country"]?.toString() ?? 'Unknown');
    String locationName = '$countryShortenedName / ${location["name"] ?? "Unknown"}';

    return Weather(
      locationName: locationName,
      weatherIcon: weatherIconPath,
      weatherIconUrl: condition["icon"] ?? '',
      temperature: (current["temp_c"] as num?)?.toDouble() ?? 0.0,
      windSpeed: (current["wind_kph"] as num?)?.toDouble() ?? 0.0,
      humidity: current["humidity"] ?? 0,
      cloud: current["cloud"] ?? 0,
      pressure: (current["pressure_mb"] as num?)?.toDouble() ?? 0.0,
      visibility: (current["vis_km"] as num?)?.toDouble() ?? 0.0,
      isDay: current["is_day"] == 1,
      currentDate: Helpers.getDate(location["localtime"] ?? '2024-11-28'),
      hourlyWeatherForecast: forecastDay["hour"] ?? [],
      dailyWeatherForecast: forecast["forecastday"] ?? [],
      currentWeatherCondition: condition["text"] ?? 'Unknown',
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'locationName': locationName,
      'weatherIcon': weatherIcon,
      'weatherIconUrl': weatherIconUrl,
      'temperature': temperature,
      'windSpeed': windSpeed,
      'humidity': humidity,
      'cloud': cloud,
      'pressure': pressure,
      'visibility': visibility,
      'currentDate': currentDate,
      'isDay': isDay,
      'hourlyWeatherForecast': hourlyWeatherForecast,
      'dailyWeatherForecast': dailyWeatherForecast,
      'currentWeatherCondition': currentWeatherCondition,
    };
  }
}
