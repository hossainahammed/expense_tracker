import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpensePieChart extends StatelessWidget {
  final List<Expense> expenses;
  final String currency;

  const ExpensePieChart({super.key, required this.expenses, required this.currency});

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) return const Center(child: Text("No expenses to display."));

    Map<String,double> dataMap = {};
    for (var e in expenses) {
      dataMap[e.category] = (dataMap[e.category] ?? 0) + e.amount;
    }

    return ListView(
      children: dataMap.entries.map((entry) {
        return ListTile(
          title: Text(entry.key),
          trailing: Text('$currency${entry.value.toStringAsFixed(2)}'),
        );
      }).toList(),
    );
  }
}

//   Color _getCategoryColor(String category) {
//     switch (category) {
//       case 'Food':
//         return Colors.redAccent;
//       case 'Transport':
//         return Colors.blueAccent;
//       case 'Entertainment':
//         return Colors.green;
//       case 'Bills':
//         return Colors.orange;
//       case 'Shopping':
//         return Colors.pinkAccent;
//       case 'Hospital':
//         return Colors.red;
//       case 'Medichine':
//         return Colors.lightBlue;
//       default:
//         return Colors.grey;
//     }
//   }
// }