import 'package:ecommerce_app_project/features/alerts/presentation/views/notifications_view.dart';
import 'package:ecommerce_app_project/features/cart/presentation/views/cart_views.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_app_project/features/home/presentation/views/main_layout.dart';

import 'package:ecommerce_app_project/features/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app_project/features/products/domain/entities/product_entity.dart';

import 'package:ecommerce_app_project/features/home/presentation/views/home_view.dart';
import 'package:ecommerce_app_project/features/products/presentation/views/category_products_view.dart';
import 'package:ecommerce_app_project/features/products/presentation/views/featured_products_view.dart';
import 'package:ecommerce_app_project/features/products/presentation/views/product_detailes_view.dart';
import 'package:ecommerce_app_project/features/products/presentation/views/reviews_view.dart';

import 'package:ecommerce_app_project/features/splash/presentation/views/splash_view.dart';
import 'package:ecommerce_app_project/features/splash/presentation/views/splash_screen_view.dart';
import 'package:ecommerce_app_project/features/on_boarding/presentation/views/on_boarding_view.dart';

import 'package:ecommerce_app_project/features/auth/presentation/views/login_view.dart';
import 'package:ecommerce_app_project/features/auth/presentation/views/sign_up_view.dart';
import 'package:ecommerce_app_project/features/auth/presentation/views/success_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (_) => const SplashView());

    case SplashScreenView.routeName:
      return MaterialPageRoute(builder: (_) => const SplashScreenView());

    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (_) => const OnBoardingView());

    case LoginView.routeName:
      return MaterialPageRoute(builder: (_) => const LoginView());

    case SignUpView.routeName:
      return MaterialPageRoute(builder: (_) => const SignUpView());

    case SuccessView.routeName:
      return MaterialPageRoute(builder: (_) => const SuccessView());

    // ✅ هذا هو “البيت” تبع الشريط السفلي
    case MainLayout.routeName:
      return MaterialPageRoute(builder: (_) => const MainLayout());

    // ✅ أي نداء للهوم لازم يروح للـ MainLayout عشان الشريط يضل ظاهر
    case HomeView.routeName:
      return MaterialPageRoute(builder: (_) => const MainLayout());

    // صفحات تفتح فوق الشريط (تفاصيل فقط)
    case ReviewsView.routeName:
      return MaterialPageRoute(builder: (_) => const ReviewsView());

    case FeaturedProductsView.routeName:
      return MaterialPageRoute(builder: (_) => const FeaturedProductsView());

    case ProductDetailsView.routeName: {
      final args = settings.arguments;
      if (args is! ProductEntity) {
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Product argument missing')),
          ),
        );
      }
      return MaterialPageRoute(
        builder: (_) => ProductDetailsView(product: args),
      );
    }

    case CategoryProductsView.routeName: {
      final args = settings.arguments;
      if (args is! CategoryEntity) {
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Category argument missing')),
          ),
        );
      }
      return MaterialPageRoute(
        builder: (_) => CategoryProductsView(category: args),
      );
    }
    case MyCartView.routeName:
  return MaterialPageRoute(builder: (_) => const MyCartView());
  case NotificationsView.routeName:
  return MaterialPageRoute(builder: (_) => const NotificationsView());

    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(child: Text('Route not found')),
        ),
      );
  }
}
