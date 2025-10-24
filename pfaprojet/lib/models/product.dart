class MoroccanProduct {
  final String barcode;
  final String name;
  final String brand;
  final List<String> ingredients;
  final List<String> allergens;
  final bool isHalal;

  MoroccanProduct({
    required this.barcode,
    required this.name,
    required this.brand,
    required this.ingredients,
    required this.allergens,
    required this.isHalal,
  });
}