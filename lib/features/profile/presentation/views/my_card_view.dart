import 'package:flutter/material.dart';

class MyCardsView extends StatefulWidget {
  const MyCardsView({super.key});

  static const routeName = "/payment";

  @override
  State<MyCardsView> createState() => _MyCardViewState();
}

class _MyCardViewState extends State<MyCardsView> {
  String _selected = "visa"; // credit_card / paypal / visa / gpay

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Payment",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.black),
              ),
              const SizedBox(height: 14),

              _PaymentOptionTile(
                title: "Credit Card",
                leading: _BrandCircle(
                  child: Icon(Icons.credit_card, size: 18, color: Colors.orange.shade700),
                ),
                value: "credit_card",
                groupValue: _selected,
                onChanged: (v) => setState(() => _selected = v),
              ),
              const SizedBox(height: 10),

              _PaymentOptionTile(
                title: "Paypal",
                leading: _BrandCircle(
                  child: const Text("P", style: TextStyle(fontWeight: FontWeight.w900)),
                ),
                value: "paypal",
                groupValue: _selected,
                onChanged: (v) => setState(() => _selected = v),
              ),
              const SizedBox(height: 10),

              _PaymentOptionTile(
                title: "Visa",
                leading: _VisaBadge(),
                value: "visa",
                groupValue: _selected,
                onChanged: (v) => setState(() => _selected = v),
                // بالفيجما الخيار المختار بيصير أسود
                selectedBg: Colors.black,
                selectedText: Colors.white,
                selectedRadio: Colors.white,
                unselectedRadio: Colors.black,
              ),
              const SizedBox(height: 10),

              _PaymentOptionTile(
                title: "Google Pay",
                leading: _BrandCircle(
                  child: const Text("G", style: TextStyle(fontWeight: FontWeight.w900)),
                ),
                value: "gpay",
                groupValue: _selected,
                onChanged: (v) => setState(() => _selected = v),
              ),

              const SizedBox(height: 12),

              _AddCardButton(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Add Card (demo)")),
                  );
                },
              ),

              const SizedBox(height: 18),

              const Text(
                "History",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black),
              ),
              const SizedBox(height: 10),

              Expanded(
                child: ListView(
                  children: const [
                    _HistoryTile(
                      title: "Roller Rabbit",
                      subtitle: "Vado Odelle Dress",
                      price: 198.00,
                      imageEmoji: "👕",
                    ),
                    SizedBox(height: 10),
                    _HistoryTile(
                      title: "Axel Arigato",
                      subtitle: "Clean 90 Triole Sneakers",
                      price: 245.00,
                      imageEmoji: "👟",
                    ),
                    SizedBox(height: 10),
                    _HistoryTile(
                      title: "Herschel Supply Co.",
                      subtitle: "Daypack Backpack",
                      price: 40.00,
                      imageEmoji: "🎒",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaymentOptionTile extends StatelessWidget {
  final Widget leading;
  final String title;

  final String value;
  final String groupValue;
  final ValueChanged<String> onChanged;

  final Color selectedBg;
  final Color selectedText;
  final Color selectedRadio;
  final Color unselectedRadio;

  const _PaymentOptionTile({
    required this.leading,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.selectedBg = Colors.white,
    this.selectedText = Colors.black,
    this.selectedRadio = Colors.black,
    this.unselectedRadio = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;

    return InkWell(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? selectedBg : Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            leading,
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: isSelected ? selectedText : Colors.black,
                ),
              ),
            ),
            _RadioDot(
              selected: isSelected,
              color: isSelected ? selectedRadio : unselectedRadio,
            ),
          ],
        ),
      ),
    );
  }
}

class _RadioDot extends StatelessWidget {
  final bool selected;
  final Color color;

  const _RadioDot({required this.selected, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 1.6),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected ? color : Colors.transparent,
        ),
      ),
    );
  }
}

class _BrandCircle extends StatelessWidget {
  final Widget child;
  const _BrandCircle({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: DefaultTextStyle(
        style: const TextStyle(color: Colors.black, fontSize: 16),
        child: child,
      ),
    );
  }
}

class _VisaBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEDEDED)),
      ),
      child: const Text(
        "VISA",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
      ),
    );
  }
}

class _AddCardButton extends StatelessWidget {
  final VoidCallback onTap;
  const _AddCardButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFDADADA), width: 1.2),
        ),
        child: CustomPaint(
          painter: _DashedBorderPainter(radius: 18, dashWidth: 8, dashSpace: 6),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F1F1),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Icon(Icons.add, size: 18),
                ),
                const SizedBox(width: 10),
                const Text(
                  "Add Card",
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final double price;
  final String imageEmoji;

  const _HistoryTile({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imageEmoji,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
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
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F1F1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(imageEmoji, style: const TextStyle(fontSize: 22)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F1F1),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Text("Send", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text("\$${price.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}

/// Dashed border painter (بدون packages)
class _DashedBorderPainter extends CustomPainter {
  final double radius;
  final double dashWidth;
  final double dashSpace;

  _DashedBorderPainter({
    required this.radius,
    required this.dashWidth,
    required this.dashSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFDADADA)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics().toList();

    for (final metric in metrics) {
      double distance = 0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        canvas.drawPath(metric.extractPath(distance, next), paint);
        distance = next + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
