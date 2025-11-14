// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import '../services/auth_service.dart';
// // import 'sign_up_page.dart';
// // import 'dashboard_page.dart';

// // class LoginPage extends StatefulWidget {
// //   const LoginPage({super.key});

// //   @override
// //   State<LoginPage> createState() => _LoginPageState();
// // }

// // class _LoginPageState extends State<LoginPage> {
// //   final _emailController = TextEditingController();
// //   final _passwordController = TextEditingController();
// //   bool _isLoading = false;
// //   bool _isGoogleLoading = false;
// //   bool _obscurePassword = true;

// //   // ---------------------------------------------------------------------------
// //   // 🔐 EMAIL + PASSWORD SIGN IN
// //   // ---------------------------------------------------------------------------
// //   Future<void> _signIn() async {
// //     if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(
// //           content: Text('Please enter email and password'),
// //           backgroundColor: Colors.red,
// //         ),
// //       );
// //       return;
// //     }

// //     setState(() => _isLoading = true);

// //     try {
// //       final authService = Provider.of<AuthService>(context, listen: false);
// //       await authService.signInWithEmail(
// //         _emailController.text.trim(),
// //         _passwordController.text.trim(),
// //       );

// //       if (!mounted) return;
// //       Navigator.pushReplacement(
// //         context,
// //         MaterialPageRoute(builder: (context) => DashboardPage()),
// //       );
// //     } catch (e) {
// //       if (!mounted) return;
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text(e.toString().replaceFirst('Exception: ', '')),
// //           backgroundColor: Colors.red,
// //         ),
// //       );
// //     } finally {
// //       if (mounted) setState(() => _isLoading = false);
// //     }
// //   }

// //   // ---------------------------------------------------------------------------
// //   // 🔄 PASSWORD RESET
// //   // ---------------------------------------------------------------------------
// //   Future<void> _resetPassword() async {
// //     final email = _emailController.text.trim();

// //     if (email.isEmpty || !email.contains("@")) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(
// //           content: Text("Enter your email to reset password."),
// //           backgroundColor: Colors.red,
// //         ),
// //       );
// //       return;
// //     }

// //     try {
// //       await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

// //       if (!mounted) return;

// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(
// //           content: Text("Password reset email sent!"),
// //           backgroundColor: Colors.green,
// //         ),
// //       );
// //     } catch (e) {
// //       if (!mounted) return;

// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
// //       );
// //     }
// //   }

// //   // ---------------------------------------------------------------------------
// //   // 🔐 GOOGLE SIGN IN (WORKS FOR FLUTTER WEB)
// //   // ---------------------------------------------------------------------------
// //   Future<void> _signInWithGoogle() async {
// //     setState(() => _isGoogleLoading = true);

// //     try {
// //       GoogleAuthProvider googleProvider = GoogleAuthProvider();

// //       // Web popup login
// //       UserCredential userCredential = await FirebaseAuth.instance
// //           .signInWithPopup(googleProvider);

// //       if (userCredential.user != null && mounted) {
// //         Navigator.pushReplacement(
// //           context,
// //           MaterialPageRoute(builder: (_) => DashboardPage()),
// //         );
// //       }
// //     } catch (e) {
// //       if (mounted) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(
// //             content: Text("Google sign-in failed: $e"),
// //             backgroundColor: Colors.red,
// //           ),
// //         );
// //       }
// //     } finally {
// //       if (mounted) setState(() => _isGoogleLoading = false);
// //     }
// //   }

// //   // ---------------------------------------------------------------------------
// //   // UI
// //   // ---------------------------------------------------------------------------
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Login'),
// //         backgroundColor: Colors.blue.shade600,
// //         foregroundColor: Colors.white,
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back),
// //           onPressed: () => Navigator.pop(context),
// //         ),
// //       ),
// //       body: Container(
// //         decoration: BoxDecoration(
// //           gradient: LinearGradient(
// //             colors: [Colors.blue.shade50, Colors.green.shade50],
// //             begin: Alignment.topLeft,
// //             end: Alignment.bottomRight,
// //           ),
// //         ),
// //         child: Center(
// //           child: SingleChildScrollView(
// //             padding: const EdgeInsets.all(24.0),
// //             child: Column(
// //               children: [
// //                 Card(
// //                   elevation: 8,
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(16),
// //                   ),
// //                   child: Padding(
// //                     padding: const EdgeInsets.all(32.0),
// //                     child: Column(
// //                       mainAxisSize: MainAxisSize.min,
// //                       children: [
// //                         Text(
// //                           'Welcome Back',
// //                           style: TextStyle(
// //                             fontSize: 28,
// //                             fontWeight: FontWeight.bold,
// //                             color: Colors.blue.shade800,
// //                           ),
// //                         ),
// //                         const SizedBox(height: 6),
// //                         Text(
// //                           'Sign in to your account',
// //                           style: TextStyle(color: Colors.grey.shade600),
// //                         ),
// //                         const SizedBox(height: 30),

// //                         // Email
// //                         TextField(
// //                           controller: _emailController,
// //                           decoration: const InputDecoration(
// //                             labelText: 'Email',
// //                             prefixIcon: Icon(Icons.email),
// //                             border: OutlineInputBorder(),
// //                           ),
// //                         ),
// //                         const SizedBox(height: 16),

// //                         // Password
// //                         TextField(
// //                           controller: _passwordController,
// //                           obscureText: _obscurePassword, // Use a state variable
// //                           decoration: InputDecoration(
// //                             labelText: 'Password',
// //                             prefixIcon: const Icon(Icons.lock),
// //                             suffixIcon: IconButton(
// //                               icon: Icon(
// //                                 _obscurePassword
// //                                     ? Icons.visibility_off
// //                                     : Icons.visibility,
// //                                 color: Colors.grey,
// //                               ),
// //                               onPressed: () {
// //                                 setState(() {
// //                                   _obscurePassword = !_obscurePassword;
// //                                 });
// //                               },
// //                             ),
// //                             border: const OutlineInputBorder(),
// //                           ),
// //                         ),

// //                         // FORGOT PASSWORD
// //                         Align(
// //                           alignment: Alignment.centerRight,
// //                           child: TextButton(
// //                             onPressed: _resetPassword,
// //                             child: const Text("Forgot Password?"),
// //                           ),
// //                         ),
// //                         const SizedBox(height: 10),

// //                         // LOGIN BUTTON
// //                         SizedBox(
// //                           width: double.infinity,
// //                           child: ElevatedButton(
// //                             onPressed: _isLoading ? null : _signIn,
// //                             style: ElevatedButton.styleFrom(
// //                               backgroundColor: Colors.blue.shade600,
// //                               foregroundColor: Colors.white,
// //                               padding: const EdgeInsets.symmetric(vertical: 16),
// //                             ),
// //                             child:
// //                                 _isLoading
// //                                     ? const SizedBox(
// //                                       height: 20,
// //                                       width: 20,
// //                                       child: CircularProgressIndicator(
// //                                         strokeWidth: 2,
// //                                         valueColor: AlwaysStoppedAnimation(
// //                                           Colors.white,
// //                                         ),
// //                                       ),
// //                                     )
// //                                     : const Text("Login"),
// //                           ),
// //                         ),

// //                         const SizedBox(height: 16),

// //                         // GOOGLE LOGIN
// //                         SizedBox(
// //                           width: double.infinity,
// //                           child: OutlinedButton(
// //                             onPressed:
// //                                 _isGoogleLoading ? null : _signInWithGoogle,
// //                             style: OutlinedButton.styleFrom(
// //                               padding: const EdgeInsets.symmetric(vertical: 14),
// //                               side: BorderSide(color: Colors.grey.shade400),
// //                             ),
// //                             child:
// //                                 _isGoogleLoading
// //                                     ? const SizedBox(
// //                                       height: 20,
// //                                       width: 20,
// //                                       child: CircularProgressIndicator(
// //                                         strokeWidth: 2,
// //                                         valueColor: AlwaysStoppedAnimation(
// //                                           Colors.black,
// //                                         ),
// //                                       ),
// //                                     )
// //                                     : Row(
// //                                       mainAxisAlignment:
// //                                           MainAxisAlignment.center,
// //                                       children: [
// //                                         Container(
// //                                           padding: const EdgeInsets.all(2),
// //                                           decoration: BoxDecoration(
// //                                             color: Colors.white,
// //                                             borderRadius: BorderRadius.circular(
// //                                               50,
// //                                             ),
// //                                           ),
// //                                           child: Image.asset(
// //                                             'assets/images/g-logo.png',
// //                                             width:
// //                                                 20, // equivalent to Icon size
// //                                             height: 20,
// //                                             fit: BoxFit.contain,
// //                                           ),
// //                                         ),
// //                                         const SizedBox(width: 12),
// //                                         const Text(
// //                                           "Sign in with Google",
// //                                           style: TextStyle(
// //                                             color: Colors.black87,
// //                                             fontWeight: FontWeight.w500,
// //                                           ),
// //                                         ),
// //                                       ],
// //                                     ),
// //                           ),
// //                         ),

// //                         const SizedBox(height: 16),

// //                         // SIGN UP LINK
// //                         Row(
// //                           mainAxisAlignment: MainAxisAlignment.center,
// //                           children: [
// //                             Text(
// //                               "Don't have an account? ",
// //                               style: TextStyle(color: Colors.grey.shade600),
// //                             ),
// //                             TextButton(
// //                               onPressed: () {
// //                                 Navigator.push(
// //                                   context,
// //                                   MaterialPageRoute(
// //                                     builder: (context) => SignUpPage(),
// //                                   ),
// //                                 );
// //                               },
// //                               child: const Text('Sign Up'),
// //                             ),
// //                           ],
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),

// //       // FOOTER
// //       bottomNavigationBar: Container(
// //         height: 115,
// //         decoration: BoxDecoration(
// //           color: Colors.blue.shade50,
// //           border: Border(
// //             top: BorderSide(width: 1, color: Colors.grey.shade300),
// //           ),
// //         ),
// //         child: Column(
// //           children: [
// //             Text(
// //               'SmartSpend - Your Personal Finance Manager',
// //               style: TextStyle(
// //                 fontSize: 16,
// //                 fontWeight: FontWeight.bold,
// //                 color: Colors.blue.shade700,
// //               ),
// //             ),
// //             const SizedBox(height: 8),
// //             Text(
// //               'Track your expenses • Manage your budget • Save smarter',
// //               style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
// //               textAlign: TextAlign.center,
// //             ),
// //             const SizedBox(height: 8),
// //             Text(
// //               '© 2024 SmartSpend App. All rights reserved.',
// //               style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _emailController.dispose();
// //     _passwordController.dispose();
// //     super.dispose();
// //   }
// // }


// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../services/auth_service.dart';
// import 'sign_up_page.dart';
// import 'dashboard_page.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _isLoading = false;
//   bool _isGoogleLoading = false;
//   bool _obscurePassword = true;

//   // ===========================================================================
//   // 🔔 CENTER POP-UP ERROR DIALOG
//   // ===========================================================================
//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         title: const Text(
//           "Login Error",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         content: Text(message),
//         actions: [
//           TextButton(
//             child: const Text("OK"),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//         ],
//       ),
//     );
//   }

//   // ===========================================================================
//   // 🔐 EMAIL + PASSWORD SIGN IN
//   // ===========================================================================
//   Future<void> _signIn() async {
//     final email = _emailController.text.trim();
//     final password = _passwordController.text.trim();

//     // -------------------- CLIENT SIDE VALIDATION ---------------------
//     if (email.isEmpty || password.isEmpty) {
//       _showErrorDialog("Please enter both email and password.");
//       return;
//     }

//     // Validate email format
//     bool validEmail = RegExp(r"^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,4}$").hasMatch(email);
//     if (!validEmail) {
//       _showErrorDialog("Please enter a valid email address.");
//       return;
//     }

//     setState(() => _isLoading = true);

//     try {
//       final authService = Provider.of<AuthService>(context, listen: false);
//       await authService.signInWithEmail(email, password);

//       if (!mounted) return;

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => DashboardPage()),
//       );

//     } on FirebaseAuthException catch (e) {
//       if (!mounted) return;

//       String errorMsg;

//       // ---------------------- FRIENDLY ERROR MESSAGES ---------------------
//       switch (e.code) {
//         case "invalid-email":
//           errorMsg = "The email format is invalid.";
//           break;
//         case "user-not-found":
//           errorMsg = "No account found with this email.";
//           break;
//         case "wrong-password":
//           errorMsg = "Incorrect password. Please try again.";
//           break;
//         case "user-disabled":
//           errorMsg = "This account has been disabled.";
//           break;

//         default:
//           errorMsg =
//               "Incorrect email or password. Please check your credentials and try again.";
//       }

//       _showErrorDialog(errorMsg);
//     } catch (e) {
//       if (!mounted) return;

//       _showErrorDialog("An unexpected error occurred. Please try again.");
//     } finally {
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }

//   // ===========================================================================
//   // 🔄 PASSWORD RESET
//   // ===========================================================================
//   Future<void> _resetPassword() async {
//     final email = _emailController.text.trim();

//     if (email.isEmpty || !email.contains("@")) {
//       _showErrorDialog("Enter a valid email to reset password.");
//       return;
//     }

//     try {
//       await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

//       _showErrorDialog("Password reset email sent!");

//     } catch (e) {
//       _showErrorDialog("Error sending password reset email.");
//     }
//   }

//   // ===========================================================================
//   // 🔐 GOOGLE SIGN-IN
//   // ===========================================================================
//   Future<void> _signInWithGoogle() async {
//     setState(() => _isGoogleLoading = true);

//     try {
//       GoogleAuthProvider googleProvider = GoogleAuthProvider();

//       final credential =
//           await FirebaseAuth.instance.signInWithPopup(googleProvider);

//       if (credential.user != null && mounted) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => DashboardPage()),
//         );
//       }

//     } catch (e) {
//       if (mounted) {
//         _showErrorDialog("Google sign-in failed. Please try again.");
//       }

//     } finally {
//       if (mounted) setState(() => _isGoogleLoading = false);
//     }
//   }

//   // ===========================================================================
//   // UI
//   // ===========================================================================
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login'),
//         backgroundColor: Colors.blue.shade600,
//         foregroundColor: Colors.white,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.blue.shade50, Colors.green.shade50],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(24.0),
//             child: Column(
//               children: [
//                 Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(32.0),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           'Welcome Back',
//                           style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.blue.shade800,
//                           ),
//                         ),
//                         const SizedBox(height: 6),
//                         Text(
//                           'Sign in to your account',
//                           style: TextStyle(color: Colors.grey.shade600),
//                         ),
//                         const SizedBox(height: 30),

//                         // Email
//                         TextField(
//                           controller: _emailController,
//                           decoration: const InputDecoration(
//                             labelText: 'Email',
//                             prefixIcon: Icon(Icons.email),
//                             border: OutlineInputBorder(),
//                           ),
//                         ),
//                         const SizedBox(height: 16),

//                         // Password
//                         TextField(
//                           controller: _passwordController,
//                           obscureText: _obscurePassword,
//                           decoration: InputDecoration(
//                             labelText: 'Password',
//                             prefixIcon: const Icon(Icons.lock),
//                             suffixIcon: IconButton(
//                               icon: Icon(
//                                 _obscurePassword
//                                     ? Icons.visibility_off
//                                     : Icons.visibility,
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   _obscurePassword = !_obscurePassword;
//                                 });
//                               },
//                             ),
//                             border: const OutlineInputBorder(),
//                           ),
//                         ),

//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: TextButton(
//                             onPressed: _resetPassword,
//                             child: const Text("Forgot Password?"),
//                           ),
//                         ),
//                         const SizedBox(height: 10),

//                         // Login Button
//                         SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton(
//                             onPressed: _isLoading ? null : _signIn,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.blue.shade600,
//                               foregroundColor: Colors.white,
//                               padding: const EdgeInsets.symmetric(vertical: 16),
//                             ),
//                             child: _isLoading
//                                 ? const SizedBox(
//                                     height: 20,
//                                     width: 20,
//                                     child: CircularProgressIndicator(
//                                       strokeWidth: 2,
//                                       valueColor:
//                                           AlwaysStoppedAnimation(Colors.white),
//                                     ),
//                                   )
//                                 : const Text("Login"),
//                           ),
//                         ),

//                         const SizedBox(height: 16),

//                         // Google Sign-In
//                         SizedBox(
//                           width: double.infinity,
//                           child: OutlinedButton(
//                             onPressed:
//                                 _isGoogleLoading ? null : _signInWithGoogle,
//                             style: OutlinedButton.styleFrom(
//                               padding: const EdgeInsets.symmetric(vertical: 14),
//                               side: BorderSide(color: Colors.grey.shade400),
//                             ),
//                             child: _isGoogleLoading
//                                 ? const SizedBox(
//                                     height: 20,
//                                     width: 20,
//                                     child: CircularProgressIndicator(
//                                       strokeWidth: 2,
//                                       valueColor:
//                                           AlwaysStoppedAnimation(Colors.black),
//                                     ),
//                                   )
//                                 : Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Image.asset(
//                                         'assets/images/g-logo.png',
//                                         width: 20,
//                                         height: 20,
//                                       ),
//                                       const SizedBox(width: 12),
//                                       const Text(
//                                         "Sign in with Google",
//                                         style: TextStyle(
//                                           color: Colors.black87,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                           ),
//                         ),

//                         const SizedBox(height: 16),

//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               "Don't have an account? ",
//                               style: TextStyle(color: Colors.grey.shade600),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => SignUpPage()),
//                                 );
//                               },
//                               child: const Text('Sign Up'),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),

//       bottomNavigationBar: Container(
//         height: 115,
//         decoration: BoxDecoration(
//           color: Colors.blue.shade50,
//           border: Border(top: BorderSide(color: Colors.grey.shade300)),
//         ),
//         child: Column(
//           children: [
//             Text(
//               'SmartSpend - Your Personal Finance Manager',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blue.shade700,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Track your expenses • Manage your budget • Save smarter',
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.grey.shade600,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 8),
//             Text(
//               '© 2024 SmartSpend App. All rights reserved.',
//               style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import 'sign_up_page.dart';
import 'dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isGoogleLoading = false;
  bool _obscurePassword = true;

  // ===========================================================================
  // 🔔 CENTER POP-UP ERROR DIALOG
  // ===========================================================================
  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 🔐 EMAIL + PASSWORD SIGN IN
  // ===========================================================================
  Future<void> _signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // -------------------- CLIENT SIDE VALIDATION ---------------------
    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog("Missing Information", "Please enter both email and password.");
      return;
    }

    // Validate email format
    bool validEmail = RegExp(r"^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,4}$").hasMatch(email);
    if (!validEmail) {
      _showErrorDialog("Invalid Email", "Please enter a valid email address.");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      await authService.signInWithEmail(email, password);

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardPage()),
      );

    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String errorTitle = "Login Failed";
      String errorMsg;

      // ---------------------- FRIENDLY ERROR MESSAGES ---------------------
      switch (e.code) {
        case "invalid-email":
          errorMsg = "The email format is invalid. Please check your email address.";
          break;
        case "user-not-found":
          errorMsg = "No account found with this email. Please check your email or sign up for a new account.";
          break;
        case "wrong-password":
          errorMsg = "Incorrect password. Please try again or use 'Forgot Password' to reset it.";
          break;
        case "user-disabled":
          errorMsg = "This account has been disabled. Please contact support for assistance.";
          break;
        case "too-many-requests":
          errorMsg = "Too many unsuccessful login attempts. Please try again later or reset your password.";
          break;
        case "network-request-failed":
          errorMsg = "Network error. Please check your internet connection and try again.";
          break;
        case "invalid-credential":
          errorMsg = "The provided credentials are invalid. Please check your email and password.";
          break;
        default:
          errorTitle = "Authentication Error";
          errorMsg = "An error occurred during login: ${e.message ?? 'Please try again.'}";
      }

      _showErrorDialog(errorTitle, errorMsg);
    } catch (e) {
      if (!mounted) return;
      _showErrorDialog("Unexpected Error", "An unexpected error occurred. Please try again.");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // ===========================================================================
  // 🔄 PASSWORD RESET
  // ===========================================================================
  Future<void> _resetPassword() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      _showErrorDialog("Email Required", "Please enter your email address to reset your password.");
      return;
    }

    // Validate email format
    bool validEmail = RegExp(r"^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,4}$").hasMatch(email);
    if (!validEmail) {
      _showErrorDialog("Invalid Email", "Please enter a valid email address to reset your password.");
      return;
    }

    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      if (!mounted) return;

      _showErrorDialog("Email Sent", "Password reset instructions have been sent to $email");
      
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String errorMsg;
      switch (e.code) {
        case "user-not-found":
          errorMsg = "No account found with this email address.";
          break;
        case "invalid-email":
          errorMsg = "The email address is not valid.";
          break;
        case "network-request-failed":
          errorMsg = "Network error. Please check your internet connection.";
          break;
        default:
          errorMsg = "Failed to send reset email: ${e.message ?? 'Please try again.'}";
      }
      _showErrorDialog("Reset Failed", errorMsg);
    } catch (e) {
      if (!mounted) return;
      _showErrorDialog("Error", "Failed to send password reset email. Please try again.");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // ===========================================================================
  // 🔐 GOOGLE SIGN-IN
  // ===========================================================================
  Future<void> _signInWithGoogle() async {
    setState(() => _isGoogleLoading = true);

    try {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      final credential = await FirebaseAuth.instance.signInWithPopup(googleProvider);

      if (credential.user != null && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DashboardPage()),
        );
      }

    } on FirebaseAuthException catch (e) {
      if (mounted) {
        String errorMsg = "Google sign-in failed. ";
        switch (e.code) {
          case "account-exists-with-different-credential":
            errorMsg += "An account already exists with the same email but different sign-in method.";
            break;
          case "popup-closed-by-user":
            errorMsg += "Sign-in was cancelled.";
            break;
          case "network-request-failed":
            errorMsg += "Network error. Please check your internet connection.";
            break;
          default:
            errorMsg += "Please try again. Error: ${e.message}";
        }
        _showErrorDialog("Google Sign-In Failed", errorMsg);
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog("Google Sign-In Failed", "An unexpected error occurred. Please try again.");
      }
    } finally {
      if (mounted) setState(() => _isGoogleLoading = false);
    }
  }

  // ===========================================================================
  // UI (Rest of your UI code remains the same)
  // ===========================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.green.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade800,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Sign in to your account',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        const SizedBox(height: 30),

                        // Email
                        TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Password
                        TextField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            border: const OutlineInputBorder(),
                          ),
                        ),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: _resetPassword,
                            child: const Text("Forgot Password?"),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _signIn,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade600,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                    ),
                                  )
                                : const Text("Login"),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Google Sign-In
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed:
                                _isGoogleLoading ? null : _signInWithGoogle,
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              side: BorderSide(color: Colors.grey.shade400),
                            ),
                            child: _isGoogleLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.black),
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/g-logo.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      const Text(
                                        "Sign in with Google",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignUpPage()),
                                );
                              },
                              child: const Text('Sign Up'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: Container(
        height: 115,
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
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
              style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}