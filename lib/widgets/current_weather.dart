import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({
    super.key,
    required this.locationName,
    required this.temperature,
    required this.imageUrl,
    required this.currentDate,
    required this.currentWeatherCondition,
    required this.windSpeed,
    required this.humidity,
    required this.cloud,
    required this.pressure,
  });

  final String? locationName;
  final String? temperature;
  final String? imageUrl;
  final String? currentDate;
  final String? currentWeatherCondition;
  final String? windSpeed;
  final String? humidity;
  final String? cloud;
  final String? pressure;

  @override
  Widget build(BuildContext context) {
    String? weatherIconUrl = imageUrl?.replaceAll("64x64", "128x128");

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            locationName ?? "No Location",
            style: GoogleFonts.rubik(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: defaultPadding),
          Text(
            "$temperature \u00B0C",
            style: GoogleFonts.rubik(
                textStyle: Theme.of(context).textTheme.titleLarge),
          ),
          const SizedBox(height: defaultPadding),
          SizedBox(
            height: 150,
            child: Image.network(
              weatherIconUrl ?? '',
              fit: BoxFit.contain,
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                return Image.asset('assets/images/logo.png',
                    fit: BoxFit.contain);
              },
            ),
          ),
          const SizedBox(height: defaultPadding),
          Text(
            currentWeatherCondition ?? '',
            style: GoogleFonts.rubik(
                textStyle: Theme.of(context).textTheme.titleMedium),
          ),
          Text(
            currentDate ?? '',
            style: GoogleFonts.rubik(
                textStyle: Theme.of(context).textTheme.titleSmall),
          ),
          const SizedBox(height: defaultPadding),
          WeatherInfoCard(
              icon: "wind.png",
              title: "Wind Speed",
              unit: "km/h",
              value: windSpeed ?? ''),
          WeatherInfoCard(
              icon: "humidity.png",
              title: "Humidity",
              unit: "%",
              value: humidity ?? ''),
          WeatherInfoCard(
              icon: "cloud.png",
              title: "Cloud Cover",
              unit: "Okta",
              value: cloud ?? ''),
          WeatherInfoCard(
              icon: "pressure.png",
              title: "Air Pressure",
              unit: "mb",
              value: pressure ?? ''),
        ],
      ),
    );
  }
}

class WeatherInfoCard extends StatelessWidget {
  const WeatherInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.unit,
    required this.value,
  });

  final String icon, title, unit, value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: defaultPadding),
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultPadding),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: Image.asset(
              'assets/images/$icon',
              fit: BoxFit.contain,
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                return Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.rubik(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "$value $unit",
                    style: GoogleFonts.rubik(
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.white70)),
                  ),
                ],
              ),
            ),
          ),
          // Text(amountOfFiles)
        ],
      ),
    );
  }
}
