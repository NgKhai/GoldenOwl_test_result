import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'controllers/menu_controller.dart';
import 'providers/forecast_provider.dart';
import 'services/api_service.dart';
import 'providers/weather_provider.dart';
import 'screens/splash_screen.dart';
import 'utils/constants.dart';

Future<void> main() async {
  await dotenv.load();
  WeatherProvider weatherProvider = WeatherProvider();
  ApiService apiService = ApiService(weatherProvider);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: weatherProvider),
        Provider<ApiService>.value(value: apiService),
        ChangeNotifierProvider<ForecastProvider>(create: (context) => ForecastProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ApiService apiService =
        ApiService(Provider.of<WeatherProvider>(context, listen: false));

        return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Weather',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<MenuuController>(
            create: (context) => MenuuController(),
          ),
        ],
        child: SplashScreen(apiService: apiService),
      ),
    );
  }
}
