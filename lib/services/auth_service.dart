// --------------------------------------------------------------
//  FILE: lib/services/auth_service.dart
// --------------------------------------------------------------
//  PURPOSE:
// This service manages user authentication logic using Firebase Auth.
// It handles login, logout, registration (sign-up), and session management.
// It also provides a real-time authentication state stream to help the app
// redirect users between login and dashboard screens.
//
// --------------------------------------------------------------
//  FRONTEND TEAM INSTRUCTIONS:
// --------------------------------------------------------------
//  1. IMPORT THIS SERVICE
//     import 'package:flutter_prep/services/auth_service.dart';
//
//  2. LOGIN PAGE (Member A)
//     - Call AuthService().signInWithEmail(email, password).
//     - Show an error message if it throws an Exception.
//
//  3. SIGN-UP PAGE 
//     - Call AuthService().signUpWithEmail(email, password).
//     - On success, you can redirect the user to the dashboard or login page.
//
//  4. LOGOUT (Anywhere in the app)
//     - Call AuthService().signOut() to log the user out.
//
//  5. SESSION MANAGEMENT
//     - Use AuthService().authStateChanges stream in main.dart or a
//       wrapper widget to listen to authentication state changes.
//     - Redirect user to LoginPage() if null, else to DashboardPage().
//
// --------------------------------------------------------------
//  BACKEND CONNECTION:
// --------------------------------------------------------------
// This service interacts directly with Firebase Authentication.
// - Registration and login are handled by Firebase, not by a REST API.
// - The current user's Firebase ID can be used to link with backend data
//   if necessary (e.g., to fetch user-specific data).
//
// --------------------------------------------------------------
//  DEPENDENCIES:
//   firebase_auth: ^6.1.2 (or latest compatible version)
// --------------------------------------------------------------

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Firebase Auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //  Stream to listen for authentication state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  //  Get current user
  User? get currentUser => _auth.currentUser;

  //  SIGN IN (Login existing users)
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleFirebaseError(e));
    }
  }

  //  SIGN UP (Register new users)
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleFirebaseError(e));
    }
  }

  //  SIGN OUT
  Future<void> signOut() async {
    await _auth.signOut();
  }

  //  HANDLE FIREBASE ERRORS FOR BETTER UX
  String _handleFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'email-already-in-use':
        return 'An account already exists for that email.';
      case 'weak-password':
        return 'The password is too weak. Please use a stronger one.';
      default:
        return 'Authentication error: ${e.message}';
    }
  }
}
