import 'package:flutter/material.dart';
import 'package:ecommerce_app_project/features/home/presentation/widgets/header_cat.dart';
import 'package:ecommerce_app_project/features/products/presentation/views/category_products_view.dart';
import '../../domain/entities/category_entity.dart';
import '../widgets/category_tile.dart';

class AllCategoriesView extends StatelessWidget {
  const AllCategoriesView({
    super.key,
    required this.onBack,
    required this.categories,
    required this.onSelectCategory,
  });

  static const routeName = '/all-categories';

  final VoidCallback onBack;
  final List<CategoryEntity> categories;
  final ValueChanged<CategoryEntity> onSelectCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderCat(onBack: onBack),
              const SizedBox(height: 20),
              const Text(
                'Categories',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 30),
                  itemBuilder: (context, i) {
                    final cat = categories[i];

                    return CategoryTile(
                      category: cat,
                      onTap: () {
                     
                    

                        Navigator.pushNamed(
                          context,
                          CategoryProductsView.routeName,
                          arguments: cat,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
