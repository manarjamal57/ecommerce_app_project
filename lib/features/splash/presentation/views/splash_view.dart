import 'dart:async';

import 'package:ecommerce_app_project/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:ecommerce_app_project/features/splash/presentation/widgets/splash_body_view.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

   static const String routeName = '/splash';


  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
 void initState() {
    super.initState();
    executeNavigation();
  }

void executeNavigation() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, OnBoardingView.routeName);
    });
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashBodyView(),
    );
  }
}
