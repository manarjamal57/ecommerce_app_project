import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app_project/core/services/get_it_services.dart';
import 'package:ecommerce_app_project/features/auth/domain/repos/auth_repo.dart';
import 'package:ecommerce_app_project/features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:ecommerce_app_project/features/auth/presentation/widgets/login_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(
        getIt<AuthRepo>()),
      child: const Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SafeArea(child: LoginBody()),
      ),
    );
  }
}
