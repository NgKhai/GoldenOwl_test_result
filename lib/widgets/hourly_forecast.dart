import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/weather.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';

class HourlyForecast extends StatelessWidget {
  const HourlyForecast({
    super.key,
    required this.weather,
  });

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hourly Forecast",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              horizontalMargin: 0,
              columnSpacing: defaultPadding,
              columns: const [
                DataColumn(
                  label: Text("Hours"),
                ),
                DataColumn(
                  label: Text("Temperature"),
                ),
                DataColumn(
                  label: Text("Chance Of Rain"),
                ),
              ],
              rows: List.generate(
                weather.hourlyWeatherForecast!.length,
                (index) => hourlyForecastDataRow(
                    weather.hourlyWeatherForecast?[index], true),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow hourlyForecastDataRow(dynamic weatherPerHour, bool isFirstDay) {
  String currentTimeHour = DateFormat('HH').format(DateTime.now());

  String forecastTime = weatherPerHour["time"].substring(11, 16) ?? '0';

  String forecastHour = forecastTime.substring(0, 2);

  String forecastWeatherCondition = weatherPerHour["condition"]["text"] ?? '';

  String forecastWeatherIcon =
      Helpers.getWeatherIconPath(forecastWeatherCondition);

  String forecastTemperature =
      weatherPerHour["temp_c"].toStringAsFixed(1) ?? '0';

  String forecastChanceOfRain =
      weatherPerHour["chance_of_rain"].toStringAsFixed(1) ?? '0';

  return DataRow(
    color: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (currentTimeHour == forecastHour && isFirstDay) {
        return primaryColor;
      }
      return null;  // Use the default value.
    }),
    cells: [
      DataCell(
        Row(
          children: [
            // SvgPicture.asset(
            //   fileInfo.icon,
            //   height: 30,
            //   width: 30,
            // ),
            Image.network(
              weatherPerHour["condition"]["icon"] ??
              'assets/images/day/$forecastWeatherIcon',

              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                return Image.asset(
                  'assets/images/logo.png',
                  height: 30,
                  width: 20,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(forecastTime, style: GoogleFonts.rubik()),
            ),
          ],
        ),
      ),
      DataCell(
          Text("$forecastTemperature \u00B0C", style: GoogleFonts.rubik())),
      // DataCell(Text(fileInfo.size)),
      DataCell(
          Text("$forecastChanceOfRain %", style: GoogleFonts.rubik())),
    ],
  );
}
