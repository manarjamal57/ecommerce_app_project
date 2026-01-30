import 'package:flutter/material.dart';
import 'order_details_view.dart';

class MyOrdersView extends StatelessWidget {
  const MyOrdersView({super.key});
  static const routeName = '/my-orders';

  @override
  Widget build(BuildContext context) {
    final orders = [
      {
        'id': '#1024',
        'date': 'Jan 7, 2026',
        'total': '\$245.00',
        'status': 'Delivered',
      },
      {
        'id': '#1025',
        'date': 'Jan 8, 2026',
        'total': '\$198.00',
        'status': 'Transit',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('My Order'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, i) {
            final o = orders[i];
            return InkWell(
              onTap: () => Navigator.pushNamed(
                context,
                OrderDetailsView.routeName,
                arguments: o,
              ),
              child: Container(
                padding: const EdgeInsets.all(14),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFEDEDED)),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 18,
                      offset: Offset(0, 10),
                      color: Color(0x14000000),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F3F3),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: const Color(0xFF111111), width: 0.8),
                      ),
                      child: const Icon(Icons.shopping_bag_outlined,
                          color: Color(0xFF111111)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            o['id']!,
                            style: const TextStyle(fontWeight: FontWeight.w900),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${o['date']} • ${o['total']}',
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      o['status']!,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: (o['status'] == 'Delivered')
                            ? Colors.green
                            : Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.chevron_right, color: Colors.black54),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
