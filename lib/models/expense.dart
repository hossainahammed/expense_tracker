class Expense {
  final String title;
  final double amount;
  final String category;
  final DateTime date;

  Expense({
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'amount': amount,
    'category': category,
    'date': date.toIso8601String(),
  };

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
    title: json['title'],
    amount: json['amount'],
    category: json['category'],
    date: DateTime.parse(json['date']),
  );
}



// class Expense {
//   String title;
//   double amount;
//   String category;
//   DateTime date;
//
//   Expense({required this.title, required this.amount, required this.category, required this.date});
// }
