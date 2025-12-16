import 'package:ecommerce_app_project/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_app_project/features/auth/presentation/widgets/auth_filed.dart';
import 'package:ecommerce_app_project/features/auth/presentation/widgets/label.dart';
import 'package:ecommerce_app_project/features/auth/presentation/widgets/primary_button.dart';
import 'package:ecommerce_app_project/features/auth/presentation/widgets/fashions.dart';
import 'package:ecommerce_app_project/features/auth/presentation/widgets/social_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static const String routeName = '/login';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool showPassword = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            const Fashions(),
            const SizedBox(height: 50),

            const Text(
              'Welcome!',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              'please login or sign up to continue our app',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black.withValues(alpha: 0.55),
              ),
            ),

            const SizedBox(height: 60),

            const Label(text: 'Email'),
            AuthField(controller: emailController),

            const SizedBox(height: 24),

            const Label(text: 'Password'),
            AuthField(
              controller: passwordController,
              obscureText: !showPassword,
              suffixIcon: Icon(
                showPassword ? Icons.visibility_off : Icons.visibility,
                size: 20,
              ),
              onSuffixTap: () => setState(() => showPassword = !showPassword),
            ),

            const SizedBox(height: 32),

            // ✅ Navigator مباشر بدون دالة
            PrimaryButton(
              text: 'Login',
              onPressed: () {
                Navigator.pushReplacementNamed(context, HomeView.routeName);
              },
            ),

            const SizedBox(height: 18),

            Center(
              child: Text(
                'or',
                style: TextStyle(color: Colors.black.withValues(alpha: 0.55)),
              ),
            ),

            const SizedBox(height: 20),

            SocialButton(
              text: 'Continue with Facebook',
              icon: Icons.facebook,
              bgColor: const Color(0xFF3B5998),
              textColor: Colors.white,
              onTap: () {},
            ),
            const SizedBox(height: 20),

            SocialButton(
              text: 'Continue with Google',
              icon: Icons.g_mobiledata,
              bgColor: Colors.white,
              textColor: Colors.black87,
              bordered: true,
              onTap: () {},
            ),
            const SizedBox(height: 20),

            SocialButton(
              text: 'Continue with Apple',
              icon: Icons.apple,
              bgColor: Colors.white,
              textColor: Colors.black87,
              bordered: true,
              onTap: () {},
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
