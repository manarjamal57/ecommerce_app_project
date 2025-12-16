

import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingBottomBar extends StatelessWidget {
  const OnboardingBottomBar({
    required this.controller,
    required this.count,
    required this.onNext,
  });

  final PageController controller;
  final int count;
  final VoidCallback onNext;

  // ثوابت بدل أرقام مبعثرة
  static const double _leftRightPadding = 24;
  static const double _bottomPadding = 30;

  static const double _dotSize = 6;
  static const double _dotSpacing = 8;
  static const int _expansionFactor = 3;

  static const double _buttonSize = 52;
  static const double _iconScale = 0.9;
  static const double _iconSize = 30;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _leftRightPadding,
      right: _leftRightPadding,
      bottom: _bottomPadding,
      child: Row(
        children: [
          SmoothPageIndicator(
            controller: controller,
            count: count,
            effect: ExpandingDotsEffect(
              dotHeight: _dotSize,
              dotWidth: _dotSize,
              expansionFactor: _expansionFactor.toDouble(),
              spacing: _dotSpacing,
              activeDotColor: Colors.black,
              dotColor: Colors.grey,
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: onNext,
            borderRadius: BorderRadius.circular(999),
            child: Container(
              width: _buttonSize,
              height: _buttonSize,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Transform.scale(
                  scale: _iconScale,
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: _iconSize,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}