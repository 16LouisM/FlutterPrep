import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_prep/widgets/summary_card.dart';
import 'package:flutter_prep/services/auth_service.dart';
import 'package:flutter_prep/pages/add_expense_page.dart';

class DashboardPage extends StatefulWidget {
  static const routeName = '/dashboard';
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SmartSpend Dashboard'),
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logout feature coming soon!')),
              );
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Message
            Text(
              'Welcome back, ${user?.email?.split('@').first ?? 'User'}!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Here\'s your spending overview',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),

            // Summary Cards
            Row(
              children: [
                // Total Monthly Spending
                Expanded(
                  child: SummaryCard(
                    icon: Icons.attach_money,
                    title: 'This Month',
                    value: 'R0',
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 12),

                // Total Expenses
                Expanded(
                  child: SummaryCard(
                    icon: Icons.receipt,
                    title: 'Total Expenses',
                    value: '0',
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                // Top Category
                Expanded(
                  child: SummaryCard(
                    icon: Icons.category,
                    title: 'Top Category',
                    value: 'None',
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 12),

                // Average Expense
                Expanded(
                  child: SummaryCard(
                    icon: Icons.trending_up,
                    title: 'Average',
                    value: 'R0',
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Expenses Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Expenses',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Filter feature coming soon!'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.filter_list),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Expenses List
            Expanded(child: _buildExpensesList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to AddExpensePage
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddExpensePage()),
          );
        },
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildExpensesList() {
    // Temporary empty state - will be populated by Member B
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'No expenses yet',
            style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the + button to add your first expense',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
