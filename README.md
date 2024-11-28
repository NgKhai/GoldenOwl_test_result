
# Flutter Weather Web App 🌦️

## Overview

A simple and responsive weather web application built using Flutter, providing real-time weather data for any city worldwide.

## Features

- 🌍 Global weather search
- 📊 Detailed weather information (temperature, humidity, wind speed, etc.)
- 📱 Responsive design for desktop, tablet, and mobile
- 🔄 Refresh weather data

![](https://github.com/NgKhai/GoldenOwl_test_result/blob/master/assets/result.gif)

---

## Getting Started

### Prerequisites

Ensure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- An IDE (e.g., [VSCode](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio))

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/NgKhai/flutter-weather-web-app.git
   cd flutter-weather-web-app
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the app** (in your preferred browser):
   ```bash
   flutter run -d chrome
   ```

4. **Build for web**:
   ```bash
   flutter build web
   ```

---

## API Integration

This app uses the [WeatherAPI](https://weatherAPI.com/) to fetch weather data.

### Setting up the API Key

1. **Sign up** at [WeatherAPI](https://weatherAPI.com/) and get your API key.
2. **Add the API key** in your code:

   Create a `.env` file in the root directory and add:
   ```env
   API_KEY=your_api_key_here
   ```

---

## Deployment

1. **Web Deploy**:
   - https://flutter-weather-web-app-5bcda.web.app/

2. **Deploy** to preferred platform:
   - [Firebase Hosting](https://firebase.google.com/docs/hosting/)

---
