import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class ExpenseTile extends StatelessWidget {
  final String title;
  final double amount;
  final String category;
  final DateTime date;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ExpenseTile({
    super.key,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getCategoryColor(category),
          child: Text(category[0], style: const TextStyle(color: Colors.white)),
        ),
        title: Text(title),
        subtitle: Text(intl.DateFormat('yyyy-MM-dd').format(date)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'R${amount.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(category),
          ],
        ),
        onTap: onEdit,
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Food':
        return Colors.green;
      case 'Transport':
        return Colors.blue;
      case 'Rent':
        return Colors.orange;
      case 'Entertainment':
        return Colors.purple;
      case 'Shopping':
        return Colors.pink;
      case 'Healthcare':
        return Colors.red;
      case 'Education':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }
}
