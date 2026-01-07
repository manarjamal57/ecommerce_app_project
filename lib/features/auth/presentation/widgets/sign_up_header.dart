import 'package:flutter/material.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sign Up',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          'Create an new account',
          style: TextStyle(
            fontSize: 18, // ✅ أخف شوي من 20
            color: Colors.black.withOpacity(0.55),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}