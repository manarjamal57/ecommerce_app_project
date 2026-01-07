
import 'package:ecommerce_app_project/features/home/presentation/widgets/bottom_nav_item.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({required this.currentIndex, required this.onChanged});

  final int currentIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 24,
            offset: Offset(0, -10),
            color: Color(0x12000000),
          )
        ],
      ),
      child:Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    BottomNavItem(
      icon: Icons.home_rounded,
      label: 'Home',
      isActive: currentIndex == 0,
      onTap: () => onChanged(0),
    ),
    BottomNavItem(
      icon: Icons.shopping_bag_outlined,
      label: 'Cart',
      isActive: currentIndex == 1,
      onTap: () => onChanged(1),
    ),
    BottomNavItem(
      icon: Icons.notifications_none_rounded,
      label: 'Notifications',
      isActive: currentIndex == 2,
      onTap: () => onChanged(2),
    ),
    BottomNavItem(
      icon: Icons.person_outline_rounded,
      label: 'Profile',
      isActive: currentIndex == 3,
      onTap: () => onChanged(3),
    ),
  ],
)

    );
  }
}

