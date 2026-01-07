import 'package:flutter/material.dart';
import '../domain/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemsCount => _items.length;

  int get totalUnits =>
      _items.fold<int>(0, (sum, item) => sum + item.quantity);

  double get subtotal =>
      _items.fold<double>(0, (sum, item) => sum + item.lineTotal);

  double shipping = 17; // ✅ مثل فيجما

  double get total => subtotal + (items.isEmpty ? 0 : shipping);

  /// ✅ Add to Cart:
  /// - إذا موجود: زيد الكمية
  /// - إذا مش موجود: ضيف جديد
  void addToCart({
    required String productId,
    required String title,
    required String subtitle,
    required String imageUrl,
    required double price,
  }) {
    final index = _items.indexWhere((e) => e.productId == productId);
    if (index != -1) {
      _items[index].quantity += 1;
    } else {
      _items.add(
        CartItem(
          productId: productId,
          title: title,
          subtitle: subtitle,
          imageUrl: imageUrl,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void increaseQty(String productId) {
    final index = _items.indexWhere((e) => e.productId == productId);
    if (index == -1) return;
    _items[index].quantity += 1;
    notifyListeners();
  }

  /// ✅ اختيارنا 2A: ما ننزل تحت 1
  void decreaseQty(String productId) {
    final index = _items.indexWhere((e) => e.productId == productId);
    if (index == -1) return;
    if (_items[index].quantity > 1) {
      _items[index].quantity -= 1;
      notifyListeners();
    }
  }

  void removeItem(String productId) {
    _items.removeWhere((e) => e.productId == productId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
