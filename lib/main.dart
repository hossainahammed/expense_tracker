import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'screens/dashboard_screen.dart';
import 'screens/expenses_screen.dart';
import 'screens/settings_screen.dart';
import 'models/expense.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const ExpenseTrackerApp(),
    ),
  );
}

class ExpenseTrackerApp extends StatefulWidget {
  const ExpenseTrackerApp({super.key});

  @override
  State<ExpenseTrackerApp> createState() => _ExpenseTrackerAppState();
}

class _ExpenseTrackerAppState extends State<ExpenseTrackerApp> {
  int _selectedIndex = 0;

  List<Expense> _expenses = [];
  String _currency = '৳';
  double _budgetLimit = 2000.0;
  bool _isDarkMode = false;

  // Expense operations
  void _addExpense(Expense expense) {
    setState(() => _expenses.add(expense));
  }

  void _editExpense(Expense expense, int index) {
    setState(() => _expenses[index] = expense);
  }

  void _deleteExpense(int index) {
    setState(() => _expenses.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      DashboardScreen(
        expenses: _expenses,
        currency: _currency,
        budgetLimit: _budgetLimit,
      ),
      ExpensesScreen(
        expenses: _expenses,
        currency: _currency,
        onAddExpense: _addExpense,
        onEditExpense: _editExpense,
        onDeleteExpense: _deleteExpense,
      ),
      SettingsScreen(
        currency: _currency,
        budgetLimit: _budgetLimit,
        isDarkMode: _isDarkMode,
        onCurrencyChanged: (c) => setState(() => _currency = c),
        onBudgetChanged: (b) => setState(() => _budgetLimit = b),
        onThemeChanged: (v) => setState(() => _isDarkMode = v),
      ),
      DashboardScreen(
        expenses: _expenses,
        currency: _currency,
        budgetLimit: _budgetLimit,
      ),
    ];

    return MaterialApp(
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (i) => setState(() => _selectedIndex = i),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "Expenses"),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
          ],
        ),
      ),
    );
  }
}
