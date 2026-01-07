class CartItem {
  final String productId;
  final String title;
  final String subtitle;
  final String imageUrl;
  final double price;
  int quantity;

  CartItem({
    required this.productId,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.price,
    this.quantity = 1,
  });

  double get lineTotal => price * quantity;
}
