import 'package:flutter/material.dart';

class ScanResultScreen extends StatelessWidget {
  final Map<String, dynamic>? product;
  final String? productName;
  final String? imageUrl;
  final String? score;
  final String? ingredients;

  const ScanResultScreen({
    super.key,
    this.product,
    this.productName,
    this.imageUrl,
    this.score,
    this.ingredients,
  });

  Color getNutriScoreColor(String grade) {
    switch (grade.toUpperCase()) {
      case 'A':
        return Colors.green;
      case 'B':
        return Colors.lightGreen;
      case 'C':
        return Colors.orange;
      case 'D':
        return Colors.deepOrange;
      case 'E':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget buildScoreCard(String label, String value, IconData icon, Color color) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      shadowColor: color.withOpacity(0.3),
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(value, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final nutriments = product?['nutriments'] ?? {};
    final grade = product?['grade'] ?? product?['nutriscore_grade'] ?? 'N/A';
    final scoreValue = score ?? product?['score']?.toString() ?? 'N/A';
    final displayIngredients = ingredients ?? product?['ingredients_text'] ?? 'No ingredient info';

    return Scaffold(
      backgroundColor: const Color(0xFFF9F2E8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF426850),
        title: const Text('Product Info', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, 'refresh_history'); // 🟢 Trigger history refresh
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if ((imageUrl ?? product?['image']) != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  imageUrl ?? product!['image'],
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 20),
            Text(
              productName ?? product?['name'] ?? 'Unknown Product',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF426850),
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              product?['brand'] ?? '',
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: getNutriScoreColor(grade),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: getNutriScoreColor(grade).withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Text(
                'Nutri-Score: $grade',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 20),
            buildScoreCard('Health Score', '$scoreValue / 100', Icons.favorite, Colors.teal),
            buildScoreCard('Sugars (100g)', '${nutriments['sugars_100g'] ?? 'N/A'} g',
                Icons.cake, Colors.pink),
            buildScoreCard('Saturated Fat (100g)', '${nutriments['saturated_fat_100g'] ?? 'N/A'} g',
                Icons.local_pizza, Colors.redAccent),
            buildScoreCard('Energy (kcal/100g)', '${nutriments['energy_kcal_100g'] ?? 'N/A'} kcal',
                Icons.flash_on, Colors.deepOrange),
            buildScoreCard('Fruits & Veggies (100g)', '${nutriments['fruits_vegetables_100g'] ?? 'N/A'} %',
                Icons.eco, Colors.green),
            buildScoreCard('Additives', '${product?['additives_count'] ?? 'N/A'} found',
                Icons.warning, Colors.orange),
            const SizedBox(height: 24),
            const Text("Ingredients:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF426850),
                )),
            const SizedBox(height: 8),
            Text(
              displayIngredients,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
