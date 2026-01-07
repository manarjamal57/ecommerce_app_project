import 'package:flutter/material.dart';
import '../../domain/entities/category_entity.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.category,
    required this.onTap,
  });

  final CategoryEntity category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final count = category.count;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        height: 75,
        padding: const EdgeInsets.symmetric(horizontal: 20,),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          children: [
            Icon(category.icon, color: Colors.white, size: 26),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                category.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                ),
              ),
            ),
            if (count != null)
              Text(
                '$count Product',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.80),
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
