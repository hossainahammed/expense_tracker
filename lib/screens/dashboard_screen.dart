import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../app_bar..dart';
import '../models/expense.dart';

class DashboardScreen extends StatelessWidget {
  final List<Expense> expenses;
  final String currency;
  final double budgetLimit;

  const DashboardScreen({
    super.key,
    required this.expenses,
    required this.currency,
    required this.budgetLimit,
  });

  @override
  Widget build(BuildContext context) {
    final totalExpense = expenses.fold(0.0, (sum, e) => sum + e.amount);
    final remaining = budgetLimit - totalExpense;

    // Aggregate amounts by category
    Map<String, double> dataMap = {};
    for (var e in expenses) {
      dataMap[e.category] = (dataMap[e.category] ?? 0) + e.amount;
    }

    // Define colors for categories
    final colorList = <Color>[
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.cyan,
      Colors.amber,
      Colors.teal,
      Colors.pink,
      Colors.lime,
      Colors.indigo,
      Colors.brown,
      Colors.deepOrange,
      Colors.lightBlue,
      Colors.lightGreen,
    ];

    final categories = dataMap.keys.toList();

    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          if (remaining < 0)
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.redAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.warning, color: Colors.white),
                  SizedBox(width: 8),
                  Text("Budget Limit Exceeded!", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    color: Colors.deepPurple[300],
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          const Text('Total Expense', style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text('$currency${totalExpense.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Card(
                    color: remaining < 0 ? Colors.redAccent : Colors.teal,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          const Text('Available Balance', style: TextStyle( fontSize: 15,fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text('$currency${remaining.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Pie chart + legend
          SizedBox(
            height: 250,
            child: expenses.isEmpty
                ? const Center(child: Text("No data to show in pie chart."))
                : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Pie chart on left side
                  Expanded(
                    flex: 2,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(
                        PieChartData(
                          sectionsSpace: 2,
                          centerSpaceRadius: 40,
                          sections: List.generate(categories.length, (index) {
                            final category = categories[index];
                            final amount = dataMap[category]!;
                            final color = colorList[index % colorList.length];
                            final total = totalExpense == 0 ? 1 : totalExpense;
                            final percent = (amount / total) * 100;

                            return PieChartSectionData(
                              color: color,
                              value: amount,
                              title: '${percent.toStringAsFixed(1)}%',
                              radius: 60,
                              titleStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Legend on right side (without amount, truncate text)
                  Expanded(
                    flex: 1,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final color = colorList[index % colorList.length];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  category,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          // List of expenses below the chart
          Expanded(
            child: expenses.isEmpty
                ? const Center(child: Text("No expenses added yet."))
                : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: expenses.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final expense = expenses[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: colorList[categories.indexOf(expense.category) % colorList.length],
                    child: Text(
                      expense.category[0].toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  // title: Text(expense.title),
                  title: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        const TextSpan(text: 'Title: ', style: TextStyle(fontWeight: FontWeight.normal)),
                        TextSpan(text: expense.title),
                      ],
                    ),
                  ),
                  // subtitle: Text(expense.category),
                  subtitle: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        const TextSpan(text: 'Category: ', style: TextStyle(fontWeight: FontWeight.normal)),
                        TextSpan(text: expense.category, style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  trailing: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$currency',
                          style: DefaultTextStyle.of(context).style,
                        ),
                        const TextSpan(text: ' '),

                        TextSpan(
                          text: expense.amount.toStringAsFixed(0),
                          //style: const TextStyle(fontWeight: FontWeight.bold),
                          style: DefaultTextStyle.of(context).style.copyWith(
                            fontWeight: FontWeight.bold,),
                        ),
                        const TextSpan(text: ' '),

                        TextSpan(
                          text: '/-',
                          style: DefaultTextStyle.of(context).style,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}