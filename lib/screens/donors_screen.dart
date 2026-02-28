import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'contact_donor_screen.dart';

class DonorsScreen extends StatefulWidget {
  const DonorsScreen({super.key});

  @override
  State<DonorsScreen> createState() => _DonorsScreenState();
}

class _DonorsScreenState extends State<DonorsScreen> {
  final List<Map<String, dynamic>> _donors = const [
    {
      'name': 'Ayesha Khan',
      'type': 'O+',
      'last': '20 days',
      'distance': '2.4 km',
      'available': true,
    },
    {
      'name': 'Omar Farooq',
      'type': 'B+',
      'last': '60 days',
      'distance': '3.8 km',
      'available': true,
    },
    {
      'name': 'Bilal Ahmed',
      'type': 'A+',
      'last': '45 days',
      'distance': '5.1 km',
      'available': false,
    },
    {
      'name': 'Sara Malik',
      'type': 'B-',
      'last': '12 days',
      'distance': '1.2 km',
      'available': true,
    },
    {
      'name': 'Usman Ali',
      'type': 'AB+',
      'last': '90 days',
      'distance': '10 km',
      'available': false,
    },
  ];

  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = _donors.where((donor) {
      return (donor['name'] as String).toLowerCase().contains(
        _query.toLowerCase(),
      );
    }).toList();

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Donors',
                style: AppTextStyles.heading2.copyWith(color: Colors.white),
              ),
              Text(
                'Find a donor near you',
                style: AppTextStyles.body2.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 14),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppBorderRadius.circle),
                  boxShadow: AppShadows.card,
                ),
                child: TextField(
                  onChanged: (value) => setState(() => _query = value),
                  decoration: InputDecoration(
                    hintText: 'Search donors by name…',
                    hintStyle: AppTextStyles.body1.copyWith(
                      color: AppColors.textMuted,
                    ),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: AppColors.primary,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Row(
            children: const [
              _SmallStat(value: '1,234', label: 'Donations'),
              SizedBox(width: 10),
              _SmallStat(value: '856', label: 'Donors'),
              SizedBox(width: 10),
              _SmallStat(value: '3,702', label: 'Lives Saved'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              return FadeInUp(
                delay: Duration(milliseconds: 80 * index),
                duration: const Duration(milliseconds: 400),
                child: _DonorCard(donor: filtered[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SmallStat extends StatelessWidget {
  final String value;
  final String label;

  const _SmallStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(AppBorderRadius.md),
          boxShadow: AppShadows.card,
        ),
        child: Column(
          children: [
            Text(
              value,
              style: AppTextStyles.subtitle1.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: AppTextStyles.caption,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _DonorCard extends StatelessWidget {
  final Map<String, dynamic> donor;

  const _DonorCard({required this.donor});

  @override
  Widget build(BuildContext context) {
    final available = donor['available'] as bool;
    final initials = (donor['name'] as String)
        .split(' ')
        .map((word) => word[0])
        .take(2)
        .join()
        .toUpperCase();

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ContactDonorScreen(donor: donor)),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
          boxShadow: AppShadows.card,
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFFFCDD2), Color(0xFFEF9A9A)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      initials,
                      style: AppTextStyles.subtitle1.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 1,
                    bottom: 1,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: available
                            ? AppColors.success
                            : AppColors.textMuted,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      donor['name'] as String,
                      style: AppTextStyles.subtitle1,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          size: 13,
                          color: AppColors.textSecondary,
                        ),
                        Text(
                          donor['distance'] as String,
                          style: AppTextStyles.caption,
                        ),
                        const SizedBox(width: 6),
                        Text('·', style: AppTextStyles.caption),
                        const SizedBox(width: 6),
                        Text(
                          'Last: ${donor['last']}',
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(
                        AppBorderRadius.circle,
                      ),
                    ),
                    child: Text(
                      donor['type'] as String,
                      style: AppTextStyles.badge,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _ActionButton(
                        icon: Icons.call_rounded,
                        color: AppColors.success,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ContactDonorScreen(donor: donor),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      _ActionButton(
                        icon: Icons.send_rounded,
                        color: AppColors.primary,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ContactDonorScreen(donor: donor),
                          ),
                        ),
                      ),
                    ],
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

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 18),
      ),
    );
  }
}
