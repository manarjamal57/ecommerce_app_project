class NotificationItem {
  final String avatarUrl;
  final String name;
  final String message;
  final String timeText;
  final bool isUnread;

  const NotificationItem({
    required this.avatarUrl,
    required this.name,
    required this.message,
    required this.timeText,
    required this.isUnread,
  });
}

const List<NotificationItem> dummyNotifications = [
  NotificationItem(
    avatarUrl: 'https://i.pravatar.cc/150?img=12',
    name: 'Kristine Jones',
    message:
        'It is a long established fact that a reader will be distracted by the readable content of a page.',
    timeText: '2 hours ago',
    isUnread: true,
  ),
  NotificationItem(
    avatarUrl: 'https://i.pravatar.cc/150?img=32',
    name: 'Kay Hicks',
    message:
        'There are many variations of passages of Lorem Ipsum available.',
    timeText: '2 hours ago',
    isUnread: false,
  ),
  NotificationItem(
    avatarUrl: 'https://i.pravatar.cc/150?img=47',
    name: 'Cheryl Moretti',
    message:
        'If you are going to use a passage of Lorem Ipsum, you need to be sure there isn’t anything embarrassing.',
    timeText: '6 hours ago',
    isUnread: true,
  ),
  NotificationItem(
    avatarUrl: 'https://i.pravatar.cc/150?img=13',
    name: 'Kristine Jones',
    message:
        'It is a long established fact that a reader will be distracted by the readable content of a page.',
    timeText: '1 day ago',
    isUnread: false,
  ),
  NotificationItem(
    avatarUrl: 'https://i.pravatar.cc/150?img=41',
    name: 'Kay Hicks',
    message:
        'There are many variations of passages of Lorem Ipsum available.',
    timeText: '2 days ago',
    isUnread: false,
  ),
  NotificationItem(
    avatarUrl: 'https://i.pravatar.cc/150?img=56',
    name: 'Cheryl Moretti',
    message:
        'If you are going to use a passage of Lorem Ipsum, you need to be sure there isn’t anything embarrassing.',
    timeText: '6 days ago',
    isUnread: false,
  ),
];
