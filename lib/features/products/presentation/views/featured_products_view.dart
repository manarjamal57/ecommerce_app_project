import 'package:ecommerce_app_project/features/products/data/repos/products_repo.dart';
import 'package:ecommerce_app_project/features/products/domain/entities/product_entity.dart';
import 'package:ecommerce_app_project/features/products/presentation/views/product_detailes_view.dart';
import 'package:ecommerce_app_project/features/products/presentation/widget/product_card.dart';
import 'package:flutter/material.dart';

class FeaturedProductsView extends StatelessWidget {
  const FeaturedProductsView({super.key});
  static const String routeName = '/featured-products';

  @override
  Widget build(BuildContext context) {
    final repo = ProductsRepo();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Featured Products'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: StreamBuilder<List<ProductEntity>>(
          stream: repo.streamFeaturedProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final items = snapshot.data ?? [];
            if (items.isEmpty) {
              return const Center(child: Text('No featured products found'));
            }

            return GridView.builder(
              itemCount: items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.60,
              ),
              itemBuilder: (context, index) {
                final product = items[index];

                return ProductCard(
                  product: product,
                  showRating: false,  // ✅ ما تظهر النجمة هون
                  showSubtitle: true, // ✅ يظهر السابتايتل
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ProductDetailsView.routeName,
                      arguments: product,
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
