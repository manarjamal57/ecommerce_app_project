

import 'package:ecommerce_app_project/features/products/domain/entities/product_entity.dart';

SizeType sizeTypeFromCategory(String categoryName) {
  final c = categoryName.trim().toLowerCase();

  // ✅ أسماء الكاتيجوري اللي عندك بالصورة
  if (c == 'clothes') return SizeType.clothing;
  if (c == 'shoes') return SizeType.shoes;
  if (c == 'bags') return SizeType.bags;

  // باقي الكاتيجوري (New Arrivals / Electronics / Jewelry) بدون سايز غالبًا
  return SizeType.none;
}

List<String> defaultSizesFor(SizeType type) {
  switch (type) {
    case SizeType.clothing:
      return const ['S', 'M', 'L', 'XL'];
    case SizeType.shoes:
      return const ['38','39', '40', '41', '42', ];
    case SizeType.bags:
      return const ['S','M','L']; // إذا بدكها Small/Medium/Large بدّلها هون
    case SizeType.none:
      return const [];
  }
}
