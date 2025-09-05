import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  double _budgetGoal = 1000; // default
  String _currency = "৳"; // default BDT

  double get budgetGoal => _budgetGoal;
  String get currency => _currency;

  void setBudget(double value) {
    _budgetGoal = value;
    notifyListeners();
  }

  void setCurrency(String value) {
    _currency = value;
    notifyListeners();
  }
}
