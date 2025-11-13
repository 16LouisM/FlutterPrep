// import 'package:flutter/material.dart';
// import 'package:flutter_prep/pages/login_page.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_prep/widgets/summary_card.dart';
// import 'package:flutter_prep/services/auth_service.dart';
// import 'package:flutter_prep/pages/add_expense_page.dart';

// class DashboardPage extends StatefulWidget {
//   static const routeName = '/dashboard';
//   const DashboardPage({super.key});

//   @override
//   State<DashboardPage> createState() => _DashboardPageState();
// }

// class _DashboardPageState extends State<DashboardPage> {
//   // ✅ Always initialize categories to prevent null reference errors
//   final List<String> _categories = [
//     'Food',
//     'Transport',
//     'Rent',
//     'Entertainment',
//     'Shopping',
//     'Healthcare',
//     'Education',
//     'Other',
//   ];

//   String? _selectedCategory; // currently selected filter category

//   Future<void> _logout(BuildContext context) async {
//     final authService = Provider.of<AuthService>(context, listen: false);

//     try {
//       await authService.signOut();

//       if (!mounted) return;

//       // ✅ Show logout confirmation dialog
//       await showDialog(
//         context: context,
//         builder:
//             (context) => AlertDialog(
//               title: const Text('Logged Out'),
//               content: const Text('You have been logged out successfully.'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop(); // close dialog
//                     // ✅ Redirect to login page
//                     Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const LoginPage(),
//                       ),
//                       (route) => false,
//                     );
//                   },
//                   child: const Text('OK'),
//                 ),
//               ],
//             ),
//       );
//     } catch (e) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Logout failed: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   // ✅ Open category filter dialog
//   void _openCategoryFilter() {
//     showDialog(
//       context: context,
//       builder:
//           (context) => AlertDialog(
//             title: const Text('Filter by Category'),
//             content: SizedBox(
//               width: double.maxFinite,
//               child:
//                   _categories.isEmpty
//                       ? const Center(child: Text('No categories available'))
//                       : ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: _categories.length,
//                         itemBuilder: (context, index) {
//                           final category = _categories[index];
//                           return RadioListTile<String>(
//                             title: Text(category),
//                             value: category,
//                             groupValue: _selectedCategory,
//                             activeColor: Colors.blue.shade600,
//                             onChanged: (value) {
//                               setState(() {
//                                 _selectedCategory = value;
//                               });
//                               Navigator.of(context).pop();
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text('Filtered by $value'),
//                                   duration: const Duration(seconds: 2),
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                       ),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   setState(() {
//                     _selectedCategory = null;
//                   });
//                   Navigator.of(context).pop();
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text('Filter cleared'),
//                       duration: Duration(seconds: 2),
//                     ),
//                   );
//                 },
//                 child: const Text('Clear Filter'),
//               ),
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: const Text('Close'),
//               ),
//             ],
//           ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authService = Provider.of<AuthService>(context);
//     final user = authService.currentUser;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('SmartSpend Dashboard'),
//         backgroundColor: Colors.blue.shade600,
//         foregroundColor: Colors.white,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             tooltip: 'Logout',
//             onPressed: () => _logout(context),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Welcome Message
//             Text(
//               'Welcome back, ${user?.email?.split('@').first ?? 'User'}!',
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Here\'s your spending overview',
//               style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
//             ),
//             const SizedBox(height: 24),

//             // Summary Cards
//             Row(
//               children: [
//                 Expanded(
//                   child: SummaryCard(
//                     icon: Icons.attach_money,
//                     title: 'This Month',
//                     value: 'R0',
//                     color: Colors.green,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: SummaryCard(
//                     icon: Icons.receipt,
//                     title: 'Total Expenses',
//                     value: '0',
//                     color: Colors.blue,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             Row(
//               children: [
//                 Expanded(
//                   child: SummaryCard(
//                     icon: Icons.category,
//                     title: 'Top Category',
//                     value: 'None',
//                     color: Colors.orange,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: SummaryCard(
//                     icon: Icons.trending_up,
//                     title: 'Average',
//                     value: 'R0',
//                     color: Colors.purple,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 24),

//             // Expenses Header + Filter
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     const Text(
//                       'Recent Expenses',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     if (_selectedCategory != null)
//                       Padding(
//                         padding: const EdgeInsets.only(left: 8.0),
//                         child: Chip(
//                           label: Text(_selectedCategory!),
//                           deleteIcon: const Icon(Icons.close, size: 16),
//                           onDeleted: () {
//                             setState(() {
//                               _selectedCategory = null;
//                             });
//                           },
//                         ),
//                       ),
//                   ],
//                 ),
//                 IconButton(
//                   onPressed: _openCategoryFilter,
//                   icon: const Icon(Icons.filter_list),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),

//             // Expenses List
//             Expanded(child: _buildExpensesList()),
//           ],
//         ),
//       ),

//       // Footer
//       bottomNavigationBar: Container(
//         height: 60,
//         decoration: BoxDecoration(
//           color: Colors.blue.shade50,
//           border: Border(
//             top: BorderSide(width: 1, color: Colors.grey.shade300),
//           ),
//         ),
//         child: Center(
//           child: Text(
//             'SmartSpend Team © 2025',
//             style: TextStyle(color: Colors.grey.shade600),
//           ),
//         ),
//       ),

//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Navigate to AddExpensePage
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const AddExpensePage()),
//           );
//         },
//         backgroundColor: Colors.blue.shade600,
//         foregroundColor: Colors.white,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   Widget _buildExpensesList() {
//     // Placeholder until actual expenses are implemented
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.receipt_long, size: 64, color: Colors.grey.shade400),
//           const SizedBox(height: 16),
//           Text(
//             _selectedCategory == null
//                 ? 'No expenses yet'
//                 : 'No expenses in "${_selectedCategory!}"',
//             style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Tap the + button to add your first expense',
//             style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_prep/pages/login_page.dart';
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
  final List<String> _categories = [
    'Food',
    'Transport',
    'Rent',
    'Entertainment',
    'Shopping',
    'Healthcare',
    'Education',
    'Other',
  ];

  String? _selectedCategory;

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
                  MaterialPageRoute(builder: (context) => const LoginPage()),
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

  void _openCategoryFilter() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter by Category'),
        content: SizedBox(
          width: double.maxFinite,
          child: _categories.isEmpty
              ? const Center(child: Text('No categories available'))
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    return RadioListTile<String>(
                      title: Text(category),
                      value: category,
                      groupValue: _selectedCategory,
                      activeColor: Colors.blue.shade600,
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Filtered by $value'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _selectedCategory = null;
              });
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Filter cleared'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Clear Filter'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
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
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return _buildPlaceholder();
                }

                final expenses = snapshot.data!.docs;

                // Compute Statistics 
                final now = DateTime.now();
                double totalThisMonth = 0;
                final Map<String, double> categoryTotals = {};

                for (var doc in expenses) {
                  final data = doc.data() as Map<String, dynamic>;
                  final amount = (data['amount'] ?? 0).toDouble();
                  final date = (data['date'] as Timestamp).toDate();
                  final category = data['category'] ?? 'Other';

                  // Current month expenses
                  if (date.month == now.month && date.year == now.year) {
                    totalThisMonth += amount;
                  }

                  // Category totals
                  categoryTotals[category] =
                      (categoryTotals[category] ?? 0) + amount;
                }

                // Top category
                String topCategory = 'None';
                double topCategoryAmount = 0;
                categoryTotals.forEach((category, total) {
                  if (total > topCategoryAmount) {
                    topCategoryAmount = total;
                    topCategory = category;
                  }
                });

                // Distinct categories user has spent on
                int totalCategories = categoryTotals.keys.length;

                // Average spend (avoids division by zero)
                double average = totalCategories > 0
                    ? totalThisMonth / totalCategories
                    : 0;

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back, ${user.email?.split('@').first ?? 'User'}!',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Here\'s your spending overview',
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade600),
                      ),
                      const SizedBox(height: 24),

                      // Summary Cards
                      Row(
                        children: [
                          Expanded(
                            child: SummaryCard(
                              icon: Icons.attach_money,
                              title: 'This Month',
                              value: 'R${totalThisMonth.toStringAsFixed(2)}',
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
                              value: 'R${average.toStringAsFixed(2)}',
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
                          Row(
                            children: [
                              const Text(
                                'Recent Expenses',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (_selectedCategory != null)
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Chip(
                                    label: Text(_selectedCategory!),
                                    deleteIcon:
                                        const Icon(Icons.close, size: 16),
                                    onDeleted: () {
                                      setState(() {
                                        _selectedCategory = null;
                                      });
                                    },
                                  ),
                                ),
                            ],
                          ),
                          IconButton(
                            onPressed: _openCategoryFilter,
                            icon: const Icon(Icons.filter_list),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Expenses List
                      Expanded(
                        child: ListView(
                          children: expenses
                              .where((doc) {
                                if (_selectedCategory == null) return true;
                                final data =
                                    doc.data() as Map<String, dynamic>;
                                return data['category'] ==
                                    _selectedCategory;
                              })
                              .map((doc) {
                                final data =
                                    doc.data() as Map<String, dynamic>;
                                final title = data['title'] ?? 'No title';
                                final amount =
                                    (data['amount'] ?? 0).toDouble();
                                final category = data['category'] ?? 'Other';
                                final date = (data['date'] as Timestamp)
                                    .toDate();

                                return Card(
                                  child: ListTile(
                                    leading: const Icon(Icons.receipt_long),
                                    title: Text(title),
                                    subtitle: Text(
                                      '$category • ${intl.DateFormat('MMM d, yyyy').format(date)}',
                                    ),
                                    trailing: Text(
                                      'R${amount.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );
                              })
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          border: Border(
            top: BorderSide(width: 1, color: Colors.grey.shade300),
          ),
        ),
        child: Center(
          child: Text(
            'SmartSpend Team © 2025',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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

  Widget _buildPlaceholder() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Summary placeholders
          Row(
            children: [
              Expanded(
                child: SummaryCard(
                  icon: Icons.attach_money,
                  title: 'This Month',
                  value: 'R0',
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 12),
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
              Expanded(
                child: SummaryCard(
                  icon: Icons.category,
                  title: 'Top Category',
                  value: 'None',
                  color: Colors.orange,
                ),
              ),
              const SizedBox(width: 12),
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
          const Spacer(),
          const Icon(Icons.receipt_long, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text('No expenses yet. Tap + to add one!'),
          const Spacer(),
        ],
      ),
    );
  }
}
