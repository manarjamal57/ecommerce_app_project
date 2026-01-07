import 'package:flutter/material.dart';
import 'package:ecommerce_app_project/features/products/presentation/views/category_products_view.dart';
import '../../domain/entities/category_entity.dart';

class CategoriesStrip extends StatelessWidget {
  const CategoriesStrip({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onSelect,
  });

  final List<CategoryEntity> categories;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          final category = categories[index];

          return InkWell(
            onTap: () {
              // ✅ 1) اختياري: يغير شكل المختار
              onSelect(index);

              // ✅ 2) يفتح صفحة منتجات الكاتيجوري
              Navigator.pushNamed(
                context,
                CategoryProductsView.routeName,
                arguments: category, // لازم CategoryEntity
              );
            },
            borderRadius: BorderRadius.circular(24),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isSelected ? Colors.black : const Color(0xFFE6E6E6),
                ),
              ),
              child: Text(
                category.title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
