import 'package:ecommerce_app_project/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_app_project/features/splash/presentation/views/splash_view.dart';
import 'package:ecommerce_app_project/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:ecommerce_app_project/features/splash/presentation/views/splash_screen_view.dart';
import 'package:ecommerce_app_project/features/auth/presentation/views/login_view.dart';
import 'package:ecommerce_app_project/features/auth/presentation/views/sign_up_view.dart';
import 'package:ecommerce_app_project/features/auth/presentation/views/success_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (_) => const SplashView());

    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (_) => const OnBoardingView());

    case SplashScreenView.routeName:
      return MaterialPageRoute(builder: (_) => const SplashScreenView());

    case LoginView.routeName:
      return MaterialPageRoute(builder: (_) => const LoginView());

    // ✅ جديد
    case SignUpView.routeName:
      return MaterialPageRoute(builder: (_) => const SignUpView());

    // ✅ جديد
    case SuccessView.routeName:
      return MaterialPageRoute(builder: (_) => const SuccessView());
       case HomeView.routeName:
      return MaterialPageRoute(builder: (_) => const HomeView());

    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(child: Text('Route not found')),
        ),
      );
  }
}
