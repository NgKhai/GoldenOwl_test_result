class DayForecast {
  DateTime date;
  String weatherIcon;
  String? weatherIconUrl;
  double minTemperature;
  double maxTemperature;
  double maxWindSpeed;
  int avgHumidity;
  int totalPrecipMM;
  int totalSnowCM;
  double avgVisibility;
  List<dynamic> hourlyWeatherForecast;
  String currentWeatherCondition;

  DayForecast({
    required this.date,
    required this.weatherIcon,
    required this.weatherIconUrl,
    required this.minTemperature,
    required this.maxTemperature,
    required this.maxWindSpeed,
    required this.avgHumidity,
    required this.totalPrecipMM,
    required this.totalSnowCM,
    required this.avgVisibility,
    required this.hourlyWeatherForecast,
    required this.currentWeatherCondition,
  });

  factory DayForecast.fromJson(Map<String, dynamic> json) {
    var day = json["day"] ?? {};
    var condition = day["condition"] ?? {};

    String weatherIconPath = condition.isNotEmpty
        ? '${condition["text"]?.toString().replaceAll(' ', '').toLowerCase()}.png'
        : 'logo.png';

    return DayForecast(
      date: DateTime.parse(json["date"] ?? "2024-11-28"),
      weatherIcon: weatherIconPath,
      weatherIconUrl: condition["icon"],
      minTemperature: day["mintemp_c"]?.toDouble() ?? 0.0,
      maxTemperature: day["maxtemp_c"]?.toDouble() ?? 0.0,
      maxWindSpeed: day["maxwind_kph"]?.toDouble() ?? 0.0,
      avgHumidity: day["avghumidity"]?.toInt() ?? 0,
      totalPrecipMM: day["totalprecip_mm"]?.toInt() ?? 0,
      totalSnowCM: day["totalsnow_cm"]?.toInt() ?? 0,
      avgVisibility: day["avgvis_km"]?.toDouble() ?? 0.0,
      hourlyWeatherForecast: json["hour"] ?? [],
      currentWeatherCondition: condition["text"] ?? 'Unknown',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'weatherIcon': weatherIcon,
      'weatherIconUrl': weatherIconUrl,
      'minTemperature': minTemperature,
      'maxTemperature': maxTemperature,
      'maxWindSpeed': maxWindSpeed,
      'avgHumidity': avgHumidity,
      'totalPrecipMM': totalPrecipMM,
      'totalSnowCM': totalSnowCM,
      'avgVisibility': avgVisibility,
      'hourlyWeatherForecast': hourlyWeatherForecast,
      'currentWeatherCondition': currentWeatherCondition,
    };
  }
}
