import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../constants.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});
  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  final notifications = [
    {'type': 'urgent', 'title': 'Urgent Blood Needed', 'desc': 'O+ blood needed at Jinnah Hospital', 'time': '10 min ago', 'unread': true},
    {'type': 'confirmed', 'title': 'Donation Confirmed', 'desc': 'Your appointment on Dec 15 is confirmed', 'time': '2 hours ago', 'unread': true},
    {'type': 'nearby', 'title': 'New Donor Nearby', 'desc': 'Ayesha Khan (2.4 km) is willing to donate', 'time': '5 hours ago', 'unread': false},
    {'type': 'eligible', 'title': 'You are Eligible to Donate', 'desc': 'You can donate blood again starting today', 'time': '1 day ago', 'unread': false},
    {'type': 'appreciation', 'title': 'Lives Saved Badge 🏆', 'desc': 'You have saved 3 lives! Keep it up.', 'time': '2 days ago', 'unread': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(AppBorderRadius.xl),
              bottomRight: Radius.circular(AppBorderRadius.xl),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Alerts', style: AppTextStyles.heading2.copyWith(color: Colors.white)),
                  Text('Stay updated', style: AppTextStyles.body2.copyWith(color: Colors.white70)),
                ],
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    for (final n in notifications) {
                      n['unread'] = false;
                    }
                  });
                },
                child: Text('Mark all read', style: AppTextStyles.body2.copyWith(color: Colors.white)),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            itemCount: notifications.length,
            itemBuilder: (context, idx) {
              final n = notifications[idx];
              return FadeInLeft(
                delay: Duration(milliseconds: 80 * idx),
                duration: const Duration(milliseconds: 400),
                child: _NotificationCard(notification: n),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final Map<String, dynamic> notification;
  const _NotificationCard({required this.notification});

  IconData get _icon {
    switch (notification['type']) {
      case 'urgent': return Icons.warning_rounded;
      case 'confirmed': return Icons.check_circle_rounded;
      case 'nearby': return Icons.location_on_rounded;
      case 'appreciation': return Icons.emoji_events_rounded;
      default: return Icons.favorite_rounded;
    }
  }

  Color get _color {
    switch (notification['type']) {
      case 'urgent': return AppColors.error;
      case 'confirmed': return AppColors.success;
      case 'nearby': return const Color(0xFF1976D2);
      case 'appreciation': return const Color(0xFF7B1FA2);
      default: return AppColors.warning;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUnread = notification['unread'] as bool;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isUnread ? _color.withAlpha(12) : Colors.white,
        borderRadius: BorderRadius.circular(AppBorderRadius.lg),
        border: Border.all(
          color: isUnread ? _color.withAlpha(60) : AppColors.borderColor,
        ),
        boxShadow: AppShadows.card,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: _color.withAlpha(25),
            shape: BoxShape.circle,
          ),
          child: Icon(_icon, color: _color, size: 22),
        ),
        title: Text(
          notification['title'] as String,
          style: AppTextStyles.subtitle2.copyWith(
            fontWeight: isUnread ? FontWeight.w700 : FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(notification['desc'] as String, style: AppTextStyles.caption),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(notification['time'] as String, style: AppTextStyles.caption),
            if (isUnread) ...[
              const SizedBox(height: 4),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: _color, shape: BoxShape.circle),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
