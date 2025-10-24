import 'package:flutter/material.dart';
import 'package:pfaprojet/screens/auth/login.dart';
import 'package:pfaprojet/screens/auth/signup.dart';
import 'package:pfaprojet/screens/main_app.dart'; // ✅ Import the MainAppScreen
import 'package:pfaprojet/screens/map.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TasteMorocco',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Color(0xFFF9F2E8),
        fontFamily: 'Roboto',
      ),
      // Start with signup/login — update as needed
      home: SignupScreen(), // Or LoginScreen()

      // Optional: Named routes (for cleaner navigation)
      routes: {
        '/login': (_) => LoginScreen(),
        '/signup': (_) => SignupScreen(),
        // '/main' is passed manually with email below
      },
    );
  }
}
