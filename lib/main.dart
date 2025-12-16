import 'package:ecommerce_app_project/core/helper_functions/on_generate_routes.dart';
import 'package:ecommerce_app_project/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const EcommerceAppProject());
}

class EcommerceAppProject extends StatelessWidget {
  const EcommerceAppProject({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    onGenerateRoute: onGenerateRoute,
      initialRoute: SplashView.routeName,
    );
  }
}