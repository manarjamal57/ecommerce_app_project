

import 'package:ecommerce_app_project/features/profile/presentation/views/PrivacyPolicyView';
import 'package:ecommerce_app_project/features/profile/presentation/views/faqs_view.dart';
import 'package:ecommerce_app_project/features/profile/presentation/views/favorites_view.dart';
import 'package:ecommerce_app_project/features/profile/presentation/views/my_card_view.dart';
import 'package:ecommerce_app_project/features/profile/presentation/views/my_orders_view.dart';
import 'package:ecommerce_app_project/features/profile/presentation/views/personal_details_view.dart';
import 'package:ecommerce_app_project/features/profile/presentation/views/settings_view.dart';
import 'package:ecommerce_app_project/features/profile/presentation/views/shipping_address_view.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, SettingsView.routeName),
                    icon: const Icon(Icons.settings, color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // User Card
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black26),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 18,
                      offset: Offset(0, 10),
                      color: Color(0x14000000),
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 21,
                        backgroundColor: Colors.black,
                        child: Icon(Icons.person, color: Colors.white, size: 22),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Notice Name',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'yourmail@gmail.com',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              _MenuCard(
                children: [
                  _MenuItem(
                    icon: Icons.person_outline,
                    title: 'Personal Details',
                    onTap: () => Navigator.pushNamed(
                      context,
                      PersonalDetailsView.routeName,
                    ),
                  ),
                  _MenuItem(
                    icon: Icons.shopping_bag_outlined,
                    title: 'My Order',
                    onTap: () => Navigator.pushNamed(
                      context,
                      MyOrdersView.routeName,
                    ),
                  ),
                  _MenuItem(
                    icon: Icons.favorite_border,
                    title: 'My Favourites',
                    onTap: () => Navigator.pushNamed(
                      context,
                     FavouritesView.routeName,
                    ),
                  ),
                  _MenuItem(
                    icon: Icons.local_shipping_outlined,
                    title: 'Shipping Address',
                    onTap: () => Navigator.pushNamed(
                      context,
                      ShippingAddressView.routeName,
                    ),
                  ),
                  _MenuItem(
                    icon: Icons.credit_card,
                    title: 'My Card',
                    onTap: () => Navigator.pushNamed(
                      context,
                      MyCardsView.routeName,
                    ),
                  ),
                  _MenuItem(
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    onTap: () => Navigator.pushNamed(
                      context,
                      SettingsView.routeName,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              _MenuCard(
                children: [
                  _MenuItem(
                    icon: Icons.help_outline,
                    title: 'FAQs',
                    onTap: () => Navigator.pushNamed(
                      context,
                      FaqsView.routeName,
                    ),
                  ),
                  _MenuItem(
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privacy Policy',
                    onTap: () => Navigator.pushNamed(
                      context,
                     PrivacyPolicyView.routeName,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  const _MenuCard({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black26),
        boxShadow: const [
          BoxShadow(
            blurRadius: 18,
            offset: Offset(0, 10),
            color: Color(0x14000000),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F3F3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFF3F3F3), width: 0.8),
              ),
              child: Icon(icon, size: 20, color: const Color(0xFF111111)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111111),
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}
