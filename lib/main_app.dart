import 'package:flutter/material.dart';
import 'models/expense.dart';
import 'screens/dashboard_screen.dart';
import 'screens/expenses_screen.dart';
import 'screens/settings_screen.dart';

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

  void _addExpense(Expense expense) => setState(() => _expenses.add(expense));
  void _editExpense(Expense expense, int index) => setState(() => _expenses[index] = expense);
  void _deleteExpense(int index) => setState(() => _expenses.removeAt(index));

  @override
  Widget build(BuildContext context) {
    final screens = [
      DashboardScreen(expenses: _expenses, currency: _currency, budgetLimit: _budgetLimit),
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
    ];

    return Scaffold(
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
    );
  }
}
