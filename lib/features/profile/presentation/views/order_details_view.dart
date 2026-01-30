import 'package:flutter/material.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key});
  static const routeName = '/order-details';

  @override
  Widget build(BuildContext context) {
    final args = (ModalRoute.of(context)?.settings.arguments as Map?) ?? {};
    final id = (args['id'] ?? '#----').toString();
    final status = (args['status'] ?? 'Transit').toString();

    final steps = [
      {'title': 'Order Placed', 'done': true},
      {'title': 'Processing', 'done': true},
      {'title': 'In Transit', 'done': status != 'Delivered' ? true : true},
      {'title': 'Delivered', 'done': status == 'Delivered'},
    ];

    Widget card(Widget child) => Container(
          padding: const EdgeInsets.all(14),
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
          child: child,
        );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Order Details'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            card(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(id,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 6),
                  Text('Status: $status',
                      style: const TextStyle(color: Colors.black54)),
                ],
              ),
            ),
            const SizedBox(height: 14),
            card(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tracking',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 12),
                  ...steps.map((s) => _StepRow(
                        title: s['title'] as String,
                        done: s['done'] as bool,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  const _StepRow({required this.title, required this.done});
  final String title;
  final bool done;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: done ? Colors.black : const Color(0xFFF3F3F3),
              border: Border.all(color: const Color(0xFF111111), width: 1),
            ),
            child: Icon(
              done ? Icons.check : Icons.circle,
              size: 14,
              color: done ? Colors.white : const Color(0xFF111111),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: done ? Colors.black : Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
