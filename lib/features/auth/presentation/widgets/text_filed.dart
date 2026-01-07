import 'package:flutter/material.dart';

class TextFromField extends StatelessWidget {
  const TextFromField({
    super.key,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.onSuffixTap,
    this.validator,
    this.keyboardType,
    this.textInputAction,
  });

  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixTap;

  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),

        border: const UnderlineInputBorder(),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.08)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.18)),
        ),
        suffixIcon: suffixIcon == null
            ? null
            : InkWell(
                onTap: onSuffixTap,
                borderRadius: BorderRadius.circular(30),
                child: Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: suffixIcon!,
                ),
              ),
        suffixIconConstraints:
            const BoxConstraints(minWidth: 32, minHeight: 20),
      ),
    );
  }
}
