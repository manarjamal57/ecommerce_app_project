import 'package:ecommerce_app_project/core/services/get_it_services.dart';
import 'package:ecommerce_app_project/features/auth/domain/repos/auth_repo.dart';
import 'package:ecommerce_app_project/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app_project/features/auth/presentation/widgets/sign_up_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  static const String routeName = '/sign-up';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(
       getIt<AuthRepo> ()
      ),
      child: const Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SafeArea(child: SignUpBody()),
      ),
    );
  }
}
