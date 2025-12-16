import 'package:ecommerce_app_project/features/on_boarding/presentation/widgets/onboarding_bottom_bar.dart';
import 'package:flutter/material.dart';

import '../../../splash/presentation/views/splash_screen_view.dart';
import '../../data/onboarding_data.dart';
import '../widgets/on_boarding_page.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  static const String routeName = '/onboarding';

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _controller = PageController();
  int _index = 0;

  bool _didPrecache = false;

  bool get _isLast => _index == onBoardingList.length - 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_didPrecache) return;

    for (final item in onBoardingList) {
      precacheImage(AssetImage(item.image), context);
    }

    _didPrecache = true;
  }

  void _next() {
    if (!_isLast) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return;
    }
    Navigator.pushReplacementNamed(context, SplashScreenView.routeName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: onBoardingList.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (context, i) =>
                OnBoardingPage(item: onBoardingList[i]),
          ),
          OnboardingBottomBar(
            controller: _controller,
            count: onBoardingList.length,
            onNext: _next,
          ),
        ],
      ),
    );
  }
}
