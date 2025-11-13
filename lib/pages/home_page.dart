import 'package:flutter/material.dart';
import 'login_page.dart'; // Import the pages directly
import 'sign_up_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade50, Colors.green.shade50],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Logo/Icon
                Icon(
                  Icons.account_balance_wallet,
                  size: 80,
                  color: Colors.blue.shade700,
                ),
                const SizedBox(height: 24),

                // App Title
                Text(
                  'SmartSpend',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),

                // Tagline
                const SizedBox(height: 16),
                Text(
                  'Track your expenses, control your spending.',
                  style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
                  textAlign: TextAlign.center,
                ),

                // Buttons
                const SizedBox(height: 48),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      // Direct navigation to LoginPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Login'),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 200,
                  child: OutlinedButton(
                    onPressed: () {
                      // Direct navigation to SignUpPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Create Account'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
