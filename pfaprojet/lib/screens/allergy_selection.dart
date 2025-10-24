import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'recommendations.dart';
import 'map.dart'; // ✅ Add this import

class AllergySelectionScreen extends StatefulWidget {
  final String userEmail;

  const AllergySelectionScreen({required this.userEmail});

  @override
  _AllergySelectionScreenState createState() => _AllergySelectionScreenState();
}

class _AllergySelectionScreenState extends State<AllergySelectionScreen> {
  final List<String> ingredients = [
    'almond paste',
    'almonds',
    'anise',
    'argan oil',
    'avocado',
    'baking powder',
    'barley',
    'beef',
    'beef or lamb',
    'beets',
    'breadcrumbs',
    'butter',
    'camel meat',
    'carrots',
    'celery',
    'chermoula',
    'chicken',
    'chicken or pigeon',
    'chickpeas',
    'cilantro',
    'cinnamon',
    'coriander seeds',
    'cumin',
    'dates',
    'dried beef',
    'dried fava beans',
    'eggplant',
    'eggs',
    'fenugreek',
    'fish',
    'flour',
    'garlic',
    'green peppers',
    'green tea',
    'grilled peppers',
    'ground beef',
    'ground meat or cheese',
    'herbs',
    'honey',
    'lamb',
    'lamb or chicken',
    'lentils',
    'mallows',
    'milk',
    'mint',
    'msemen',
    'oil',
    'olive oil',
    'olives',
    'onions',
    'orange blossom water',
    'oranges',
    'paprika',
    'parsley',
    'phyllo dough',
    'potatoes',
    'powdered sugar',
    'preserved lemon',
    'prunes',
    'raisins',
    'ras el hanout',
    'rice',
    'saffron',
    'salt',
    'sardines',
    'semolina',
    'sesame',
    'sesame seeds',
    'smen',
    'spices',
    'sugar',
    'tomatoes',
    'vermicelli',
    'vermicelli or couscous',
    'vinegar',
    'white beans',
    'whole lamb',
    'yeast',
    'zucchini',
  ];

  Set<String> selectedAllergies = {};
  bool isLoading = false;

  void _toggleSelection(String label) {
    setState(() {
      if (selectedAllergies.contains(label)) {
        selectedAllergies.remove(label);
      } else {
        selectedAllergies.add(label);
      }
    });
  }

  Future<void> _confirmSelection() async {
    setState(() => isLoading = true);

    final response = await http.post(
      Uri.parse('http://192.168.1.105:5000/auth/update_allergies'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': widget.userEmail,
        'allergies': selectedAllergies.toList(),
      }),
    );

    setState(() => isLoading = false);

    if (response.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => RecommendationsScreen(userEmail: widget.userEmail), // ✅ FIXED
        ),
      );
    } else {
      final error = jsonDecode(response.body)['error'] ?? "Error saving allergies";
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Error"),
          content: Text(error),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F2E8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF426850),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'TasteMorocco',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset('assets/pfalogo.png', height: 80),
            const SizedBox(height: 12),
            const Text(
              'Select ingredients you want to avoid',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF426850),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.only(bottom: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 2.8,
                ),
                itemCount: ingredients.length,
                itemBuilder: (context, index) {
                  final label = ingredients[index];
                  final isSelected = selectedAllergies.contains(label);
                  return AllergyChip(
                    label: label,
                    isSelected: isSelected,
                    onTap: () => _toggleSelection(label),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
          child: ElevatedButton(
            onPressed: isLoading ? null : _confirmSelection,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: const Color(0xFF426850),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text(
              'Confirm Selection',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AllergyChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const AllergyChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFD7CCC8) : const Color(0xFFEFEBE9),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isSelected ? const Color(0xFF426850) : Colors.brown.shade200,
          width: 2,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSelected ? Icons.check_circle : Icons.circle_outlined,
                color: isSelected ? const Color(0xFF426850) : Colors.grey,
                size: 20,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    color: isSelected ? const Color(0xFF426850) : Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
