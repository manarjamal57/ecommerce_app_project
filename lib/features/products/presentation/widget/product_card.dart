import 'package:flutter/material.dart';
import 'package:ecommerce_app_project/core/utils/app_text_styles.dart';
import 'package:ecommerce_app_project/features/products/domain/entities/product_entity.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.showSubtitle = true,
    this.showRating = true, // ✅ جديد
  });

  final ProductEntity product;
  final VoidCallback? onTap;

  /// إذا false ما بعرض subtitle
  final bool showSubtitle;

  /// إذا false ما بعرض نجمة التقييم
  final bool showRating;

  bool get _isNetworkImage {
    final img = product.image.trim();
    return img.startsWith('http://') || img.startsWith('https://');
  }

  Widget _buildImage() {
    final img = product.image.trim();

    if (img.isEmpty) {
      return _imagePlaceholder();
    }

    if (_isNetworkImage) {
      return Image.network(
        img,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stack) => _imagePlaceholder(),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(
            child: SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        },
      );
    }

    return Image.asset(
      img,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stack) => _imagePlaceholder(),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      color: const Color(0xFFF2F2F2),
      child: const Center(
        child: Icon(Icons.image_not_supported_outlined, size: 34),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // الصورة
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 14,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: _buildImage(),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // العنوان
          Text(
            product.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.semiBold16,
          ),

          // subtitle
          if (showSubtitle && product.subtitle.trim().isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              product.subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.regular13.copyWith(color: Colors.black54),
            ),
          ],

          const SizedBox(height: 8),

          // السعر + (اختياري) التقييم
          Row(
               mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: AppTextStyles.bold16,
              ),

              if (showRating) ...[
                const Spacer(),
                Icon(Icons.star, size: 16, color: Colors.amber.shade700),
                const SizedBox(width: 4),
                Text(
                  product.rating.toStringAsFixed(1),
                  style:
                      AppTextStyles.regular13.copyWith(color: Colors.black54),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
