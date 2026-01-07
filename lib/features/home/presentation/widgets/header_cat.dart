import 'package:flutter/material.dart';

class HeaderCat extends StatelessWidget {
  const HeaderCat({required this.onBack});
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CircleButton(
          filled: true,
          icon: Icons.arrow_back_ios_new_rounded,
          onTap: onBack,
        ),
        const Spacer(),
        _CircleButton(
          filled: false,
          icon: Icons.search_rounded,
          onTap: () {},
        ),
      ],
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({
    required this.filled,
    required this.icon,
    required this.onTap,
  });

  final bool filled;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: filled ? Colors.black : Colors.transparent,
          shape: BoxShape.circle,
          border:
              filled ? null : Border.all(color: Colors.black.withOpacity(0.12)),
        ),
        child: Icon(
          icon,
          size: 18,
          color: filled ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
