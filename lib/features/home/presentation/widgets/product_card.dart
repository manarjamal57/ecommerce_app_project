import 'package:ecommerce_app_project/core/utils/app_text_styles.dart';
import 'package:ecommerce_app_project/features/products/domain/entities/product_entity.dart';
import 'package:ecommerce_app_project/features/products/presentation/views/product_detailes_view.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.onTap, required bool showSubtitle, required bool showRating,
  });

  final ProductEntity product;
  final VoidCallback? onTap;

  void _openDetails(BuildContext context) {
    Navigator.pushNamed(
      context,
      ProductDetailsView.routeName,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => _openDetails(context),
      borderRadius: BorderRadius.circular(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  product.image,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.favorite_border,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(product.title, style: AppTextStyles.card),
          const SizedBox(height: 4),
          Text(product.subtitle, style: AppTextStyles.subtitle),
          const SizedBox(height: 6),
          Text('\$${product.price.toStringAsFixed(2)}', style: AppTextStyles.price),
        ],
      ),
    );
  }
}
