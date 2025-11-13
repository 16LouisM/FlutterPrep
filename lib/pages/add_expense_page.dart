// // import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart' as intl;
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';

// // class AddExpensePage extends StatefulWidget {
// //   const AddExpensePage({super.key});

// //   @override
// //   State<AddExpensePage> createState() => _AddExpensePageState();
// // }

// // class _AddExpensePageState extends State<AddExpensePage> {
// //   final _formKey = GlobalKey<FormState>();
// //   final _titleController = TextEditingController();
// //   final _amountController = TextEditingController();

// //   String _selectedCategory = 'Food';
// //   DateTime _selectedDate = DateTime.now();

// //   final List<String> _categories = [
// //     'Food',
// //     'Transport',
// //     'Rent',
// //     'Entertainment',
// //     'Shopping',
// //     'Healthcare',
// //     'Education',
// //     'Other',
// //   ];

// //   Future<void> _selectDate(BuildContext context) async {
// //     final DateTime? picked = await showDatePicker(
// //       context: context,
// //       initialDate: _selectedDate,
// //       firstDate: DateTime(2020),
// //       lastDate: DateTime.now(),
// //     );
// //     if (picked != null && picked != _selectedDate) {
// //       setState(() {
// //         _selectedDate = picked;
// //       });
// //     }
// //   }

// // void _saveExpense() async {
// //   if (_formKey.currentState!.validate()) {
// //     try {
// //       final user = FirebaseAuth.instance.currentUser;

// //       if (user == null) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(
// //             content: Text('You must be logged in to save an expense.'),
// //             backgroundColor: Colors.red,
// //           ),
// //         );
// //         return;
// //       }

// //       // Reference to the user's document
// //       final userDocRef =
// //           FirebaseFirestore.instance.collection('users').doc(user.uid);

// //       // Ensure the user's document exists and has the email field
// //       await userDocRef.set({
// //         'email': user.email,
// //       }, SetOptions(merge: true)); // merge: true means it won’t overwrite existing data

// //       // Create the expense data
// //       final expenseData = {
// //         'title': _titleController.text.trim(),
// //         'amount': double.parse(_amountController.text.trim()),
// //         'category': _selectedCategory,
// //         'date': Timestamp.fromDate(_selectedDate),
// //         'createdAt': Timestamp.now(),
// //       };

// //       // Add to /users/{userId}/expenses/
// //       await userDocRef.collection('expenses').add(expenseData);

// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(
// //           content: Text('Expense saved successfully!'),
// //           backgroundColor: Colors.green,
// //         ),
// //       );

// //       Navigator.pop(context);
// //     } catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('Failed to save expense: $e'),
// //           backgroundColor: Colors.red,
// //         ),
// //       );
// //     }
// //   }
// // }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Add New Expense'),
// //         backgroundColor: Colors.blue.shade600,
// //         foregroundColor: Colors.white,
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back),
// //           onPressed: () => Navigator.pop(context),
// //         ),
// //       ),
// //       body: SingleChildScrollView(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Form(
// //           key: _formKey,
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               // Title Field
// //               TextFormField(
// //                 controller: _titleController,
// //                 decoration: const InputDecoration(
// //                   labelText: 'Title *',
// //                   hintText: 'e.g., Groceries, Uber, Movie Tickets',
// //                   border: OutlineInputBorder(),
// //                 ),
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please enter a title for your expense';
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               const SizedBox(height: 20),

// //               // Amount Field
// //               TextFormField(
// //                 controller: _amountController,
// //                 decoration: const InputDecoration(
// //                   labelText: 'Amount (ZAR) *',
// //                   hintText: 'e.g., 150.00',
// //                   prefixText: 'R ',
// //                   border: OutlineInputBorder(),
// //                 ),
// //                 keyboardType: TextInputType.number,
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please enter the amount spent';
// //                   }
// //                   final amount = double.tryParse(value);
// //                   if (amount == null || amount <= 0) {
// //                     return 'Please enter a valid amount greater than 0';
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               const SizedBox(height: 20),

// //               // Category Dropdown
// //               DropdownButtonFormField<String>(
// //                 initialValue: _selectedCategory,
// //                 decoration: const InputDecoration(
// //                   labelText: 'Category *',
// //                   border: OutlineInputBorder(),
// //                 ),
// //                 items:
// //                     _categories.map((String category) {
// //                       return DropdownMenuItem<String>(
// //                         value: category,
// //                         child: Row(
// //                           children: [
// //                             Icon(
// //                               _getCategoryIcon(category),
// //                               color: _getCategoryColor(category),
// //                             ),
// //                             const SizedBox(width: 12),
// //                             Text(category),
// //                           ],
// //                         ),
// //                       );
// //                     }).toList(),
// //                 onChanged: (String? newValue) {
// //                   setState(() {
// //                     _selectedCategory = newValue!;
// //                   });
// //                 },
// //               ),
// //               const SizedBox(height: 20),

// //               // Date Picker
// //               InkWell(
// //                 onTap: () => _selectDate(context),
// //                 child: InputDecorator(
// //                   decoration: const InputDecoration(
// //                     labelText: 'Date *',
// //                     border: OutlineInputBorder(),
// //                   ),
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Text(
// //                         intl.DateFormat(
// //                           'EEEE, MMMM d, yyyy',
// //                         ).format(_selectedDate),
// //                         style: const TextStyle(fontSize: 16),
// //                       ),
// //                       const Icon(Icons.calendar_today),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 30),

// //               // Save Button
// //               SizedBox(
// //                 width: double.infinity,
// //                 child: ElevatedButton(
// //                   onPressed: _saveExpense,
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: Colors.blue.shade600,
// //                     foregroundColor: Colors.white,
// //                     padding: const EdgeInsets.symmetric(vertical: 16),
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(8),
// //                     ),
// //                   ),
// //                   child: const Text(
// //                     'Save Expense',
// //                     style: TextStyle(fontSize: 16),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),

// //       // Footer
// //       bottomNavigationBar: Container(
// //         height: 60,
// //         decoration: BoxDecoration(
// //           color: Colors.blue.shade50,
// //           border: Border(
// //             top: BorderSide(width: 1, color: Colors.grey.shade300),
// //           ),
// //         ),
// //         child: Center(
// //           child: Text(
// //             'SmartSpend Team © 2025',
// //             style: TextStyle(color: Colors.grey.shade600),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   IconData _getCategoryIcon(String category) {
// //     switch (category) {
// //       case 'Food':
// //         return Icons.restaurant;
// //       case 'Transport':
// //         return Icons.directions_car;
// //       case 'Rent':
// //         return Icons.home;
// //       case 'Entertainment':
// //         return Icons.movie;
// //       case 'Shopping':
// //         return Icons.shopping_bag;
// //       case 'Healthcare':
// //         return Icons.medical_services;
// //       case 'Education':
// //         return Icons.school;
// //       default:
// //         return Icons.category;
// //     }
// //   }

// //   Color _getCategoryColor(String category) {
// //     switch (category) {
// //       case 'Food':
// //         return Colors.green;
// //       case 'Transport':
// //         return Colors.blue;
// //       case 'Rent':
// //         return Colors.orange;
// //       case 'Entertainment':
// //         return Colors.purple;
// //       case 'Shopping':
// //         return Colors.pink;
// //       case 'Healthcare':
// //         return Colors.red;
// //       case 'Education':
// //         return Colors.teal;
// //       default:
// //         return Colors.grey;
// //     }
// //   }

// //   @override
// //   void dispose() {
// //     _titleController.dispose();
// //     _amountController.dispose();
// //     super.dispose();
// //   }
// // }


// import 'package:flutter/material.dart';
// import 'package:flutter_prep/pages/login_page.dart';
// import 'package:provider/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_prep/widgets/summary_card.dart';
// import 'package:flutter_prep/services/auth_service.dart';
// import 'package:flutter_prep/pages/add_expense_page.dart';
// import 'package:intl/intl.dart' as intl;

// class DashboardPage extends StatefulWidget {
//   static const routeName = '/dashboard';
//   const DashboardPage({super.key});

//   @override
//   State<DashboardPage> createState() => _DashboardPageState();
// }

// class _DashboardPageState extends State<DashboardPage> {
//   String? _selectedCategory;

//   Future<void> _logout(BuildContext context) async {
//     final authService = Provider.of<AuthService>(context, listen: false);
//     try {
//       await authService.signOut();
//       if (!mounted) return;
//       await showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Logged Out'),
//           content: const Text('You have been logged out successfully.'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (context) => const LoginPage()),
//                   (route) => false,
//                 );
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         ),
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

//   String _formatCurrency(double amount) {
//     final formatter = intl.NumberFormat('#,##0.00', 'en_US');
//     return 'R${formatter.format(amount)}';
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
//         automaticallyImplyLeading: false, // remove back icon
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             tooltip: 'Logout',
//             onPressed: () => _logout(context),
//           ),
//         ],
//       ),
//       body: user == null
//           ? const Center(child: Text('Please log in'))
//           : StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('users')
//                   .doc(user.uid)
//                   .collection('expenses')
//                   .orderBy('date', descending: true)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return _buildPlaceholder();
//                 }

//                 final expenses = snapshot.data!.docs;
//                 final now = DateTime.now();
//                 double totalThisMonth = 0;
//                 final Map<String, double> categoryTotals = {};

//                 for (var doc in expenses) {
//                   final data = doc.data() as Map<String, dynamic>;
//                   final amount = (data['amount'] ?? 0).toDouble();
//                   final date = (data['date'] as Timestamp).toDate();
//                   final category = data['category'] ?? 'Other';

//                   if (date.month == now.month && date.year == now.year) {
//                     totalThisMonth += amount;
//                   }
//                   categoryTotals[category] =
//                       (categoryTotals[category] ?? 0) + amount;
//                 }

//                 String topCategory = 'None';
//                 double topCategoryAmount = 0;
//                 categoryTotals.forEach((category, total) {
//                   if (total > topCategoryAmount) {
//                     topCategoryAmount = total;
//                     topCategory = category;
//                   }
//                 });

//                 int totalCategories = categoryTotals.keys.length;
//                 double average =
//                     totalCategories > 0 ? totalThisMonth / totalCategories : 0;

//                 return Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Welcome back, ${user.email?.split('@').first ?? 'User'}!',
//                         style: const TextStyle(
//                             fontSize: 24, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         'Here\'s your spending overview',
//                         style: TextStyle(
//                             fontSize: 16, color: Colors.grey.shade600),
//                       ),
//                       const SizedBox(height: 24),

//                       // Summary cards
//                       Row(
//                         children: [
//                           Expanded(
//                             child: SummaryCard(
//                               icon: Icons.attach_money,
//                               title: 'This Month',
//                               value: _formatCurrency(totalThisMonth),
//                               color: Colors.green,
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: SummaryCard(
//                               icon: Icons.receipt,
//                               title: 'Total Expenses',
//                               value: '$totalCategories',
//                               color: Colors.blue,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 12),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: SummaryCard(
//                               icon: Icons.category,
//                               title: 'Top Category',
//                               value: topCategory,
//                               color: Colors.orange,
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: SummaryCard(
//                               icon: Icons.trending_up,
//                               title: 'Average',
//                               value: _formatCurrency(average),
//                               color: Colors.purple,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 24),

//                       const Text(
//                         'Recent Expenses',
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         '💡 Double-tap an expense to view and manage it.',
//                         style: TextStyle(
//                             fontSize: 14, color: Colors.grey.shade600),
//                       ),
//                       const SizedBox(height: 16),

//                       Expanded(
//                         child: ListView(
//                           children: expenses.map((doc) {
//                             final data = doc.data() as Map<String, dynamic>;
//                             final title = data['title'] ?? 'No title';
//                             final amount = (data['amount'] ?? 0).toDouble();
//                             final category = data['category'] ?? 'Other';
//                             final date = (data['date'] as Timestamp).toDate();

//                             return GestureDetector(
//                               onDoubleTap: () => _showExpenseDetail(
//                                 context,
//                                 user.uid,
//                                 doc.id,
//                                 data,
//                               ),
//                               child: Card(
//                                 elevation: 2,
//                                 child: ListTile(
//                                   leading: const Icon(Icons.receipt_long),
//                                   title: Text(title),
//                                   subtitle: Text(
//                                     '$category • ${intl.DateFormat('MMM d, yyyy').format(date)}',
//                                   ),
//                                   trailing: Text(
//                                     _formatCurrency(amount),
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.blue.shade600,
//         foregroundColor: Colors.white,
//         child: const Icon(Icons.add),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const AddExpensePage()),
//           );
//         },
//       ),
//     );
//   }

//   void _showExpenseDetail(
//     BuildContext context,
//     String userId,
//     String expenseId,
//     Map<String, dynamic> data,
//   ) {
//     final title = data['title'] ?? 'No title';
//     final amount = (data['amount'] ?? 0).toDouble();
//     final category = data['category'] ?? 'Other';
//     final date = (data['date'] as Timestamp).toDate();

//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (context) => Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               title,
//               style: const TextStyle(
//                   fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               'Category: $category',
//               style: TextStyle(color: Colors.grey.shade700),
//             ),
//             Text(
//               'Date: ${intl.DateFormat('EEEE, MMM d, yyyy').format(date)}',
//               style: TextStyle(color: Colors.grey.shade700),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               _formatCurrency(amount),
//               style: const TextStyle(
//                 fontSize: 20,
//                 color: Colors.green,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const Divider(height: 30),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton.icon(
//                   icon: const Icon(Icons.edit),
//                   label: const Text('Edit'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue.shade600,
//                     foregroundColor: Colors.white,
//                   ),
//                   onPressed: () {
//                     Navigator.pop(context);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => AddExpensePage(
//                           expenseId: expenseId,
//                           existingData: data,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 ElevatedButton.icon(
//                   icon: const Icon(Icons.delete),
//                   label: const Text('Delete'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red,
//                     foregroundColor: Colors.white,
//                   ),
//                   onPressed: () async {
//                     Navigator.pop(context);
//                     final confirm = await showDialog<bool>(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: const Text('Delete Expense'),
//                         content: const Text(
//                             'Are you sure you want to delete this expense?'),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.pop(context, false),
//                             child: const Text('Cancel'),
//                           ),
//                           TextButton(
//                             onPressed: () => Navigator.pop(context, true),
//                             child: const Text('Delete'),
//                           ),
//                         ],
//                       ),
//                     );
//                     if (confirm == true) {
//                       await FirebaseFirestore.instance
//                           .collection('users')
//                           .doc(userId)
//                           .collection('expenses')
//                           .doc(expenseId)
//                           .delete();
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('Expense deleted'),
//                           backgroundColor: Colors.green,
//                         ),
//                       );
//                     }
//                   },
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPlaceholder() => Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.receipt_long, size: 64, color: Colors.grey.shade400),
//             const SizedBox(height: 16),
//             const Text(
//               'No expenses yet',
//               style: TextStyle(fontSize: 18),
//             ),
//             const SizedBox(height: 8),
//             const Text('Tap + to add your first expense'),
//           ],
//         ),
//       );
// }



import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddExpensePage extends StatefulWidget {
  final String? expenseId;
  final Map<String, dynamic>? existingData;

  const AddExpensePage({
    super.key,
    this.expenseId,
    this.existingData,
  });

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  String _selectedCategory = 'Food';
  DateTime _selectedDate = DateTime.now();

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

  @override
  void initState() {
    super.initState();
    // ✅ If editing, prefill all data
    if (widget.existingData != null) {
      final data = widget.existingData!;
      _titleController.text = data['title'] ?? '';
      _amountController.text = data['amount'].toString();
      _selectedCategory = data['category'] ?? 'Food';
      if (data['date'] is Timestamp) {
        _selectedDate = (data['date'] as Timestamp).toDate();
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _saveExpense() async {
    if (!_formKey.currentState!.validate()) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final expenseData = {
      'title': _titleController.text.trim(),
      'amount': double.parse(_amountController.text.trim()),
      'category': _selectedCategory,
      'date': Timestamp.fromDate(_selectedDate),
      'createdAt': Timestamp.now(),
    };

    try {
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(user.uid);

      if (widget.expenseId != null) {
        // ✅ Update existing expense
        await userDoc
            .collection('expenses')
            .doc(widget.expenseId)
            .update(expenseData);
      } else {
        // ✅ Add new expense
        await userDoc.collection('expenses').add(expenseData);
        await userDoc.set({'email': user.email}, SetOptions(merge: true));
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.expenseId != null
              ? 'Expense updated successfully!'
              : 'Expense saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.expenseId != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Expense' : 'Add New Expense'),
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Field
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title *',
                  hintText: 'e.g., Groceries, Uber, Movie Tickets',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    (value == null || value.isEmpty)
                        ? 'Please enter a title'
                        : null,
              ),
              const SizedBox(height: 20),

              // Amount Field
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Amount (ZAR) *',
                  hintText: 'e.g., 150.00',
                  prefixText: 'R ',
                  border: OutlineInputBorder(),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the amount spent';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null || amount <= 0) {
                    return 'Please enter a valid amount greater than 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Category Dropdown
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category *',
                  border: OutlineInputBorder(),
                ),
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Row(
                      children: [
                        Icon(
                          _getCategoryIcon(category),
                          color: _getCategoryColor(category),
                        ),
                        const SizedBox(width: 12),
                        Text(category),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) => setState(() {
                  _selectedCategory = value!;
                }),
              ),
              const SizedBox(height: 20),

              // Date Picker
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Date *',
                    border: OutlineInputBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        intl.DateFormat('EEEE, MMMM d, yyyy')
                            .format(_selectedDate),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveExpense,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    isEditing ? 'Update Expense' : 'Save Expense',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
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
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Food':
        return Icons.restaurant;
      case 'Transport':
        return Icons.directions_car;
      case 'Rent':
        return Icons.home;
      case 'Entertainment':
        return Icons.movie;
      case 'Shopping':
        return Icons.shopping_bag;
      case 'Healthcare':
        return Icons.medical_services;
      case 'Education':
        return Icons.school;
      default:
        return Icons.category;
    }
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

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
