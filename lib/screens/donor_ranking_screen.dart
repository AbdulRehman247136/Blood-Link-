import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../constants.dart';

class DonorRankingScreen extends StatelessWidget {
  const DonorRankingScreen({super.key});

  static const _donors = [
    _Donor(rank: 1, name: 'Ayesha Khan', bloodType: 'O-', donations: 42),
    _Donor(rank: 2, name: 'Hassan Ali', bloodType: 'A+', donations: 36),
    _Donor(rank: 3, name: 'Noor Fatima', bloodType: 'B+', donations: 33),
    _Donor(rank: 4, name: 'Bilal Ahmed', bloodType: 'AB+', donations: 28),
    _Donor(rank: 5, name: 'Sana Javed', bloodType: 'O+', donations: 24),
    _Donor(rank: 6, name: 'Usman Tariq', bloodType: 'A-', donations: 21),
    _Donor(rank: 7, name: 'Zara Noor', bloodType: 'B-', donations: 18),
    _Donor(rank: 8, name: 'Hamza Lodhi', bloodType: 'AB-', donations: 15),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Donor Ranking')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
        children: [
          Text('Top Donors', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 4),
          Text(
            'Recognizing Life Savers',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          ..._donors.asMap().entries.map(
            (entry) => _StaggeredItem(
              index: entry.key,
              child: _DonorCard(donor: entry.value),
            ),
          ),
        ],
      ),
    );
  }
}

class _StaggeredItem extends StatefulWidget {
  final int index;
  final Widget child;

  const _StaggeredItem({required this.index, required this.child});

  @override
  State<_StaggeredItem> createState() => _StaggeredItemState();
}

class _StaggeredItemState extends State<_StaggeredItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 420),
      vsync: this,
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    Future.delayed(Duration(milliseconds: 70 * widget.index), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}

class _DonorCard extends StatelessWidget {
  final _Donor donor;

  const _DonorCard({required this.donor});

  Color _medalColor(int rank) {
    if (rank == 1) return const Color(0xFFFFD700);
    if (rank == 2) return const Color(0xFFC0C0C0);
    if (rank == 3) return const Color(0xFFCD7F32);
    return AppColors.primary;
  }

  IconData _badgeIcon(int rank) {
    if (rank <= 3) return Icons.workspace_premium_rounded;
    return Icons.verified_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final topThree = donor.rank <= 3;
    final medal = _medalColor(donor.rank);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: topThree
              ? medal.withValues(alpha: 0.8)
              : Theme.of(context).dividerColor,
          width: topThree ? 1.6 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: topThree
                ? medal.withValues(alpha: isDark ? 0.35 : 0.2)
                : Colors.black.withValues(alpha: isDark ? 0.2 : 0.08),
            blurRadius: topThree ? 16 : 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        minVerticalPadding: 12,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 28,
              child: Text(
                '#${donor.rank}',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(width: 8),
            _AnimatedAvatar(
              radius: topThree ? 24 : 20,
              color: medal,
              label: donor.name.substring(0, 1),
            ),
          ],
        ),
        title: Text(
          donor.name,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          '${donor.bloodType} • ${donor.donations} donations',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: Icon(_badgeIcon(donor.rank), color: medal),
      ),
    );
  }
}

class _AnimatedAvatar extends StatefulWidget {
  final double radius;
  final Color color;
  final String label;

  const _AnimatedAvatar({
    required this.radius,
    required this.color,
    required this.label,
  });

  @override
  State<_AnimatedAvatar> createState() => _AnimatedAvatarState();
}

class _AnimatedAvatarState extends State<_AnimatedAvatar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final y = math.sin(_controller.value * math.pi) * 2;
        return Transform.translate(offset: Offset(0, -y), child: child);
      },
      child: CircleAvatar(
        radius: widget.radius,
        backgroundColor: widget.color.withValues(alpha: 0.2),
        child: CircleAvatar(
          radius: widget.radius - 2,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          child: Text(
            widget.label,
            style: TextStyle(
              color: widget.color,
              fontWeight: FontWeight.w700,
              fontSize: widget.radius * 0.7,
            ),
          ),
        ),
      ),
    );
  }
}

class _Donor {
  final int rank;
  final String name;
  final String bloodType;
  final int donations;

  const _Donor({
    required this.rank,
    required this.name,
    required this.bloodType,
    required this.donations,
  });
}
