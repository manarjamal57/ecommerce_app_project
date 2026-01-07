import 'package:ecommerce_app_project/core/utils/app_images.dart';
import 'package:ecommerce_app_project/features/auth/presentation/views/login_view.dart';
import 'package:ecommerce_app_project/features/auth/presentation/views/sign_up_view.dart';
import 'package:ecommerce_app_project/features/splash/presentation/widgets/custom_button.dart' show CustomButton;
import 'package:flutter/material.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

    static const String routeName = '/splash-screen';


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          // 1) الخلفية (الصورة)
          Positioned.fill(
            child: Image.asset(
      AppImages.splash, // غيّري الاسم حسب صورتك
              fit: BoxFit.cover,
            ),
          ),

          // 2) طبقة تعتيم خفيفة (اختياري)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.25),
            ),
          ),

          // 3) الأزرار تحت
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 50),
              child: Column(
             mainAxisSize: MainAxisSize.min,

           children: [
           CustomButton(
            textColor: Colors.black,
            color: Colors.white,
          text: 'Login',
             onTap: () {
        Navigator.pushNamed(context, LoginView.routeName);
      },
    ),
    const SizedBox(height: 16),
    CustomButton(
      color: Colors.transparent,
      textColor: Colors.white,

      text: 'Sign Up',
      onTap: () {
        Navigator.pushNamed(context, SignUpView.routeName);
      },
    ),
  ],
)

            ),
          ),
        ],
      ),
    );
  }
}
