// --------------------------------------------------------------
//  FILE: lib/services/database_service.dart
// --------------------------------------------------------------
//  PURPOSE:
// This service manages all interactions with Cloud Firestore
// related to user expenses. It allows adding, reading, updating,
// and deleting expense records for authenticated users.
//
// --------------------------------------------------------------
//  FRONTEND TEAM INSTRUCTIONS:
// --------------------------------------------------------------
//  1. IMPORT THIS SERVICE
//     import 'package:your_app/services/database_service.dart';
//
//  2. ADD EXPENSE PAGE
//     - Call DatabaseService(uid: currentUserId).addExpense(...)
//       to upload a new expense record to Firestore.
//
//  3. DASHBOARD PAGE (Member A)
//     - Use DatabaseService(uid: currentUserId).expensesStream()
//       to listen to real-time updates of all expenses for that user.
//     - Display the data in a ListView or StreamBuilder.
//
//  4. OPTIONAL (EDIT / DELETE)
//     - Call updateExpense(...) to modify existing data.
//     - Call deleteExpense(...) to remove a record.
//
// --------------------------------------------------------------
//  BACKEND CONNECTION:
// --------------------------------------------------------------
// This service connects directly to Firebase Firestore.
// Each user's expenses are stored in a "users" collection under
// their UID → each having a subcollection "expenses".
//
// Example Firestore structure:
// users
//   └── {uid}
//        └── expenses
//             ├── {expenseId}
//             │    ├── title: "Groceries"
//             │    ├── amount: 40.0
//             │    ├── date: Timestamp
//             │    └── category: "Food"
//
// --------------------------------------------------------------
//  DEPENDENCIES:
//   cloud_firestore: ^5.0.0 (or latest compatible version)
// --------------------------------------------------------------

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid; // The current user's UID

  // Firestore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DatabaseService({required this.uid});

  // ADD NEW EXPENSE
  Future<void> addExpense({
    required String title,
    required double amount,
    required String category,
    required DateTime date,
  }) async {
    try {
      await _db.collection('users')
          .doc(uid)
          .collection('expenses')
          .add({
            'title': title,
            'amount': amount,
            'category': category,
            'date': Timestamp.fromDate(date),
            'createdAt': FieldValue.serverTimestamp(),
          });
    } catch (e) {
      throw Exception('Failed to add expense: $e');
    }
  }

  // STREAM: FETCH ALL USER EXPENSES
  Stream<List<Map<String, dynamic>>> expensesStream() {
    return _db
        .collection('users')
        .doc(uid)
        .collection('expenses')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return {
                'id': doc.id,
                ...doc.data(),
              };
            }).toList());
  }

  // PDATE EXISTING EXPENSE
  Future<void> updateExpense({
    required String expenseId,
    required Map<String, dynamic> updatedData,
  }) async {
    try {
      await _db
          .collection('users')
          .doc(uid)
          .collection('expenses')
          .doc(expenseId)
          .update(updatedData);
    } catch (e) {
      throw Exception('Failed to update expense: $e');
    }
  }

  //  DELETE EXPENSE
  Future<void> deleteExpense(String expenseId) async {
    try {
      await _db
          .collection('users')
          .doc(uid)
          .collection('expenses')
          .doc(expenseId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete expense: $e');
    }
  }
}
