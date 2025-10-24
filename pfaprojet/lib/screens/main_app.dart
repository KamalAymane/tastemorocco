import 'package:flutter/material.dart';
import 'recommendations.dart';
import 'scanner.dart';
import 'scan_history.dart';
import 'map.dart';

class MainAppScreen extends StatefulWidget {
  final String userEmail;

  const MainAppScreen({required this.userEmail, super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    try {
      _screens = [
        RecommendationsScreen(userEmail: widget.userEmail),
        ScannerScreen(),
        ScanHistoryScreen(),
        MapScreen(),
      ];
    } catch (e, stack) {
      print("❌ Failed to build screens: $e");
      print(stack);
      // Fallback to prevent crash
      _screens = List.generate(
        4,
            (index) => Center(child: Text("Error loading screen $index")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index < _screens.length) {
            setState(() => _currentIndex = index);
          } else {
            print("❗ Invalid tab index: $index");
          }
        },
        selectedItemColor: const Color(0xFF426850),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: 'Scan'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
        ],
      ),
    );
  }
}