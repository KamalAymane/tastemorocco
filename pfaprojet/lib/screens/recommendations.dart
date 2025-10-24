import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dish_detail.dart';
import 'scanner.dart';
import 'scan_history.dart';

class RecommendationsScreen extends StatefulWidget {
  final String userEmail;

  const RecommendationsScreen({required this.userEmail});

  @override
  _RecommendationsScreenState createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      RecommendationsScreenBody(userEmail: widget.userEmail),
      ScannerScreen(),
      ScanHistoryScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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

class RecommendationsScreenBody extends StatefulWidget {
  final String userEmail;

  const RecommendationsScreenBody({required this.userEmail});

  @override
  _RecommendationsScreenBodyState createState() => _RecommendationsScreenBodyState();
}

class _RecommendationsScreenBodyState extends State<RecommendationsScreenBody> {
  List<dynamic> foods = [];
  List<dynamic> filteredFoods = [];
  bool isLoading = true;
  String selectedCategory = '';

  final Map<String, IconData> categoryIcons = {
    'All': Icons.all_inclusive,
    'Healthy': Icons.eco,
    'Spicy': Icons.local_fire_department,
    'Sweet': Icons.cake,
    'Salty': Icons.local_drink,
  };

  @override
  void initState() {
    super.initState();
    fetchRecommendations();
  }

  Future<void> fetchRecommendations() async {
    final url = Uri.parse('http://192.168.1.105:5000/recommendations/get?email=${widget.userEmail}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          foods = List.from(data);
          filteredFoods = foods;
          isLoading = false;
        });
      } else {
        print('Failed to load recommendations: ${response.statusCode}');
        setState(() => isLoading = false);
      }
    } catch (e) {
      print('Error fetching recommendations: $e');
      setState(() => isLoading = false);
    }
  }

  void _filterByCategory(String category) {
    setState(() {
      selectedCategory = category;
      if (category.isEmpty) {
        filteredFoods = foods;
      } else {
        filteredFoods = foods.where((dish) => dish['category']?.toLowerCase() == category.toLowerCase()).toList();
      }
    });
  }

  void _showDishDetails(BuildContext context, Map dish) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      backgroundColor: const Color(0xFFF9F2E8),
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.brown[200],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Text(
              dish['name'],
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF426850),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              '🧂 Ingredients:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF426850),
              ),
            ),
            const SizedBox(height: 10),
            ...dish['ingredients']
                .toString()
                .split(',')
                .map((ingredient) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.circle, size: 8, color: Colors.brown),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      ingredient.trim(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ))
                .toList(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF9F2E8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF426850),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Recommended Foods',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
      body: filteredFoods.isEmpty
          ? const Center(
        child: Text(
          "No suitable dishes found for your allergies.",
          style: TextStyle(fontSize: 16, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            // One functional row with icons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categoryIcons.entries.map((entry) {
                  final label = entry.key;
                  final icon = entry.value;
                  final isSelected = selectedCategory == (label == 'All' ? '' : label);
                  return FilterCategoryChip(
                    label: label,
                    icon: icon,
                    isSelected: isSelected,
                    onTap: (selected) => _filterByCategory(selected == 'All' ? '' : selected),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24.0),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1.3,
              ),
              itemCount: filteredFoods.length,
              itemBuilder: (context, index) {
                final dish = filteredFoods[index];
                return GestureDetector(
                  onTap: () => _showDishDetails(context, dish),
                  child: PopularFoodCard(
                    image: 'assets/${dish['name'].toString().toLowerCase().replaceAll(' ', '_')}.jpeg',
                    name: dish['name'],
                    tag: dish['category'] ?? 'Allergen-Free',
                  ),
                );
              },
            ),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}

class PopularFoodCard extends StatelessWidget {
  final String image;
  final String name;
  final String tag;

  const PopularFoodCard({required this.image, required this.name, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFEFEBE9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(
                    0xFF426850))),
                Text(tag, style: const TextStyle(color: Colors.grey, fontSize: 12.0)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FilterCategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final Function(String) onTap;

  const FilterCategoryChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        avatar: Icon(icon, color: isSelected ? Colors.white : Color(0xFF426850), size: 18),
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onTap(label),
        selectedColor: const Color(0xFF426850),
        backgroundColor: const Color(0xFFD7CCC8),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Color(0xFF426850),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}