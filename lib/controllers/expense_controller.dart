import 'package:flutter/material.dart';
import 'package:flutter_prep/models/expense_model.dart';

class ExpenseController with ChangeNotifier {
  List<Expense> _expenses = [];
  bool _isLoading = false;
  String? _error;
  String _filterCategory = 'All';
  DateTime? _filterStartDate;
  DateTime? _filterEndDate;

  List<Expense> get expenses => _getFilteredExpenses();
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get filterCategory => _filterCategory;
  DateTime? get filterStartDate => _filterStartDate;
  DateTime? get filterEndDate => _filterEndDate;

  // Statistics
  double get totalAmount {
    return expenses.fold(0, (sum, expense) => sum + expense.amount);
  }

  double get monthlyTotal {
    final now = DateTime.now();
    final monthlyExpenses = expenses.where(
      (expense) =>
          expense.date.year == now.year && expense.date.month == now.month,
    );
    return monthlyExpenses.fold(0, (sum, expense) => sum + expense.amount);
  }

  int get totalCount => expenses.length;

  double get averageExpense {
    return totalCount > 0 ? totalAmount / totalCount : 0;
  }

  String get topCategory {
    if (expenses.isEmpty) return 'None';

    final categoryTotals = <String, double>{};
    for (final expense in expenses) {
      categoryTotals.update(
        expense.category,
        (value) => value + expense.amount,
        ifAbsent: () => expense.amount,
      );
    }

    return categoryTotals.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  Map<String, double> get categoryBreakdown {
    final breakdown = <String, double>{};
    for (final expense in expenses) {
      breakdown.update(
        expense.category,
        (value) => value + expense.amount,
        ifAbsent: () => expense.amount,
      );
    }
    return breakdown;
  }

  // Filter methods
  void setCategoryFilter(String category) {
    _filterCategory = category;
    notifyListeners();
  }

  void setDateRange(DateTime? start, DateTime? end) {
    _filterStartDate = start;
    _filterEndDate = end;
    notifyListeners();
  }

  void clearFilters() {
    _filterCategory = 'All';
    _filterStartDate = null;
    _filterEndDate = null;
    notifyListeners();
  }

  // CRUD Operations (to be implemented with actual database service)
  Future<void> loadExpenses() async {
    _setLoading(true);
    _error = null;

    try {
      // This will be implemented by Member B with actual Firestore calls
      // For now, we'll simulate loading
      await Future.delayed(const Duration(milliseconds: 500));

      // Temporary mock data for testing UI
      _expenses = [
        Expense(
          id: '1',
          title: 'Groceries',
          amount: 350.75,
          category: 'Food',
          date: DateTime.now().subtract(const Duration(days: 1)),
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
        Expense(
          id: '2',
          title: 'Uber to work',
          amount: 45.50,
          category: 'Transport',
          date: DateTime.now().subtract(const Duration(days: 2)),
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
        Expense(
          id: '3',
          title: 'Movie tickets',
          amount: 120.00,
          category: 'Entertainment',
          date: DateTime.now().subtract(const Duration(days: 3)),
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
        ),
      ];

      notifyListeners();
    } catch (e) {
      _error = 'Failed to load expenses: $e';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addExpense(Expense expense) async {
    _setLoading(true);
    _error = null;

    try {
      // This will be implemented by Member B with actual Firestore calls
      await Future.delayed(const Duration(milliseconds: 300));

      _expenses.add(expense);
      notifyListeners();
    } catch (e) {
      _error = 'Failed to add expense: $e';
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateExpense(String expenseId, Expense updatedExpense) async {
    _setLoading(true);
    _error = null;

    try {
      final index = _expenses.indexWhere((expense) => expense.id == expenseId);
      if (index != -1) {
        _expenses[index] = updatedExpense;
        notifyListeners();
      }
    } catch (e) {
      _error = 'Failed to update expense: $e';
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteExpense(String expenseId) async {
    _setLoading(true);
    _error = null;

    try {
      _expenses.removeWhere((expense) => expense.id == expenseId);
      notifyListeners();
    } catch (e) {
      _error = 'Failed to delete expense: $e';
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // Helper methods
  List<Expense> _getFilteredExpenses() {
    List<Expense> filtered = List.from(_expenses);

    // Apply category filter
    if (_filterCategory != 'All') {
      filtered =
          filtered
              .where((expense) => expense.category == _filterCategory)
              .toList();
    }

    // Apply date range filter
    if (_filterStartDate != null) {
      filtered =
          filtered
              .where(
                (expense) => expense.date.isAfter(
                  _filterStartDate!.subtract(const Duration(days: 1)),
                ),
              )
              .toList();
    }

    if (_filterEndDate != null) {
      filtered =
          filtered
              .where(
                (expense) => expense.date.isBefore(
                  _filterEndDate!.add(const Duration(days: 1)),
                ),
              )
              .toList();
    }

    // Sort by date (newest first)
    filtered.sort((a, b) => b.date.compareTo(a.date));

    return filtered;
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Get expenses by category for charts
  List<Map<String, dynamic>> get expensesByCategory {
    final breakdown = categoryBreakdown;
    return breakdown.entries.map((entry) {
      return {
        'category': entry.key,
        'amount': entry.value,
        'percentage': (entry.value / totalAmount * 100).toStringAsFixed(1),
      };
    }).toList();
  }

  // Get monthly trends
  Map<String, double> get monthlyTrends {
    final trends = <String, double>{};
    final now = DateTime.now();

    for (int i = 0; i < 6; i++) {
      final month = DateTime(now.year, now.month - i);
      final monthKey =
          '${month.year}-${month.month.toString().padLeft(2, '0')}';

      final monthlyTotal = _expenses
          .where(
            (expense) =>
                expense.date.year == month.year &&
                expense.date.month == month.month,
          )
          .fold(0.0, (sum, expense) => sum + expense.amount);

      trends[monthKey] = monthlyTotal;
    }

    return trends;
  }
}
