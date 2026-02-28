import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../constants.dart';
import 'donate_screen.dart';
import 'find_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Header(),
              const SizedBox(height: 18),
              const _RedFluidBanner(),
              const SizedBox(height: 24),
              const _SearchBar(),
              const SizedBox(height: 24),
              const _EmergencyToggle(),
              const SizedBox(height: 24),
              const _AdminStats(),
              const SizedBox(height: 32),
              const _SectionHeader(title: 'Urgent Requests', count: 12),
              const SizedBox(height: 16),
              const _UrgentRequestsList(),
              const SizedBox(height: 32),
              const _ImpactSection(),
              const SizedBox(height: 32),
              const _CommunityStories(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final greeting = 'Welcome';
    final bloodType = 'O+';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white10),
                ),
                child: const Center(
                  child: Icon(Icons.person, color: Colors.white70),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$greeting,',
                    style: AppTextStyles.body2.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text('Blood Bank!', style: AppTextStyles.subtitle1),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.primary.withAlpha(50)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.water_drop,
                  color: AppColors.primary,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  bloodType,
                  style: AppTextStyles.subtitle2.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RedFluidBanner extends StatefulWidget {
  const _RedFluidBanner();

  @override
  State<_RedFluidBanner> createState() => _RedFluidBannerState();
}

class _RedFluidBannerState extends State<_RedFluidBanner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1850),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        height: 165,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.24)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.18),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: _RedFluidPainter(progress: _controller.value),
                    );
                  },
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withValues(alpha: 0.08),
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.14),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                right: 16,
                top: 16,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.18),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.water_drop_rounded,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Blood Flow Monitor',
                        style: AppTextStyles.subtitle1,
                      ),
                    ),
                    Text(
                      'Active',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Text(
                  'Emergency blood stream visualization',
                  style: AppTextStyles.body2.copyWith(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RedFluidPainter extends CustomPainter {
  final double progress;

  _RedFluidPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final basePaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.30)
      ..style = PaintingStyle.fill;

    final midPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.48)
      ..style = PaintingStyle.fill;

    final topPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.74)
      ..style = PaintingStyle.fill;

    _drawWave(
      canvas,
      size,
      paint: basePaint,
      level: size.height * 0.70,
      amplitude: 12,
      speed: 1.3,
      phase: progress * math.pi * 2,
    );

    _drawWave(
      canvas,
      size,
      paint: midPaint,
      level: size.height * 0.61,
      amplitude: 13,
      speed: 1.8,
      phase: progress * math.pi * 2.5,
    );

    _drawWave(
      canvas,
      size,
      paint: topPaint,
      level: size.height * 0.53,
      amplitude: 15,
      speed: 2.2,
      phase: progress * math.pi * 3,
    );
  }

  void _drawWave(
    Canvas canvas,
    Size size, {
    required Paint paint,
    required double level,
    required double amplitude,
    required double speed,
    required double phase,
  }) {
    final path = Path()..moveTo(0, size.height);

    for (double x = 0; x <= size.width; x++) {
      final y =
          level +
          amplitude * math.sin((x / size.width * 2 * math.pi * speed) + phase);
      path.lineTo(x, y);
    }

    path
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _RedFluidPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _AdminStats extends StatelessWidget {
  const _AdminStats();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Admin Statistics', style: AppTextStyles.heading3),
          const SizedBox(height: 16),
          Row(
            children: [
              _StatItem(
                label: 'Total Donors',
                value: '1,420',
                icon: Icons.people_rounded,
              ),
              const SizedBox(width: 12),
              _StatItem(
                label: 'Requests',
                value: '48',
                icon: Icons.bloodtype_rounded,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label, value;
  final IconData icon;
  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.primary, size: 24),
            const SizedBox(height: 12),
            Text(value, style: AppTextStyles.heading2),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(color: Colors.white38),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmergencyToggle extends StatefulWidget {
  const _EmergencyToggle();

  @override
  State<_EmergencyToggle> createState() => _EmergencyToggleState();
}

class _EmergencyToggleState extends State<_EmergencyToggle> {
  bool isEmergency = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isEmergency
              ? AppColors.primary.withValues(alpha: 0.1)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isEmergency
                ? AppColors.primary
                : Colors.white.withValues(alpha: 0.05),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isEmergency
                    ? AppColors.primary
                    : Colors.white.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.emergency_rounded,
                color: isEmergency ? Colors.white : Colors.white38,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Emergency Mode',
                    style: AppTextStyles.subtitle1.copyWith(
                      color: isEmergency ? AppColors.primary : Colors.white,
                    ),
                  ),
                  Text(
                    isEmergency
                        ? 'Urgent requests highlighted'
                        : 'Stay alert for requests',
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.white38,
                    ),
                  ),
                ],
              ),
            ),
            Switch.adaptive(
              value: isEmergency,
              onChanged: (v) => setState(() => isEmergency = v),
              activeThumbColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GestureDetector(
        onTap: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => const FindScreen()));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: Colors.white38, size: 24),
              const SizedBox(width: 12),
              Text(
                'Find blood donors nearby...',
                style: AppTextStyles.body2.copyWith(color: Colors.white38),
              ),
              const Spacer(),
              const Icon(
                Icons.tune_rounded,
                color: AppColors.primary,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final int count;
  const _SectionHeader({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.heading3),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(20),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '$count+ NEW',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UrgentRequestsList extends StatelessWidget {
  const _UrgentRequestsList();

  @override
  Widget build(BuildContext context) {
    final urgentRequests = [
      {
        'type': 'B-',
        'hospital': 'Mayo Hospital',
        'city': 'Lahore',
        'urgency': 'CRITICAL',
      },
      {
        'type': 'O+',
        'hospital': 'Jinnah Hospital',
        'city': 'Karachi',
        'urgency': 'URGENT',
      },
      {
        'type': 'A-',
        'hospital': 'PIMS Islamabad',
        'city': 'Islamabad',
        'urgency': 'URGENT',
      },
    ];

    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 24, right: 12),
        itemCount: urgentRequests.length,
        itemBuilder: (context, i) {
          final req = urgentRequests[i];
          final isCritical = req['urgency'] == 'CRITICAL';

          return Container(
            width: 220,
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isCritical
                    ? AppColors.primary.withAlpha(100)
                    : Colors.white10,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: (isCritical ? AppColors.primary : Colors.white10)
                            .withAlpha(30),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        req['urgency']!,
                        style: AppTextStyles.caption.copyWith(
                          color: isCritical
                              ? AppColors.primary
                              : Colors.white54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      req['type']!,
                      style: AppTextStyles.heading3.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  req['hospital']!,
                  style: AppTextStyles.subtitle2.copyWith(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 12,
                      color: Colors.white38,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      req['city']!,
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white38,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const DonateScreen()),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Donate Now',
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ImpactSection extends StatelessWidget {
  const _ImpactSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Your Impact', style: AppTextStyles.heading3),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('5 Lives Saved', style: AppTextStyles.subtitle1),
                          const SizedBox(height: 4),
                          Text(
                            'Keep it up, hero!',
                            style: AppTextStyles.body2.copyWith(
                              color: Colors.white38,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withAlpha(20),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: AppColors.primary,
                        size: 28,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: const LinearProgressIndicator(
                    value: 0.7,
                    backgroundColor: Colors.white10,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                    minHeight: 8,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Next level in 150ml',
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white38,
                      ),
                    ),
                    Text(
                      '70%',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CommunityStories extends StatelessWidget {
  const _CommunityStories();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Community Stories', style: AppTextStyles.heading3),
              Text(
                'See All',
                style: AppTextStyles.caption.copyWith(color: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1542884748-2b87b36c6b90?w=800&q=80',
                ),
                fit: BoxFit.cover,
                opacity: 0.5,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withValues(alpha: 0.8),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'How Bilal saved 3 lives in Lahore',
                  style: AppTextStyles.subtitle1.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
