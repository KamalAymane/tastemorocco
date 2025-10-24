import 'package:flutter/material.dart';

class DishDetailScreen extends StatelessWidget {
  final Map<String, dynamic> dish;

  const DishDetailScreen({required this.dish});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(dish['name'] ?? 'Dish')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(dish['description'] ?? 'No description available.'),
      ),
    );
  }
}
