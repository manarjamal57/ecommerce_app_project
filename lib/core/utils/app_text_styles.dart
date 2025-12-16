import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class AppTextStyles {
  // ===== Onboarding =====
  static const TextStyle onboardingTitle = TextStyle(
    color: AppColors.black,
    fontSize: 35,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle onboardingSubtitle = TextStyle(
    fontSize: 20,
    height: 1.4,
    color: AppColors.grey600,
    fontWeight: FontWeight.w400,
  );

  // ===== Buttons =====
  static const TextStyle button = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
}
