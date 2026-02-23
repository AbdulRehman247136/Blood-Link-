import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../constants.dart';

class CommunityFeedScreen extends StatelessWidget {
  const CommunityFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stories = [
      {
        'name': 'Fatima Ahmed',
        'time': '2h ago',
        'story': 'Thanks to the donors of the BloodLink+ community, my father successfully underwent surgery. Every drop truly counts!',
        'likes': '124',
        'tags': ['Emergency', 'Success'],
        'color': Colors.blue,
      },
      {
        'name': 'City General Hospital',
        'time': '5h ago',
        'story': 'We are currently facing a shortage of O- blood. Heartfelt thanks to the 3 legendary donors who responded today!',
        'likes': '89',
        'tags': ['Hero Needed'],
        'color': AppColors.primary,
      },
      {
        'name': 'Zain Malik',
        'time': '1d ago',
        'story': 'Just completed my 10th donation! Feeling proud to be part of this lifesaver community.',
        'likes': '256',
        'tags': ['Achievement'],
        'color': Colors.amber,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Community', style: AppTextStyles.heading2),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.05)),
                    ),
                    child: const Icon(Icons.notifications_outlined, color: Colors.white70, size: 20),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Post something
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(color: Colors.white10, shape: BoxShape.circle),
                      child: const Icon(Icons.person, color: Colors.white38, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Text('Share your impact story...', style: AppTextStyles.body2.copyWith(color: Colors.white24)),
                    const Spacer(),
                    const Icon(Icons.image_outlined, color: Colors.white24, size: 20),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Feed
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: stories.length,
                itemBuilder: (context, i) {
                  final s = stories[i];
                  return FadeInUp(
                    delay: Duration(milliseconds: 100 * i),
                    child: _CommunityPost(
                      name: s['name'] as String,
                      time: s['time'] as String,
                      content: s['story'] as String,
                      likes: s['likes'] as String,
                      tags: s['tags'] as List<String>,
                      accentColor: s['color'] as Color,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CommunityPost extends StatelessWidget {
  final String name, time, content, likes;
  final List<String> tags;
  final Color accentColor;

  const _CommunityPost({
    required this.name,
    required this.time,
    required this.content,
    required this.likes,
    required this.tags,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: accentColor.withAlpha(20),
                  shape: BoxShape.circle,
                ),
                child: Center(child: Text(name[0], style: TextStyle(color: accentColor, fontWeight: FontWeight.bold))),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: AppTextStyles.subtitle2),
                  Text(time, style: AppTextStyles.caption.copyWith(color: Colors.white24)),
                ],
              ),
              const Spacer(),
              const Icon(Icons.more_horiz, color: Colors.white24),
            ],
          ),
          const SizedBox(height: 16),
          Text(content, style: AppTextStyles.body2.copyWith(color: Colors.white70, height: 1.5)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: tags.map((t) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: accentColor.withAlpha(15),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: accentColor.withOpacity(0.1)),
              ),
              child: Text(t, style: AppTextStyles.caption.copyWith(color: accentColor, fontSize: 10, fontWeight: FontWeight.bold)),
            )).toList(),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(Icons.favorite, color: AppColors.primary, size: 18),
              const SizedBox(width: 6),
              Text(likes, style: AppTextStyles.caption.copyWith(color: Colors.white54)),
              const Spacer(),
              const Icon(Icons.share_outlined, color: Colors.white24, size: 18),
              const SizedBox(width: 20),
              const Icon(Icons.chat_bubble_outline_rounded, color: Colors.white24, size: 18),
            ],
          ),
        ],
      ),
    );
  }
}
