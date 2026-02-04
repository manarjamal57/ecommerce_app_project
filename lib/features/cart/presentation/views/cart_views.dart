import 'package:ecommerce_app_project/features/cart/presentation/cart_provider.dart';
import 'package:ecommerce_app_project/features/cart/presentation/views/checkout_screen.dart';
import 'package:ecommerce_app_project/features/home/presentation/views/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


// ✅ عدّلي المسار حسب مكان ملفك الحقيقي

class MyCartView extends StatelessWidget {
  const MyCartView({super.key});

  static const routeName = '/my-cart';

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  _CircleBtn(
                    icon: Icons.arrow_back,
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        MainLayout.routeName,
                        (route) => false,
                      );
                    },
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'My Cart',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                  ),
                  const Spacer(),
                  _CircleBtn(
                    icon: Icons.shopping_bag_outlined,
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Items list
              Expanded(
                child: cart.items.isEmpty
                    ? const Center(
                        child: Text(
                          'Your cart is empty',
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemCount: cart.items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final item = cart.items[index];
                          return _CartItemRow(
                            title: item.title,
                            subtitle: item.subtitle,
                            imageUrl: item.imageUrl,
                            price: item.price,
                            qty: item.quantity,
                            onMinus: () => cart.decreaseQty(item.productId),
                            onPlus: () => cart.increaseQty(item.productId),
                            onRemove: () => cart.removeItem(item.productId),
                          );
                        },
                      ),
              ),

              const SizedBox(height: 20),

              // Summary
              if (cart.items.isNotEmpty) _SummaryBox(cart: cart),

              const SizedBox(height: 50),

              // Button
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: cart.items.isEmpty
                      ? null
                      : () {
                          // ✅ Navigate to CheckoutScreen with real cart items
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CheckoutScreen(
                                items: cart.items
                                    .map(
                                      (e) => CartItemModel(
                                        productId: e.productId,
                                        name: e.title,
                                        subtitle: e.subtitle,
                                        imageUrl: e.imageUrl,
                                        price: e.price,
                                        qty: e.quantity,
                                      ),
                                    )
                                    .toList(),
                                // ✅ حالياً عنوان وهمي - لاحقاً بنجيبه من users
                                address: AddressModel(
                                  street: "3512 Pearl Street",
                                  city: "Nagercoil",
                                  state: "Tamil Nadu",
                                  phone: "8870523416",
                                  zip: "95814",
                                  countryCode: "+91",
                                  country: "India",
                                ),
                              ),
                            ),
                          );
                        },
                  child: const Text(
                    'Proceed to Checkout',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CartItemRow extends StatelessWidget {
  const _CartItemRow({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.price,
    required this.qty,
    required this.onMinus,
    required this.onPlus,
    required this.onRemove,
  });

  final String title;
  final String subtitle;
  final String imageUrl;
  final double price;
  final int qty;
  final VoidCallback onMinus;
  final VoidCallback onPlus;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Container(
              width: 65,
              height: 79,
              color: Colors.black12,
              child: imageUrl.isEmpty
                  ? const Icon(Icons.image_not_supported_outlined)
                  : Image.network(imageUrl, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),

          // Qty controls + remove
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: onRemove,
                icon: const Icon(Icons.delete_outline),
                splashRadius: 14,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                  color: Colors.black12.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _QtyBtn(icon: Icons.remove, onTap: onMinus),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Text(
                        '$qty',
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    _QtyBtn(icon: Icons.add, onTap: onPlus),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QtyBtn extends StatelessWidget {
  const _QtyBtn({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: onTap,
      child: SizedBox(
        width: 18,
        height: 12,
        child: Icon(icon, size: 14, color: Colors.black87),
      ),
    );
  }
}

class _SummaryBox extends StatelessWidget {
  const _SummaryBox({required this.cart});

  final CartProvider cart;

  @override
  Widget build(BuildContext context) {
    final itemsText = '(${cart.itemsCount} item)';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _sumRow('Subtotal:', '\$${cart.subtotal.toStringAsFixed(0)}'),
          const SizedBox(height: 12),
          _sumRow('Shipping:', '\$${cart.shipping.toStringAsFixed(0)}'),
          const SizedBox(height: 10),
          const Divider(height: 1),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                'BagTotal:',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.black54,
                ),
              ),
              const Spacer(),
              Text(
                itemsText,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.black45,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '\$${cart.total.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sumRow(String left, String right) {
    return Row(
      children: [
        Text(
          left,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.black54,
          ),
        ),
        const Spacer(),
        Text(
          right,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class _CircleBtn extends StatelessWidget {
  const _CircleBtn({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.black12.withOpacity(0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.black),
      ),
    );
  }
}
