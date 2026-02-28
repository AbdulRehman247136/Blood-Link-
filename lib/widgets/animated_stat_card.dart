import 'package:flutter/material.dart';

import '../constants.dart';

class AnimatedStatCard extends StatelessWidget {
  final int targetValue;
  final String label;
  final IconData icon;
  final LinearGradient gradient;

  const AnimatedStatCard({
    super.key,
    required this.targetValue,
    required this.label,
    required this.icon,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(AppBorderRadius.lg),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white70, size: 22),
          const SizedBox(height: 8),
          TweenAnimationBuilder<int>(
            tween: IntTween(begin: 0, end: targetValue),
            duration: const Duration(milliseconds: 1400),
            builder: (_, value, child) => Text(
              value >= 1000
                  ? '${(value / 1000).toStringAsFixed(1)}K'
                  : '$value',
              style: AppTextStyles.heading3.copyWith(fontSize: 20),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
