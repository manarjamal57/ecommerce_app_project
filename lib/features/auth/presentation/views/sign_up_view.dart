import 'package:ecommerce_app_project/features/auth/presentation/widgets/terms_check_box_row.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_app_project/features/auth/presentation/views/success_view.dart';
import 'package:ecommerce_app_project/features/auth/presentation/widgets/auth_filed.dart';
import 'package:ecommerce_app_project/features/auth/presentation/widgets/fashions.dart';
import 'package:ecommerce_app_project/features/auth/presentation/widgets/label.dart';
import 'package:ecommerce_app_project/features/auth/presentation/widgets/primary_button.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  static const String routeName = '/sign-up';

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final usernameController = TextEditingController(); // ✅ فاضي
  final emailController = TextEditingController(); // ✅ فاضي
  final passwordController = TextEditingController(); // ✅ فاضي
  final confirmPasswordController = TextEditingController(); // ✅ فاضي

  bool agree = false;
  bool showPassword = false;
  bool showConfirmPassword = false;

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    // TODO: Firebase Sign Up لاحقاً
    Navigator.pushNamed(context, SuccessView.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            const Fashions(),

            const SizedBox(height: 80), // ✅ بدل 80

            const _SignUpHeader(),

            const SizedBox(height: 60), // ✅ بدل 60

            const Label(text: 'User Name'),
            AuthField(
              controller: usernameController,
              suffixIcon: Icon(
                Icons.check_circle,
                size: 20,
                color: Colors.black.withOpacity(0.75),
              ),
            ),

            const SizedBox(height: 18),

            const Label(text: 'Email'),
            AuthField(controller: emailController),

            const SizedBox(height: 18),

            const Label(text: 'Password'),
            AuthField(
              controller: passwordController,
              obscureText: !showPassword,
              suffixIcon: Icon(
                showPassword ? Icons.visibility_off : Icons.visibility,
                size: 20,
                color: Colors.black.withOpacity(0.75),
              ),
              onSuffixTap: () => setState(() => showPassword = !showPassword),
            ),

            const SizedBox(height: 18),

            const Label(text: 'Confirm Password'),
            AuthField(
              controller: confirmPasswordController,
              obscureText: !showConfirmPassword,
              suffixIcon: Icon(
                showConfirmPassword ? Icons.visibility_off : Icons.visibility,
                size: 20,
                color: Colors.black.withOpacity(0.75),
              ),
              onSuffixTap: () =>
                  setState(() => showConfirmPassword = !showConfirmPassword),
            ),

            const SizedBox(height: 14),

            TermsCheckboxRow(
              value: agree,
              onChanged: (v) => setState(() => agree = v ?? false),
            ),

            const SizedBox(height: 20),

            PrimaryButton(
              text: 'Login', // إذا بدك نخليها Sign Up قولي
              enabled: agree,
              onPressed:(){
                Navigator.pushReplacementNamed(context, SuccessView.routeName);

              }
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _SignUpHeader extends StatelessWidget {
  const _SignUpHeader();

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


