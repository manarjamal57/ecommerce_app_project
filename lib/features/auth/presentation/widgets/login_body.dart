import 'package:ecommerce_app_project/features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:ecommerce_app_project/features/auth/presentation/cubits/login_cubit/login_state.dart';
import 'package:ecommerce_app_project/features/home/presentation/views/home_view.dart';
import 'package:ecommerce_app_project/features/home/presentation/views/main_layout.dart';
import 'package:flutter/material.dart' hide TextField;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce_app_project/features/auth/presentation/widgets/text_filed.dart';
import 'package:ecommerce_app_project/features/auth/presentation/widgets/label.dart';
import 'package:ecommerce_app_project/features/auth/presentation/widgets/primary_button.dart';
import 'package:ecommerce_app_project/features/auth/presentation/widgets/fashions.dart';
import 'package:ecommerce_app_project/features/auth/presentation/widgets/social_button.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  bool showPassword = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) {
      setState(() => autovalidateMode = AutovalidateMode.onUserInteraction);
      return;
    }

    context.read<LoginCubit>().signIn(
          emailController.text.trim(),
          passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushReplacementNamed(context, MainLayout.routeName);
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is LoginLoading;

        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Form(
            key: formKey,
            autovalidateMode: autovalidateMode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    color: Colors.black.withOpacity(0.55),
                  ),
                ),

                const SizedBox(height: 60),

                const Label(text: 'Email'),
                TextFromField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    final value = v?.trim() ?? '';
                    if (value.isEmpty) return 'Email is required';

                    final emailRegex =
                        RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]{2,}$');
                    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';

                    return null;
                  },
                ),

                const SizedBox(height: 24),

                const Label(text: 'Password'),
                TextFromField(
                  controller: passwordController,
                  obscureText: !showPassword,
                  textInputAction: TextInputAction.done,
                  validator: (v) {
                    final value = v ?? '';
                    if (value.isEmpty) return 'Password is required';
                    if (value.length < 6) return 'Min 6 characters';
                    return null;
                  },
                  suffixIcon: Icon(
                    showPassword ? Icons.visibility_off : Icons.visibility,
                    size: 20,
                  ),
                  onSuffixTap: () =>
                      setState(() => showPassword = !showPassword),
                ),

                const SizedBox(height: 32),

                PrimaryButton(
                  text: isLoading ? 'Loading...' : 'Login',
                  enabled: !isLoading,
                  onPressed: isLoading ? null : _login,
                ),

                const SizedBox(height: 18),
                Center(
                  child: Text(
                    'or',
                    style: TextStyle(color: Colors.black.withOpacity(0.55)),
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
              onTap: () {
          context.read<LoginCubit>().signInWithGoogle();
     },
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

                SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
              ],
            ),
          ),
        );
      },
    );
  }
}
