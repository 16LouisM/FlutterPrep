// import 'package:flutter/material.dart';
// import 'package:flutter_prep/services/firebase_options.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_prep/pages/home_page.dart';
// import 'package:flutter_prep/services/auth_service.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // ✅ Initialize Firebase first
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   runApp(
//     MultiProvider(
//       providers: [
//         // ✅ Change this line to use ChangeNotifierProvider
//         ChangeNotifierProvider<AuthService>(create: (_) => AuthService()),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'SmartSpend',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home: const HomePage(),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_prep/services/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_prep/services/auth_service.dart';
import 'package:flutter_prep/pages/login_page.dart';
import 'package:flutter_prep/pages/home_page.dart';
import 'package:flutter_prep/pages/dashboard_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(create: (_) => AuthService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return StreamBuilder(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        /// While Firebase is still checking authentication persistence state.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        /// If user is logged in → go to Dashboard
        if (snapshot.hasData) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'SmartSpend',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
            home: DashboardPage(),
          );
        }

        /// If not logged in → go to Login
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SmartSpend',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: const HomePage(),
        );
      },
    );
  }
}
