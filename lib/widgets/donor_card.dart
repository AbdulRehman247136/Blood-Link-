import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/donor.dart';
import 'package:url_launcher/url_launcher.dart';

class DonorCard extends StatelessWidget {
  final Donor donor;
  const DonorCard({super.key, required this.donor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Stack(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withOpacity(0.2),
                      AppColors.primary.withOpacity(0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    donor.initials,
                    style: AppTextStyles.heading3.copyWith(color: AppColors.primary),
                  ),
                ),
              ),
              if (donor.isVerified)
                Positioned(
                  right: -2,
                  bottom: -2,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: AppColors.background,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.verified,
                      color: AppColors.success,
                      size: 18,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(donor.name, style: AppTextStyles.subtitle1),
                    const SizedBox(width: 8),
                    _BloodBadge(type: donor.bloodType),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${donor.hospital} · ${donor.city}',
                  style: AppTextStyles.caption.copyWith(color: Colors.white38),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.history, size: 12, color: Colors.white38),
                    const SizedBox(width: 4),
                    Text(
                      'Last: ${donor.lastDonated}',
                      style: AppTextStyles.caption.copyWith(color: Colors.white38),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.location_on, size: 12, color: Colors.white38),
                    const SizedBox(width: 4),
                    Text(
                      donor.distance,
                      style: AppTextStyles.caption.copyWith(color: Colors.white38),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Actions
          Column(
            children: [
              _ActionIcon(
                icon: Icons.call,
                color: AppColors.success,
                onTap: () => _launchCaller(donor.phone),
              ),
              const SizedBox(height: 8),
              _ActionIcon(
                icon: Icons.message,
                color: AppColors.primary,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _launchCaller(String phone) async {
    final url = 'tel:$phone';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}

class _BloodBadge extends StatelessWidget {
  final String type;
  const _BloodBadge({required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Text(
        type,
        style: AppTextStyles.badge.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _ActionIcon({required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }
}
