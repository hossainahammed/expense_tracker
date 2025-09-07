import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../app_bar..dart';
import '../models/expense.dart';

class ExpensesScreen extends StatefulWidget {
  final List<Expense> expenses;
  final String currency;
  final Function(Expense) onAddExpense;
  final Function(Expense, int) onEditExpense;
  final Function(int) onDeleteExpense;

  const ExpensesScreen({
    super.key,
    required this.expenses,
    required this.currency,
    required this.onAddExpense,
    required this.onEditExpense,
    required this.onDeleteExpense,
  });

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  String _filterCategory = 'All';
  String _sortBy = 'Newest';
  final List<String> categories = [
    'Food', 'Groceries', 'Transport', 'Entertainment', 'Bills', 'Shopping',
    'Housing','Healthcare','Education','Insurance','Savings','Personal Care','Travel','Gifts','Miscellaneous'
  ];

  void _showExpenseForm({Expense? e, int? index}) {
    String selectedCategory = e?.category ?? categories.first;
    final titleController = TextEditingController(text: e?.title ?? '');
    final amountController = TextEditingController(text: e?.amount.toString() ?? '');

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16, right: 16, top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
            const SizedBox(height: 10),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount'),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              value: selectedCategory,
              items: categories.map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
              onChanged: (value) { if (value != null) selectedCategory = value; },
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (titleController.text.isEmpty || double.tryParse(amountController.text) == null) return;
                  final expense = Expense(
                    title: titleController.text,
                    amount: double.parse(amountController.text),
                    category: selectedCategory,
                    date: e?.date ?? DateTime.now(),
                  );
                  if (index != null) widget.onEditExpense(expense, index);
                  else widget.onAddExpense(expense);
                  Navigator.pop(context);
                },
                child: Text(e != null ? "Update Expense" : "Add Expense"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var filtered = _filterCategory == 'All'
        ? widget.expenses
        : widget.expenses.where((e) => e.category == _filterCategory).toList();

    if (_sortBy == 'Newest') filtered.sort((a, b) => b.date.compareTo(a.date));
    else filtered.sort((a, b) => a.amount.compareTo(b.amount));

    return Scaffold(
      appBar: buildAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showExpenseForm(),
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropdownButton<String>(
                value: _filterCategory,
                items: ['All', ...categories].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (v) { if (v != null) setState(() => _filterCategory = v); },
              ),
              DropdownButton<String>(
                value: _sortBy,
                items: ['Newest','Amount'].map((c) => DropdownMenuItem(value: c, child: Text('Sort by $c'))).toList(),
                onChanged: (v) { if (v != null) setState(() => _sortBy = v); },
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final e = filtered[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Text(e.category[0])),
                    title: Text(e.title),
                    subtitle: Text('${DateFormat.yMMMd().format(e.date)} | ${e.category} | ${widget.currency}${e.amount}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(icon: const Icon(Icons.edit), onPressed: () => _showExpenseForm(e: e, index: index)),
                        IconButton(icon: const Icon(Icons.delete), onPressed: () => widget.onDeleteExpense(index)),
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
