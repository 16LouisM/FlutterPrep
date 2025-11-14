import 'package:flutter/material.dart';
import 'package:flutter_prep/pages/login_page.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_prep/widgets/summary_card.dart';
import 'package:flutter_prep/services/auth_service.dart';
import 'package:flutter_prep/pages/add_expense_page.dart';
import 'package:intl/intl.dart' as intl;

class DashboardPage extends StatefulWidget {
  static const routeName = '/dashboard';
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Future<void> _logout(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signOut();
      if (!mounted) return;
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Logged Out'),
          content: const Text('You have been logged out successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                  (route) => false,
                );
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logout failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String _formatCurrency(double amount) {
    final formatter = intl.NumberFormat('#,##0.00', 'en_US');
    return 'R${formatter.format(amount)}';
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SmartSpend Dashboard'),
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: user == null
          ? const Center(child: Text('Please log in'))
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .collection('expenses')
                  .orderBy('date', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return _buildPlaceholder();
                }

                final expenses = snapshot.data!.docs;
                final now = DateTime.now();
                double totalThisMonth = 0;
                final Map<String, double> categoryTotals = {};

                for (var doc in expenses) {
                  final data = doc.data() as Map<String, dynamic>;
                  final amount = (data['amount'] ?? 0).toDouble();
                  final date = (data['date'] as Timestamp).toDate();
                  final category = data['category'] ?? 'Other';

                  if (date.month == now.month && date.year == now.year) {
                    totalThisMonth += amount;
                  }
                  categoryTotals[category] =
                      (categoryTotals[category] ?? 0) + amount;
                }

                String topCategory = 'None';
                double topCategoryAmount = 0;
                categoryTotals.forEach((category, total) {
                  if (total > topCategoryAmount) {
                    topCategoryAmount = total;
                    topCategory = category;
                  }
                });

                int totalCategories = categoryTotals.keys.length;
                double average =
                    totalCategories > 0 ? totalThisMonth / totalCategories : 0;

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back, ${user.email?.split('@').first ?? 'User'}!',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Here\'s your spending overview',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Summary cards
                      Row(
                        children: [
                          Expanded(
                            child: SummaryCard(
                              icon: Icons.attach_money,
                              title: 'This Month',
                              value: _formatCurrency(totalThisMonth),
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: SummaryCard(
                              icon: Icons.receipt,
                              title: 'Total Expenses',
                              value: '$totalCategories',
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: SummaryCard(
                              icon: Icons.category,
                              title: 'Top Category',
                              value: topCategory,
                              color: Colors.orange,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: SummaryCard(
                              icon: Icons.trending_up,
                              title: 'Average',
                              value: _formatCurrency(average),
                              color: Colors.purple,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      const Text(
                        'Recent Expenses',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '💡 Double-tap an expense to view and manage it.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 16),

                      Expanded(
                        child: ListView(
                          children: expenses.map((doc) {
                            final data = doc.data() as Map<String, dynamic>;
                            final title = data['title'] ?? 'No title';
                            final amount = (data['amount'] ?? 0).toDouble();
                            final category = data['category'] ?? 'Other';
                            final date = (data['date'] as Timestamp).toDate();

                            return GestureDetector(
                              onDoubleTap: () => _showExpenseDetail(
                                context,
                                user.uid,
                                doc.id,
                                data,
                              ),
                              child: Card(
                                elevation: 2,
                                child: ListTile(
                                  leading: const Icon(Icons.receipt_long),
                                  title: Text(title),
                                  subtitle: Text(
                                    '$category • ${intl.DateFormat('MMM d, yyyy').format(date)}',
                                  ),
                                  trailing: Text(
                                    _formatCurrency(amount),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      // Footer Section
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16.0),
                        margin: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'SmartSpend - Your Personal Finance Manager',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Track your expenses • Manage your budget • Save smarter',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '© 2024 SmartSpend App. All rights reserved.',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddExpensePage()),
          );
        },
      ),
    );
  }

  // Centered dialog for expense details
  void _showExpenseDetail(
  BuildContext context,
  String userId,
  String expenseId,
  Map<String, dynamic> data,
) {
  final title = data['title'] ?? 'No title';
  final amount = (data['amount'] ?? 0).toDouble();
  final category = data['category'] ?? 'Other';
  final date = (data['date'] as Timestamp).toDate();

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SizedBox(
        width: 300, // adjust dialog width
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text('Category: $category', style: TextStyle(color: Colors.grey.shade700)),
            const SizedBox(height: 4),
            Text(
              'Date: ${intl.DateFormat('EEEE, MMM d, yyyy').format(date)}',
              style: TextStyle(color: Colors.grey.shade700),
            ),
            const SizedBox(height: 12),
            Text(
              _formatCurrency(amount),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        TextButton.icon(
          icon: const Icon(Icons.edit, color: Colors.blue),
          label: const Text('Edit', style: TextStyle(color: Colors.blue)),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddExpensePage(
                  expenseId: expenseId,
                  existingData: data,
                ),
              ),
            );
          },
        ),
        TextButton.icon(
          icon: const Icon(Icons.delete, color: Colors.red),
          label: const Text('Delete', style: TextStyle(color: Colors.red)),
          onPressed: () async {
            Navigator.pop(context);
            final confirm = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Delete Expense'),
                content: const Text(
                  'Are you sure you want to delete this expense?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Delete'),
                  ),
                ],
              ),
            );
            if (confirm == true) {
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(userId)
                  .collection('expenses')
                  .doc(expenseId)
                  .delete();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Expense deleted'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
        ),
      ],
    ),
  );
}


  Widget _buildPlaceholder() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            const Text('No expenses yet', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            const Text('Tap + to add your first expense'),
          ],
        ),
      );
}
