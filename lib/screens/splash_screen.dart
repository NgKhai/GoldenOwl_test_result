import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/api_service.dart';
import '../utils/constants.dart';
import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  final ApiService apiService;

  const SplashScreen({super.key, required this.apiService});

  Future<void> _fetchWeatherData() async {
    await apiService.getAndUpdateWeatherData("Ho Chi Minh");
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _fetchWeatherData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error fetching data: ${snapshot.error}',
                  style: GoogleFonts.rubik(),
                  textAlign: TextAlign.center,
                ),
              );
            }
            return const HomeScreen();
          } else {
            return Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: linearGradientBlue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png', width: 100, height: 100),
                  const SizedBox(height: defaultPadding),
                  Text(
                    'Flutter Weather',
                    style: GoogleFonts.rubik(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const CircularProgressIndicator(color: Colors.white),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
