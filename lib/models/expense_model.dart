class Expense {
  final String? id;
  final String title;
  final double amount;
  final String category;
  final DateTime date;
  final DateTime createdAt;

  Expense({
    this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.createdAt,
  });

  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'amount': amount,
      'category': category,
      'date': date,
      'createdAt': createdAt,
    };
  }

  // Create from Firestore document
  factory Expense.fromMap(String id, Map<String, dynamic> map) {
    return Expense(
      id: id,
      title: map['title'] ?? '',
      amount: (map['amount'] ?? 0.0).toDouble(),
      category: map['category'] ?? 'Other',
      date: (map['date'] as dynamic).toDate(),
      createdAt: (map['createdAt'] as dynamic).toDate(),
    );
  }
}
