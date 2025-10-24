import 'package:flutter/material.dart';

class AllergyChip extends StatelessWidget {
  final String allergen;
  final bool selected;
  final ValueChanged<bool> onSelected;

  const AllergyChip({
    Key? key,
    required this.allergen,
    required this.selected,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(allergen),
      selected: selected,
      onSelected: onSelected,
      selectedColor: Colors.deepOrange[100],
      checkmarkColor: Colors.deepOrange[800],
      labelStyle: TextStyle(
        color: selected ? Colors.deepOrange[800] : Colors.black,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: selected ? Colors.deepOrange[800]! : Colors.grey,
        ),
      ),
    );
  }
}