
import 'package:ecommerce_app_project/features/cart/presentation/views/order_tracking_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// -------------------- كودك الأساسي --------------------

class CartItemModel {
  final String productId;
  final String name;
  final String subtitle;
  final String imageUrl;
  final double price;
  final int qty;

  CartItemModel({
    required this.productId,
    required this.name,
    required this.subtitle,
    required this.imageUrl,
    required this.price,
    required this.qty,
  });
}

class AddressModel {
  final String street;
  final String city;
  final String state;
  final String phone;
  final String zip;
  final String countryCode;
  final String country;

  AddressModel({
    required this.street,
    required this.city,
    required this.state,
    required this.phone,
    required this.zip,
    required this.countryCode,
    required this.country,
  });
}

class CheckoutScreen extends StatefulWidget {
  final List<CartItemModel> items;
  final AddressModel address;

  const CheckoutScreen({
    super.key,
    required this.items,
    required this.address,
  });

  static const routeName = '/checkout';

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? _promoCode;
  double _discount = 0.0;
  bool _isPlacingOrder = false;

  double get _subTotal {
    double sum = 0;
    for (final i in widget.items) {
      sum += i.price * i.qty;
    }
    return sum;
  }

  double get _total => (_subTotal - _discount).clamp(0, double.infinity);

  void _openPromoBottomSheet() async {
    final controller = TextEditingController(text: _promoCode ?? "");

    final result = await showModalBottomSheet<String?>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        final bottom = MediaQuery.of(ctx).viewInsets.bottom;
        return Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: bottom + 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Add Promo Code", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Enter code (مثال: NASSER10)",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx, null),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(ctx, controller.text.trim()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text("Apply", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );

    if (result == null) return;

    setState(() {
      _promoCode = result.isEmpty ? null : result;

      if (_promoCode != null && _promoCode!.toUpperCase() == "NASSER10") {
        _discount = 10.0;
      } else {
        _discount = 0.0;
      }
    });
  }

  // ✅ 1) دالة إنشاء الطلب على Firestore (مضافة)
  Future<String> createOrderInFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User not logged in (FirebaseAuth currentUser is null)");
    }

    final a = widget.address;

    final itemsMap = widget.items.map((i) {
      return {
        "productId": i.productId,
        "name": i.name,
        "subtitle": i.subtitle,
        "imageUrl": i.imageUrl,
        "price": i.price,
        "qty": i.qty,
        "lineTotal": i.price * i.qty,
      };
    }).toList();

    final orderData = {
      "userId": user.uid,
      "status": "accepted",
      "createdAt": FieldValue.serverTimestamp(),
      "updatedAt": FieldValue.serverTimestamp(),
      "promoCode": _promoCode,
      "discount": _discount,
      "subTotal": _subTotal,
      "total": _total,
      "address": {
        "street": a.street,
        "city": a.city,
        "state": a.state,
        "phone": a.phone,
        "zip": a.zip,
        "countryCode": a.countryCode,
        "country": a.country,
      },
      "items": itemsMap,
     "timeline": [
  {
    "status": "accepted",
    "title": "Accepted",
    "at": Timestamp.now(),
  }
],

    };

    final docRef = await FirebaseFirestore.instance.collection("orders").add(orderData);
    return docRef.id;
  }

  // ✅ 2) _placeOrder معدلة بالكامل (مضافة)
  Future<void> _placeOrder() async {
    if (widget.items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Your cart is empty")),
      );
      return;
    }

    setState(() => _isPlacingOrder = true);

    try {
      final orderId = await createOrderInFirestore();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Order created successfully!")),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OrderTrackingScreen(orderId: orderId),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      if (mounted) setState(() => _isPlacingOrder = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final a = widget.address;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Checkout", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Delivery Address", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 10),
                    _CardContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _kv("Street", a.street),
                          _kv("City", a.city),
                          _kv("State/province/area", a.state),
                          _kv("Phone number", a.phone),
                          _kv("Zip code", a.zip),
                          _kv("Country calling code", a.countryCode),
                          _kv("Country", a.country),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    const Text("Product Item", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 10),

                    Column(
                      children: widget.items
                          .map((item) => Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: _ProductRow(item: item),
                              ))
                          .toList(),
                    ),

                    const SizedBox(height: 18),
                    const Text("Promo Code", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 10),

                    InkWell(
                      onTap: _openPromoBottomSheet,
                      borderRadius: BorderRadius.circular(18),
                      child: _CardContainer(
                        child: Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Icon(Icons.percent, color: Colors.white),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Add Promo Code", style: TextStyle(fontWeight: FontWeight.w700)),
                                  const SizedBox(height: 2),
                                  Text(
                                    _promoCode == null ? "Tap to enter code" : _promoCode!,
                                    style: TextStyle(
                                      color: _promoCode == null ? Colors.black54 : Colors.black87,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.chevron_right),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            _BottomCheckoutBar(
              total: _total,
              isLoading: _isPlacingOrder,
              onPlaceOrder: _placeOrder,
            ),
          ],
        ),
      ),
    );
  }

  Widget _kv(String k, String v) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black87, fontSize: 13, height: 1.25),
          children: [
            TextSpan(text: "$k: ", style: const TextStyle(fontWeight: FontWeight.w700)),
            TextSpan(text: v),
          ],
        ),
      ),
    );
  }
}

class _CardContainer extends StatelessWidget {
  final Widget child;
  const _CardContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _ProductRow extends StatelessWidget {
  final CartItemModel item;
  const _ProductRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return _CardContainer(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Container(
              width: 54,
              height: 54,
              color: const Color(0xFFF1F1F1),
              child: item.imageUrl.startsWith("http")
                  ? Image.network(item.imageUrl, fit: BoxFit.cover)
                  : Image.asset(item.imageUrl, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: const TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 2),
                Text(
                  item.subtitle,
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text("\$${item.price.toStringAsFixed(2)}  ×  ${item.qty}",
                    style: const TextStyle(fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text("\$${(item.price * item.qty).toStringAsFixed(2)}",
              style: const TextStyle(fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

class _BottomCheckoutBar extends StatelessWidget {
  final double total;
  final bool isLoading;
  final VoidCallback onPlaceOrder;

  const _BottomCheckoutBar({
    required this.total,
    required this.isLoading,
    required this.onPlaceOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 18,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Total Price", style: TextStyle(color: Colors.black54, fontSize: 12)),
                  const SizedBox(height: 2),
                  Text("\$${total.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                ],
              ),
            ),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: isLoading ? null : onPlaceOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Text("Place Order", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
