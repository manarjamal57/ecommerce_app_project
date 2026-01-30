import 'package:flutter/material.dart';
import 'add_card_view.dart';

class MyCardsView extends StatefulWidget {
  const MyCardsView({super.key});
  static const routeName = '/my-cards';

  @override
  State<MyCardsView> createState() => _MyCardsViewState();
}

class _MyCardsViewState extends State<MyCardsView> {
  final List<Map<String, String>> cards = [
    {'brand': 'VISA', 'last4': '4242', 'exp': '12/28'},
    {'brand': 'MasterCard', 'last4': '1111', 'exp': '09/27'},
  ];

  Future<void> _addCard() async {
    final result = await Navigator.pushNamed(context, AddCardView.routeName);
    if (result is Map<String, String>) {
      setState(() => cards.add(result));
    }
  }

  Widget _cardTile(Map<String, String> c) {
    return Container(
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
              border: Border.all(color: const Color(0xFF111111), width: 0.8),
            ),
            child: const Icon(Icons.credit_card, color: Color(0xFF111111)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${c['brand']} •••• ${c['last4']}',
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 4),
                Text(
                  'Exp: ${c['exp']}',
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => setState(() => cards.remove(c)),
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('My Card'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _addCard,
            child: const Text('Add',
                style: TextStyle(fontWeight: FontWeight.w900)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: ListView(
          children: [
            ...cards.map(_cardTile),
            const SizedBox(height: 8),
            const Text(
              'Tip: This is UI dummy data now. Later we will store cards securely.',
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
