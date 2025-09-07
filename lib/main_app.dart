import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/expense.dart';
import 'screens/dashboard_screen.dart';
import 'screens/expenses_screen.dart';
import 'screens/settings_screen.dart';
import 'providers/settings_provider.dart';
import 'package:provider/provider.dart';

class ExpenseTrackerApp extends StatefulWidget {
  const ExpenseTrackerApp({Key? key}) : super(key: key);

  @override
  State<ExpenseTrackerApp> createState() => _ExpenseTrackerAppState();
}

class _ExpenseTrackerAppState extends State<ExpenseTrackerApp> {
  int _selectedIndex = 0;
  List<Expense> _expenses = [];

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  Future<void> _saveExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _expenses.map((e) => e.toJson()).toList();
    prefs.setString('expenses', jsonEncode(jsonList));
  }

  Future<void> _loadExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('expenses');
    if (data != null) {
      final List decoded = jsonDecode(data);
      setState(() {
        _expenses = decoded.map((e) => Expense.fromJson(e)).toList();
      });
    }
  }

  void _addExpense(Expense expense) {
    setState(() {
      _expenses.add(expense);
    });
    _saveExpenses();
  }

  void _editExpense(Expense expense, int index) {
    setState(() {
      _expenses[index] = expense;
    });
    _saveExpenses();
  }

  void _deleteExpense(int index) {
    setState(() {
      _expenses.removeAt(index);
    });
    _saveExpenses();
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    final screens = [
      DashboardScreen(
        expenses: _expenses,
        currency: settings.currency,
        budgetLimit: settings.budgetGoal,
      ),
      ExpensesScreen(
        expenses: _expenses,
        currency: settings.currency,
        onAddExpense: _addExpense,
        onEditExpense: _editExpense,
        onDeleteExpense: _deleteExpense,
      ),
      const SettingsScreen(),
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


// import 'package:expense_tracker/providers/settings_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'models/expense.dart';
// import 'screens/dashboard_screen.dart';
// import 'screens/expenses_screen.dart';
// import 'screens/settings_screen.dart';
//
//
// class ExpenseTrackerApp extends StatefulWidget {
//   const ExpenseTrackerApp({Key? key}) : super(key: key);
//
//   @override
//   State<ExpenseTrackerApp> createState() => _ExpenseTrackerAppState();
// }
//
// class _ExpenseTrackerAppState extends State<ExpenseTrackerApp> {
//   int _selectedIndex = 0;
//
//   List<Expense> _expenses = [];
//
//   void _addExpense(Expense expense) => setState(() => _expenses.add(expense));
//   void _editExpense(Expense expense, int index) => setState(() => _expenses[index] = expense);
//   void _deleteExpense(int index) => setState(() => _expenses.removeAt(index));
//
//   @override
//   Widget build(BuildContext context) {
//     final settings = Provider.of<SettingsProvider>(context);
//
//     final screens = [
//       DashboardScreen(
//         expenses: _expenses,
//         currency: settings.currency,
//         budgetLimit: settings.budgetGoal,
//       ),
//       ExpensesScreen(
//         expenses: _expenses,
//         currency: settings.currency,
//         onAddExpense: _addExpense,
//         onEditExpense: _editExpense,
//         onDeleteExpense: _deleteExpense,
//       ),
//       const SettingsScreen(), // Now reads everything from provider
//     ];
//
//     return Scaffold(
//       body: screens[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: (i) => setState(() => _selectedIndex = i),
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
//           BottomNavigationBarItem(icon: Icon(Icons.list), label: "Expenses"),
//           BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
//         ],
//       ),
//     );
//   }
// }
//



// class ExpenseTrackerApp extends StatefulWidget {
//   const ExpenseTrackerApp({super.key});
//
//   @override
//   State<ExpenseTrackerApp> createState() => _ExpenseTrackerAppState();
// }
//
// class _ExpenseTrackerAppState extends State<ExpenseTrackerApp> {
//   int _selectedIndex = 0;
//
//   List<Expense> _expenses = [];
//   String _currency = '৳';
//   double _budgetLimit = 2000.0;
//   bool _isDarkMode = false;
//
//   void _addExpense(Expense expense) => setState(() => _expenses.add(expense));
//   void _editExpense(Expense expense, int index) => setState(() => _expenses[index] = expense);
//   void _deleteExpense(int index) => setState(() => _expenses.removeAt(index));
//
//   @override
//   Widget build(BuildContext context) {
//     final screens = [
//       DashboardScreen(expenses: _expenses, currency: _currency, budgetLimit: _budgetLimit),
//       ExpensesScreen(
//         expenses: _expenses,
//         currency: _currency,
//         onAddExpense: _addExpense,
//         onEditExpense: _editExpense,
//         onDeleteExpense: _deleteExpense,
//       ),
//       SettingsScreen(
//         currency: _currency,
//         budgetLimit: _budgetLimit,
//         isDarkMode: _isDarkMode,
//         onCurrencyChanged: (c) => setState(() => _currency = c),
//         onBudgetChanged: (b) => setState(() => _budgetLimit = b),
//         onThemeChanged: (v) => setState(() => _isDarkMode = v),
//       ),
//     ];
//
//     return Scaffold(
//       body: screens[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: (i) => setState(() => _selectedIndex = i),
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
//           BottomNavigationBarItem(icon: Icon(Icons.list), label: "Expenses"),
//           BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
//         ],
//       ),
//     );
//   }
// }
