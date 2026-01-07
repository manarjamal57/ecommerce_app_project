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
  static const TextStyle semiBold16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static const TextStyle regular13 = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
   static const TextStyle bold16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  // ===== Buttons =====
  static const TextStyle button = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
   static const TextStyle card= TextStyle(
    fontSize: 19,
   
    fontWeight: FontWeight.bold,
  );
   static const TextStyle subtitle= TextStyle(
    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Colors.black54,
  );
    static const TextStyle price= TextStyle(
      fontWeight: FontWeight.bold,
            fontSize: 16,
  );


  

}
