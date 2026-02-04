import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTrackingScreen extends StatelessWidget {
  final String orderId;
  const OrderTrackingScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final stream = FirebaseFirestore.instance.collection("orders").doc(orderId).snapshots();

    return Scaffold(
      appBar: AppBar(title: const Text("Order Tracking")),
      body: StreamBuilder<DocumentSnapshot>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Center(child: Text("Something went wrong"));
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final status = (data["status"] ?? "accepted") as String;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Order ID: $orderId", style: const TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 10),
                Text("Status: $status", style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 18),

                // عرض المنتجات بسرعة
                const Text("Items", style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView(
                    children: (data["items"] as List).map((it) {
                      return ListTile(
                        title: Text(it["name"]),
                        subtitle: Text("Qty: ${it["qty"]}  •  \$${it["price"]}"),
                        trailing: Text("\$${(it["lineTotal"] as num).toStringAsFixed(2)}"),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
