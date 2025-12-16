import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.text,
    required this.bgColor,
    required this.textColor,
    required this.icon,
    required this.onTap,
    this.bordered = false,
  });

  final String text;
  final Color bgColor;
  final Color textColor;
  final IconData icon;
  final VoidCallback onTap;
  final bool bordered;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: textColor,
          side: bordered
              ? BorderSide(color: Colors.black.withAlpha(31)) // ~12%
              : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ✅ الأيقونة أنعم ومقاسها صح
            Icon(
              icon,
              size: 24,
              color: textColor,
            ),

            const SizedBox(width: 12),

            // ✅ النص متوازن مع الأيقونة
            Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
