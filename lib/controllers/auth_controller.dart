import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, User, FirebaseAuthException;

class AuthController with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  AuthController() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      _error = null;
      notifyListeners();
    });
  }

  Future<bool> signIn(String email, String password) async {
    try {
      _setLoading(true);
      _error = null;

      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      _error = _getErrorMessage(e);
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUp(String email, String password, String displayName) async {
    try {
      _setLoading(true);
      _error = null;

      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Update display name if provided
      if (displayName.isNotEmpty) {
        await userCredential.user!.updateDisplayName(displayName);
      }

      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      _error = _getErrorMessage(e);
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      _error = null;
    } catch (e) {
      _error = 'Failed to sign out. Please try again.';
      notifyListeners();
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      _setLoading(true);
      _error = null;

      await _auth.sendPasswordResetEmail(email: email.trim());

      _setLoading(false);
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      _error = _getErrorMessage(e);
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email address.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'email-already-in-use':
        return 'An account already exists with this email address.';
      case 'weak-password':
        return 'The password is too weak. Please use a stronger password.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      default:
        return e.message ?? 'An unexpected error occurred. Please try again.';
    }
  }

  // Check if user is logged in
  bool get isLoggedIn => _user != null;

  // Get user display name
  String get displayName {
    if (_user?.displayName != null && _user!.displayName!.isNotEmpty) {
      return _user!.displayName!;
    }
    return _user?.email?.split('@').first ?? 'User';
  }

  // Get user email
  String? get userEmail => _user?.email;
}
