class MoroccanDish {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> cookingSteps;
  final List<String> allergens;
  final String category; // tajine, couscous, etc.

  MoroccanDish({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.ingredients,
    required this.cookingSteps,
    required this.allergens,
    required this.category,
  });
}