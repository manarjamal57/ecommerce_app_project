import 'package:ecommerce_app_project/core/utils/app_images.dart';
import 'package:flutter/material.dart';

class SplashBodyView extends StatelessWidget {
  const SplashBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
     AppImages.logo,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );

  }
}