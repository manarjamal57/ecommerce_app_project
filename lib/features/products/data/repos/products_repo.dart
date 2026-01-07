import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:ecommerce_app_project/core/utils/product_sizes.dart';
import 'package:ecommerce_app_project/features/products/domain/entities/product_entity.dart';

class ProductsRepo {
  final FirebaseFirestore _db;
  ProductsRepo({FirebaseFirestore? db}) : _db = db ?? FirebaseFirestore.instance;

  String _s(dynamic v) => (v ?? '').toString();

  String _categoryFrom(Map<String, dynamic> data) {
    return _s(data['categoryName'] ?? data['category'] ?? data['catName']);
  }

  ProductEntity _mapDocToProduct(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();

    final categoryName = _categoryFrom(data);
    final type = sizeTypeFromCategory(categoryName);

    return ProductEntity(
      id: doc.id,
      categoryName: categoryName,
      title: _s(data['name'] ?? data['title']),
      subtitle: _s(data['subtitle']),
      image: _s(data['imageUrl'] ?? data['image']),
      price: (data['price'] ?? 0).toDouble(),
      description: _s(data['description']),
      rating: (data['rating'] ?? 4.5).toDouble(),
      sizeType: type,
      sizeOptions: defaultSizesFor(type),
    );
  }

  Stream<List<ProductEntity>> streamAllProducts() {
    return _db.collection('products').snapshots().map((snap) {
      final list = snap.docs.map(_mapDocToProduct).toList();

      if (kDebugMode) {
        debugPrint("✅ total products=${list.length}");
      }
      return list;
    });
  }

  Stream<List<ProductEntity>> streamFeaturedProducts() {
    return _db
        .collection('products')
        .where('isFeatured', isEqualTo: true)
        .snapshots()
        .map((snap) {
      return snap.docs.map(_mapDocToProduct).toList();
    });
  }

  Stream<List<ProductEntity>> streamByCategory(String categoryTitle) {
    final key = categoryTitle.trim().toLowerCase();
    return streamAllProducts().map((list) {
      final filtered = list.where((p) {
        final c = p.categoryName.trim().toLowerCase();
        return c == key;
      }).toList();

      if (kDebugMode) {
        debugPrint("🎯 filter key='$key' matched=${filtered.length}");
      }
      return filtered;
    });
  }

  /// ✅ منتجات الهوم المختارة (بدون index)
  /// - يعتمد على showOnHome=true
  /// - يرتب محليًا حسب homeOrder
  /// - يأخذ أول 2
  Stream<List<ProductEntity>> streamHomeProducts() {
    return _db
        .collection('products')
        .where('showOnHome', isEqualTo: true)
        .limit(20) // جيبي عدد أكبر شوي ثم رتّبي وخدي 2
        .snapshots()
        .map((snap) {
      final docs = snap.docs.toList();

      // ✅ ترتيب محلي حسب homeOrder (بدون orderBy لتفادي index)
      docs.sort((a, b) {
        final ao = (a.data()['homeOrder'] ?? 0) as num;
        final bo = (b.data()['homeOrder'] ?? 0) as num;
        return ao.compareTo(bo);
      });

      final topTwo = docs.take(4).map(_mapDocToProduct).toList();
      return topTwo;
    });
  }
}
