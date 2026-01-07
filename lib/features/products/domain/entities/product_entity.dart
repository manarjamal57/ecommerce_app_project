enum SizeType { none, clothing, shoes, bags }

class ProductEntity {
  final String id;
  final String categoryName;
  final String title;
  final String subtitle;
  final String image;
  final double price;
  final String description;
  final double rating;

  // ✅ جديد
  final SizeType sizeType;
  final List<String> sizeOptions;

  const ProductEntity({
    required this.id,
    required this.categoryName,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.price,
    required this.description,
    required this.rating,

    // ✅ defaults عشان ما تكسر الداتا القديمة
    this.sizeType = SizeType.none,
    this.sizeOptions = const [],
  });
}
