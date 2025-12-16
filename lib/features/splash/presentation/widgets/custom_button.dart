import 'package:ecommerce_app_project/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap, required this.color, required this.textColor,
  });

  final String text;
  final VoidCallback onTap;
  final Color color;
  final Color textColor;

 
  @override
@override
Widget build(BuildContext context) {
  return Material(
    color: Colors.transparent, // مهم
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: 55,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors.white,
            width: 1.5,
          ),
        ),
        child: Text( text,
  style: AppTextStyles.button.copyWith(
    color: textColor,
  ),
),

      ),
    ),
  );
}

  }

