import 'package:flutter/material.dart';
import '../widgets/current_weather.dart';
import '../widgets/daily_forecast.dart';
import '../widgets/hourly_forecast.dart';
import 'package:provider/provider.dart';

import '../../../responsive.dart';
import '../controllers/menu_controller.dart';
import '../models/weather.dart';
import '../providers/weather_provider.dart';
import '../utils/constants.dart';
import '../widgets/header.dart';
import '../widgets/side_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    Weather weather = Provider
        .of<WeatherProvider>(context)
        .weather;

    return Scaffold(
      key: context.read<MenuuController>().scaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(
                // flex: 1, (default)
                child: SideMenu(),
              ),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    const Header(),
                    const SizedBox(height: defaultPadding),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              if (Responsive.isMobile(context))
                                CurrentWeather(
                                    locationName: weather.locationName,
                                    temperature: weather.temperature.toString(),
                                    imageUrl: weather.weatherIconUrl,
                                    currentDate: weather.currentDate,
                                    currentWeatherCondition:
                                        weather.currentWeatherCondition,
                                    windSpeed: weather.windSpeed.toString(),
                                    humidity: weather.humidity.toString(),
                                    cloud: weather.cloud.toString(),
                                    pressure: weather.pressure.toString()),
                              if (Responsive.isMobile(context))
                                const SizedBox(height: defaultPadding),
                              DailyForecast(
                                  dailyWeatherForecast:
                                      weather.dailyWeatherForecast ?? [],
                                  isDay: weather.isDay ?? true),
                              const SizedBox(height: defaultPadding),
                              HourlyForecast(weather: weather),
                              if (Responsive.isMobile(context))
                                const SizedBox(height: defaultPadding),
                            ],
                          ),
                        ),
                        const SizedBox(width: defaultPadding),
                        if (!Responsive.isMobile(context))
                          Expanded(
                            flex: 2,
                            child: CurrentWeather(
                                locationName: weather.locationName,
                                temperature: weather.temperature.toString(),
                                imageUrl: weather.weatherIconUrl,
                                currentDate: weather.currentDate,
                                currentWeatherCondition:
                                    weather.currentWeatherCondition,
                                windSpeed: weather.windSpeed.toString(),
                                humidity: weather.humidity.toString(),
                                cloud: weather.cloud.toString(),
                                pressure: weather.pressure.toString()),
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
