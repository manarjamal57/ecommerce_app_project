import 'package:ecommerce_app_project/features/alerts/data/dummy/dummy_notifications.dart';
import 'package:flutter/material.dart';


class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  static const routeName = '/notifications';

  @override
  Widget build(BuildContext context) {
    final items = dummyNotifications;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header (Back + menu)
              Row(
                children: [
                  _CircleIconBtn(
                    icon: Icons.arrow_back,
                    onTap: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  _CircleIconBtn(
                    icon: Icons.more_vert,
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),

              const Text(
                'Notification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: items.isEmpty
                    ? const Center(
                        child: Text(
                          'No notifications yet',
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const Divider(height: 24),
                        itemBuilder: (context, index) {
                          final n = items[index];
                          return _NotificationTile(
                            avatarUrl: n.avatarUrl,
                            name: n.name,
                            message: n.message,
                            timeText: n.timeText,
                            isUnread: n.isUnread,
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===================== Widgets =====================

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({
    required this.avatarUrl,
    required this.name,
    required this.message,
    required this.timeText,
    required this.isUnread,
  });

  final String avatarUrl;
  final String name;
  final String message;
  final String timeText;
  final bool isUnread;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: Container(
            width: 50,
            height: 50,
            color: Colors.black12,
            child: avatarUrl.isEmpty
                ? const Icon(Icons.person, color: Colors.black54)
                : Image.network(avatarUrl, fit: BoxFit.cover),
          ),
        ),

        const SizedBox(width: 15),

        // Text
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: isUnread ? FontWeight.w900 : FontWeight.w800,
                      ),
                    ),
                  ),
                  if (isUnread)
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.only(left: 8, top: 2),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                message,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                timeText,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black38,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CircleIconBtn extends StatelessWidget {
  const _CircleIconBtn({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.black12.withOpacity(0.10),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.black),
      ),
    );
  }
}
