import 'package:flutter/material.dart';

class CategoriesHeader extends StatelessWidget {
  const CategoriesHeader({
    super.key,
    required this.title,
    required this.onViewAll,
  });

  final String title;
  final VoidCallback onViewAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        TextButton(
          onPressed: onViewAll,
          child: const Text(
            'View All',
            style: TextStyle(color: Colors.black,
              fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
