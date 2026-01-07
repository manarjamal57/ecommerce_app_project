import 'package:ecommerce_app_project/features/alerts/presentation/views/notifications_view.dart';
import 'package:ecommerce_app_project/features/cart/presentation/views/cart_views.dart';
import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

// بدّلي الاستيرادات حسب أسماء ملفاتك
import 'home_view.dart';

import '../../../profile/presentation/views/profile_view.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});
  static const routeName = '/main-layout'; // ✅ أضيفي هذا

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const HomeView(),     // 0 Home
      const MyCartView(),     // 1 Cart
      const NotificationsView(),   // 2 Alerts (اعمليها مؤقتة لو مش موجودة)
      const ProfileView(),  // 3 Profile
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[currentIndex], // ✅ هون تبديل الصفحات
      bottomNavigationBar: BottomNav(
        currentIndex: currentIndex,
        onChanged: (i) => setState(() => currentIndex = i),
      ),
    );
  }
}
