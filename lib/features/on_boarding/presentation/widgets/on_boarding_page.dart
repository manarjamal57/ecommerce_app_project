import 'package:ecommerce_app_project/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import '../../data/onboarding_model.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key, required this.item});

  final OnBoardingModel item;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final dpr = MediaQuery.devicePixelRatioOf(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),

          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            clipBehavior: Clip.hardEdge,
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: Image.asset(
                item.image,
                fit: BoxFit.cover,
                width: double.infinity,

                // ⭐ أهم سطرين لحل الغباش
                cacheWidth: (size.width * dpr).round(),
                cacheHeight: ((size.width * dpr) * (4 / 3)).round(),

                filterQuality: FilterQuality.high,
                gaplessPlayback: true,
              ),
            ),
          ),

          const SizedBox(height: 24),

          Text(
            item.title,
            style:AppTextStyles.onboardingTitle,
          ),

          const SizedBox(height: 12),

          Text(
            item.subtitle,
            style: AppTextStyles.onboardingSubtitle,
          ),
        ],
      ),
    );
  }
}
