import 'package:flutter/material.dart' hide TextField;

import 'package:ecommerce_app_project/features/auth/presentation/views/success_view.dart';
import 'package:ecommerce_app_project/features/auth/presentation/widgets/text_filed.dart';
import 'package:ecommerce_app_project/features/auth/presentation/widgets/fashions.dart';
import 'package:ecommerce_app_project/features/auth/presentation/widgets/label.dart';
import 'package:ecommerce_app_project/features/auth/presentation/widgets/primary_button.dart';
import 'package:ecommerce_app_project/features/auth/presentation/widgets/sign_up_header.dart';
import 'package:ecommerce_app_project/features/auth/presentation/widgets/terms_check_box_row.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app_project/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // ✅ form key + autovalidate (مكانهم الصحيح)
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

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
    if (!agree) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to the terms first.')),
      );
      return;
    }

    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) {
      setState(() => autovalidateMode = AutovalidateMode.onUserInteraction);
      return;
    }

    // ✅ مؤقتاً: نجاح مباشرة (بعدها بنبدلها Firebase)
    Navigator.pushReplacementNamed(context, SuccessView.routeName);
  }

  @override
Widget build(BuildContext context) {
  return BlocConsumer<SignupCubit, SignupState>(
    listener: (context, state) {
      if (state is SignupSuccess) {
        Navigator.pushReplacementNamed(context, SuccessView.routeName);
      } else if (state is SignupFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message)),
        );
      }
    },
    builder: (context, state) {
      final isLoading = state is SignupLoading;

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
              const SizedBox(height: 80),
              const SignUpHeader(),
              const SizedBox(height: 60),

              const Label(text: 'User Name'),
              TextFromField(
                controller: usernameController,
                validator: (v) {
                  final value = v?.trim() ?? '';
                  if (value.isEmpty) return 'Username is required';
                  if (value.length < 3) return 'Min 3 characters';
                  return null;
                },
                suffixIcon: Icon(
                  Icons.check_circle,
                  size: 20,
                  color: Colors.black.withOpacity(0.75),
                ),
              ),
              const SizedBox(height: 18),
const Label(text: 'Email'),
TextFromField(
  controller: emailController,
  keyboardType: TextInputType.emailAddress,
  validator: (v) {
  final value = v?.trim() ?? '';
  if (value.isEmpty) return 'Email is required';

  final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]{2,}$');
  if (!emailRegex.hasMatch(value)) return 'Enter a valid email';

  return null;
},

),

              const SizedBox(height: 18),

              const Label(text: 'Password'),
              TextFromField(
                controller: passwordController,
                obscureText: !showPassword,
                validator: (v) {
                  final value = v ?? '';
                  if (value.isEmpty) return 'Password is required';
                  if (value.length < 6) return 'Min 6 characters';
                  return null;
                },
                suffixIcon: Icon(
                  showPassword ? Icons.visibility_off : Icons.visibility,
                  size: 20,
                  color: Colors.black.withOpacity(0.75),
                ),
                onSuffixTap: () => setState(() => showPassword = !showPassword),
              ),
              const SizedBox(height: 18),

              const Label(text: 'Confirm Password'),
              TextFromField(
                controller: confirmPasswordController,
                obscureText: !showConfirmPassword,
                validator: (v) {
                  final value = v ?? '';
                  if (value.isEmpty) return 'Confirm password is required';
                  if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                suffixIcon: Icon(
                  showConfirmPassword ? Icons.visibility_off : Icons.visibility,
                  size: 20,
                  color: Colors.black.withOpacity(0.75),
                ),
                onSuffixTap: () => setState(
                  () => showConfirmPassword = !showConfirmPassword,
                ),
              ),

              const SizedBox(height: 14),

              TermsCheckboxRow(
                value: agree,
                onChanged: (v) => setState(() => agree = v ?? false),
              ),

              const SizedBox(height: 20),

              PrimaryButton(
                text: isLoading ? 'Loading...' : 'Sign Up',
                enabled: agree && !isLoading,
                onPressed: () {
                  print('SIGN UP BUTTON CLICKED');
                  if (!agree || isLoading) return;

                  final isValid = formKey.currentState?.validate() ?? false;
                  if (!isValid) {
                    setState(() => autovalidateMode =
                        AutovalidateMode.onUserInteraction);
                    return;
                  }

                  context.read<SignupCubit>().createUserWithEmailAndPassword(
                        emailController.text.trim(),
                        passwordController.text,
                        usernameController.text.trim(),
                      );
                },
              ),

              const SizedBox(height: 24),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ],
          ),
        ),
      );
    },
  );
}

}
