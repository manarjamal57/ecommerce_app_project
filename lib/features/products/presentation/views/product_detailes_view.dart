import 'package:ecommerce_app_project/features/cart/presentation/views/cart_views.dart';
import 'package:ecommerce_app_project/features/products/presentation/views/reviews_view.dart';
import 'package:ecommerce_app_project/features/profile/presentation/views/favs_store.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/product_entity.dart';

// ✅ Cart Provider
import 'package:provider/provider.dart';
import 'package:ecommerce_app_project/features/cart/presentation/cart_provider.dart';

// ✅ FAVS STORE

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.product});

  final ProductEntity product;
  static const routeName = '/product-details';

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  late final PageController _pageController;

  int _active = 0;
  int _qty = 1;
  int _selectedSizeIndex = 0;

  // ✅ Color selection
  int _selectedColorIndex = 0;
  final List<Color> _colors = const [
    Color(0xFFE6E6E6), // light gray
    Color(0xFF111111), // black
    Color(0xFF6B6B6B), // gray
    Color(0xFFFFFFFF), // white
  ];

  List<String> get _images => [widget.product.image];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _selectedSizeIndex = widget.product.sizeOptions.isEmpty ? -1 : 0;
    _selectedColorIndex = _colors.isEmpty ? -1 : 0;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _inc() => setState(() => _qty++);
  void _dec() => setState(() => _qty = _qty > 1 ? _qty - 1 : 1);

  // ✅ NEW: يدعم URL (Supabase) و Asset
  Widget _buildImage(String path) {
    final isUrl = path.startsWith('http');

    if (isUrl) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        alignment: Alignment.center,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
        errorBuilder: (_, __, ___) => const Center(
          child: Icon(Icons.image_not_supported_outlined, size: 44),
        ),
      );
    }

    return Image.asset(
      path,
      fit: BoxFit.cover,
      alignment: Alignment.center,
      errorBuilder: (_, __, ___) => const Center(
        child: Icon(Icons.image_not_supported_outlined, size: 44),
      ),
    );
  }

  // ✅ Add to cart logic (supports qty + snackbar)
  void _addToCart(ProductEntity p) {
    final cart = context.read<CartProvider>();

    for (int i = 0; i < _qty; i++) {
      cart.addToCart(
        productId: p.id,
        title: p.title,
        subtitle: p.subtitle,
        imageUrl: p.image,
        price: p.price,
      );
    }

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added $_qty item(s) to cart ✅'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'View',
          onPressed: () => Navigator.pushNamed(context, MyCartView.routeName),
        ),
      ),
    );
  }

  // ===================== ✅ FAV HELPERS =====================

  Map<String, String> _favMap(ProductEntity p) => {
        'id': p.id,
        'title': p.title,
        'subtitle': p.subtitle,
        'price': '\$${p.price.toStringAsFixed(0)}',
        'image': p.image,
      };

  bool _isFav(ProductEntity p) {
    final current = favsNotifier.value;
    return current.any((e) => e['id'] == p.id);
  }

  void _toggleFav(ProductEntity p) {
    final current = List<Map<String, String>>.from(favsNotifier.value);
    final existsIndex = current.indexWhere((e) => e['id'] == p.id);

    if (existsIndex >= 0) {
      current.removeAt(existsIndex);
      favsNotifier.value = current;

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Removed from favourites 💔'),
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      current.add(_favMap(p));
      favsNotifier.value = current;

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Added to favourites ❤️'),
          duration: Duration(seconds: 1),
        ),
      );
    }

    // لتحديث شكل القلب فوراً داخل الصفحة
    setState(() {});
  }

  // ===========================================================

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    final sizes = p.sizeOptions;

    final screenH = MediaQuery.of(context).size.height;
    final topInset = MediaQuery.of(context).padding.top;

    final heroH = screenH * 0.60;
    final sheetTop = heroH - 55;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ======================
          // Hero Image
          // ======================
          Positioned.fill(
            child: Column(
              children: [
                SizedBox(
                  height: heroH,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        itemCount: _images.length,
                        onPageChanged: (i) => setState(() => _active = i),
                        itemBuilder: (_, i) {
                          return Container(
                            color: const Color(0xFFF5F5F5),
                            child: _buildImage(_images[i]),
                          );
                        },
                      ),

                      // 🔙 Back
                      Positioned(
                        top: topInset + 1,
                        left: 10,
                        child: _TopCircleButton(
                          icon: Icons.arrow_back_ios_new_rounded,
                          onTap: () => Navigator.pop(context),
                        ),
                      ),

                      // 👜 Right pill (open cart)
                      Positioned(
                        top: topInset + 1,
                        right: 10,
                        child: _TopPill(
                          children: [
                            _TopPillIcon(
                              icon: Icons.shopping_bag_outlined,
                              onTap: () => Navigator.pushNamed(
                                context,
                                MyCartView.routeName,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Dots
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 14,
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                              _images.length,
                              (i) => AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: const EdgeInsets.symmetric(horizontal: 3),
                                width: i == _active ? 18 : 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: i == _active
                                      ? Colors.black
                                      : Colors.white70,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // ❤️ Favorite (✅ UPDATED)
                      Positioned(
                        right: 10,
                        bottom: 70,
                        child: Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          elevation: 6,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(24),
                            onTap: () => _toggleFav(p),
                            child: SizedBox(
                              width: 35,
                              height: 35,
                              child: Center(
                                child: Icon(
                                  _isFav(p)
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_border_rounded,
                                  size: 18,
                                  color: _isFav(p) ? Colors.red : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: Container(color: Colors.white)),
              ],
            ),
          ),

          // ======================
          // Bottom Sheet
          // ======================
          Positioned(
            top: sheetTop,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 30,
                    offset: Offset(0, -10),
                    color: Color(0x14000000),
                  )
                ],
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title + Qty
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  p.title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              _QtySelector(
                                qty: _qty,
                                onMinus: _dec,
                                onPlus: _inc,
                              ),
                            ],
                          ),

                          if (p.subtitle.trim().isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Text(
                              p.subtitle,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],

                          const SizedBox(height: 10),

                          // Rating + stock
                          Row(
                            children: [
                              _StarRow(rating: p.rating),
                              const SizedBox(width: 8),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const ReviewsView(),
                                    ),
                                  );
                                },
                                child: Text(
                                  '(${(p.rating * 60).round()} Review)',
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                'Available in stock',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          // ✅ Size + Color dots
                          if (sizes.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            const Text(
                              'Size',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 10),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: List.generate(sizes.length, (i) {
                                      final selected = i == _selectedSizeIndex;
                                      return GestureDetector(
                                        onTap: () => setState(() => _selectedSizeIndex = i),
                                        child: Container(
                                          width: 35,
                                          height: 35,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: selected ? Colors.black : Colors.transparent,
                                            borderRadius: BorderRadius.circular(999),
                                            border: Border.all(
                                              color: selected ? Colors.black : const Color(0xFFE6E6E6),
                                            ),
                                          ),
                                          child: Text(
                                            sizes[i],
                                            style: TextStyle(
                                              color: selected ? Colors.white : Colors.black54,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Wrap(
                                  spacing: 15,
                                  runSpacing: 15,
                                  children: List.generate(_colors.length, (i) {
                                    final selected = i == _selectedColorIndex;
                                    final c = _colors[i];

                                    return GestureDetector(
                                      onTap: () => setState(() => _selectedColorIndex = i),
                                      child: Container(
                                        width: 25,
                                        height: 25,
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: selected ? Colors.black : const Color(0xFFE6E6E6),
                                            width: selected ? 2 : 1,
                                          ),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: c,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: c == Colors.white ? const Color(0xFFE6E6E6) : Colors.transparent,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ],

                          const SizedBox(height: 14),

                          const Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            p.description,
                            style: const TextStyle(
                              height: 1.20,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Bar
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Container(
                      height: 60,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Text(
                            '\$${(p.price * _qty).toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            height: 40,
                            child: ElevatedButton.icon(
                              onPressed: () => _addToCart(p),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                              ),
                              icon: const Icon(
                                Icons.shopping_bag_outlined,
                                color: Colors.black,
                                size: 18,
                              ),
                              label: const Text(
                                'Add to cart',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===================== Helpers =====================

class _TopCircleButton extends StatelessWidget {
  const _TopCircleButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      shape: const CircleBorder(),
      elevation: 6,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 30,
          height: 30,
          child: Center(
            child: Icon(icon, color: Colors.white, size: 17),
          ),
        ),
      ),
    );
  }
}

class _TopPill extends StatelessWidget {
  const _TopPill({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(999),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}

class _TopPillIcon extends StatelessWidget {
  const _TopPillIcon({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: SizedBox(
        width: 30,
        height: 30,
        child: Center(
          child: Icon(
            icon,
            size: 15,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class _QtySelector extends StatelessWidget {
  const _QtySelector({required this.qty, required this.onMinus, required this.onPlus});
  final int qty;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onMinus,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Icon(Icons.remove, size: 16),
            ),
          ),
          const SizedBox(width: 6),
          Text('$qty', style: const TextStyle(fontWeight: FontWeight.w900)),
          const SizedBox(width: 6),
          InkWell(
            onTap: onPlus,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Icon(Icons.add, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class _StarRow extends StatelessWidget {
  const _StarRow({required this.rating});
  final double rating;

  @override
  Widget build(BuildContext context) {
    final full = rating.floor().clamp(0, 5);
    final hasHalf = (rating - full) >= 0.5 && full < 5;

    return Row(
      children: List.generate(5, (i) {
        if (i < full) {
          return const Icon(Icons.star_rounded, size: 16, color: Color(0xFFFFB800));
        }
        if (i == full && hasHalf) {
          return const Icon(Icons.star_half_rounded, size: 16, color: Color(0xFFFFB800));
        }
        return const Icon(Icons.star_border_rounded, size: 16, color: Color(0xFFFFB800));
      }),
    );
  }
}
