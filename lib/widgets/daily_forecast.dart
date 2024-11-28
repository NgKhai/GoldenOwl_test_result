import 'package:flutter/material.dart';
import '../providers/forecast_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/dayforecast.dart';
import '../responsive.dart';
import '../utils/constants.dart';

class DailyForecast extends StatefulWidget {
  final List<dynamic> dailyWeatherForecast;
  final bool isDay;

  const DailyForecast({
    super.key,
    required this.dailyWeatherForecast,
    required this.isDay,
  });

  @override
  State<DailyForecast> createState() => _DailyForecastState();
}

class _DailyForecastState extends State<DailyForecast> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<dynamic> dailyWeatherForecast = widget.dailyWeatherForecast;

    return ChangeNotifierProvider(
      create: (context) => ForecastProvider(),
      child: Consumer<ForecastProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Daily Forecast",
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleMedium,
                  ),
                  ElevatedButton.icon(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding * 1.5,
                        vertical: defaultPadding,
                      ),
                    ),
                    onPressed: () {
                      provider.toggleShowAllItems();
                    },
                    icon: provider.showAllItems ? const Icon(Icons.close) : const Icon(Icons.add),
                    label: Text(provider.showAllItems ? "Show Less" : "Show More",
                        style: GoogleFonts.rubik()),
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding),
              Responsive(
                mobile: DailyForecastGridView(
                  crossAxisCount: size.width < 650 ? 2 : 4,
                  childAspectRatio: size.width < 650 ? 1.3 : 1,
                  dailyWeatherForecast: provider.showAllItems
                      ? dailyWeatherForecast
                      : dailyWeatherForecast.take(4).toList(),
                  // Show either 4 or all items
                  activeItem: 0,
                ),
                desktop: DailyForecastGridView(
                  childAspectRatio: size.width < 1400 ? 1.1 : 1.4,
                  dailyWeatherForecast: provider.showAllItems
                      ? dailyWeatherForecast
                      : dailyWeatherForecast.take(4).toList(),
                  // Show either 4 or all items
                  activeItem: 0,
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}


class DailyForecastGridView extends StatelessWidget {
  const DailyForecastGridView({
    super.key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
    required this.dailyWeatherForecast,
    required this.activeItem,
  });

  final int crossAxisCount;
  final double childAspectRatio;

  final int activeItem;

  final List<dynamic> dailyWeatherForecast;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        itemCount: dailyWeatherForecast.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: defaultPadding,
          crossAxisSpacing: defaultPadding,
          childAspectRatio: childAspectRatio,
        ),
        itemBuilder: (context, index) =>
            DailyInfoCard(
                activeItem: activeItem,
                day: DateFormat('dd').format(
                    DateTime.parse(dailyWeatherForecast[index]['date'])),
                index: index,
                weather: DayForecast.fromJson(dailyWeatherForecast[index])));
  }
}

class DailyInfoCard extends StatefulWidget {
  final DayForecast? weather;
  final String day;
  final int index;
  final int activeItem;

  const DailyInfoCard({
    super.key,
    required this.weather,
    required this.day,
    required this.index,
    required this.activeItem,
  });

  @override
  State<DailyInfoCard> createState() => _DailyInfoCardState();
}

class _DailyInfoCardState extends State<DailyInfoCard> {

  @override
  Widget build(BuildContext context) {
    String formattedDate =
    DateFormat('ddMMM, EEEE').format(widget.weather!.date);
    String day = formattedDate.substring(6, 10);

    bool isToday =
        DateTime
            .now()
            .day
            .toString() == formattedDate.substring(0, 2);
    bool isActive = widget.activeItem == widget.index;

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: isActive ? primaryColor.withOpacity(0.3) : secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(defaultPadding * 0.75),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: isActive ? secondaryColor : primaryColor.withOpacity(
                      0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Image.network(
                  widget.weather?.weatherIconUrl ??
                      'assets/images/day/${widget.weather?.weatherIcon}',
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return Image.asset(
                      'assets/images/logo.png',
                      height: 30,
                      width: 20,
                    );
                  },
                ),
              ),
              Text(
                "${widget.weather?.avgHumidity} %",
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white70),
              ),
            ],
          ),
          Text(
            isToday ? "Today" : "${widget.weather?.date.toString().substring(
                8, 10)} - $day",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.rubik(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.weather?.maxTemperature} \u00B0C",
                style: Theme
                    .of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white70),
              ),
              Text(
                "${widget.weather?.maxWindSpeed.toString()} km/h",
                style: GoogleFonts.rubik(
                    textStyle: Theme
                        .of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.white)
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}