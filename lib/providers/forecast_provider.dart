import 'package:flutter/material.dart';

class ForecastProvider with ChangeNotifier {
  bool _showAllItems = false;

  bool get showAllItems => _showAllItems;

  void toggleShowAllItems() {
    _showAllItems = !_showAllItems;
    notifyListeners();
  }
}
