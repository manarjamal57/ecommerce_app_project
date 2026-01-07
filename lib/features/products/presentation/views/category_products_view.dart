import 'package:ecommerce_app_project/features/products/data/repos/products_repo.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_app_project/features/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app_project/features/products/domain/entities/product_entity.dart';
import 'package:ecommerce_app_project/features/products/presentation/views/product_detailes_view.dart';
import 'package:ecommerce_app_project/features/products/presentation/widget/product_card.dart';

// ✅ Repo (Firestore)


class CategoryProductsView extends StatelessWidget {
  const CategoryProductsView({
    super.key,
    required this.category,
  });

  static const routeName = '/category-products';

  final CategoryEntity category;

  @override
  Widget build(BuildContext context) {
    final repo = ProductsRepo();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(999),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(999),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.search, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                category.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),

              // ✅ بدل allProducts -> Firestore Stream
              Expanded(
                child: StreamBuilder<List<ProductEntity>>(
                  stream: repo.streamByCategory(category.title),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }

                    final products = (snapshot.data ?? []).take(8).toList();

                    if (products.isEmpty) {
                      return const Center(
                        child: Text('No products in this category'),
                      );
                    }

                    return GridView.builder(
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 14,
                        childAspectRatio: 0.62,
                      ),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              ProductDetailsView.routeName,
                              arguments: product,
                            );
                          },
                          child: ProductCard(
  product: product,
  showRating: false,
  onTap: () {
    Navigator.pushNamed(
      context,
      ProductDetailsView.routeName,
      arguments: product,
    );
  },
),

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
