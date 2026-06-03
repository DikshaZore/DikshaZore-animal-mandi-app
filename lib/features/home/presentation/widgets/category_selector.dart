import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final bool isSelected;

  const CategoryCard({Key? key, required this.title, this.isSelected = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, IconData> animalIcons = {
      'Dog': Icons.pets,
      'Cat': Icons.pets,
      'Goat': Icons.agriculture,
      'Cow': Icons.agriculture,
      'Horse': Icons.agriculture,
      'Rabbit': Icons.pets,
      'Bird': Icons.flutter_dash,
      'Fish': Icons.water,
      'Others': Icons.category,
    };

    return Container(
      width: 80,
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF2D8659) : Colors.white,
        border: Border.all(color: isSelected ? const Color(0xFF2D8659) : const Color(0xFFE0E0E0), width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(animalIcons[title] ?? Icons.help, color: isSelected ? Colors.white : const Color(0xFF2D8659), size: 28),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(title, style: TextStyle(fontFamily: 'Poppins', fontSize: 11, fontWeight: FontWeight.w500, color: isSelected ? Colors.white : const Color(0xFF1F1F1F)), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}