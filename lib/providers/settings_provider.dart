import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  double _budgetGoal = 1000;
  String _currency = "৳";
  bool _isDarkMode = false;

  double get budgetGoal => _budgetGoal;
  String get currency => _currency;
  bool get isDarkMode => _isDarkMode;

  SettingsProvider() {
    _loadSettings();
  }

  void setBudget(double value) {
    _budgetGoal = value;
    _saveSettings();
    notifyListeners();
  }

  void setCurrency(String value) {
    _currency = value;
    _saveSettings();
    notifyListeners();
  }

  void toggleTheme(bool value) {
    _isDarkMode = value;
    _saveSettings();
    notifyListeners();
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('budgetGoal', _budgetGoal);
    prefs.setString('currency', _currency);
    prefs.setBool('isDarkMode', _isDarkMode);
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _budgetGoal = prefs.getDouble('budgetGoal') ?? 1000;
    _currency = prefs.getString('currency') ?? "৳";
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }
}



// import 'package:flutter/material.dart';
//
// class SettingsProvider with ChangeNotifier {
//   double _budgetGoal = 1000; // default
//   String _currency = "৳"; // default BDT
//   bool _isDarkMode = false; // default light mode
//
//   double get budgetGoal => _budgetGoal;
//   String get currency => _currency;
//   bool get isDarkMode => _isDarkMode;
//
//   void setBudget(double value) {
//     _budgetGoal = value;
//     notifyListeners();
//   }
//
//   void setCurrency(String value) {
//     _currency = value;
//     notifyListeners();
//   }
//
//   void toggleTheme(bool value) {
//     _isDarkMode = value;
//     notifyListeners();
//   }
// }





// import 'package:flutter/material.dart';
//
// class SettingsProvider with ChangeNotifier {
//   double _budgetGoal = 1000; // default
//   String _currency = "৳"; // default BDT
//
//   double get budgetGoal => _budgetGoal;
//   String get currency => _currency;
//
//   void setBudget(double value) {
//     _budgetGoal = value;
//     notifyListeners();
//   }
//
//   void setCurrency(String value) {
//     _currency = value;
//     notifyListeners();
//   }
// }
