import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants.dart';

class BloodCenterDetailScreen extends StatefulWidget {
  final Map<String, dynamic> center;

  const BloodCenterDetailScreen({super.key, required this.center});

  @override
  State<BloodCenterDetailScreen> createState() =>
      _BloodCenterDetailScreenState();
}

class _BloodCenterDetailScreenState extends State<BloodCenterDetailScreen> {
  bool _isSaved = false;

  Future<void> _launchPhone(String phoneNumber) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.center['name'] as String;
    final type = widget.center['type'] as String;
    final distance = widget.center['distance'] as String;
    final status = widget.center['status'] as String;

    Color statusColor;
    if (status == 'Critical') {
      statusColor = AppColors.primary;
    } else if (status == 'Low') {
      statusColor = Colors.orange;
    } else {
      statusColor = Colors.green;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header with back button
            SliverAppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              pinned: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    _isSaved ? Icons.bookmark : Icons.bookmark_border_rounded,
                    color: AppColors.primary,
                  ),
                  onPressed: () => setState(() => _isSaved = !_isSaved),
                ),
              ],
            ),
            // Content
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Blood Type Card
                    FadeInDown(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(
                            AppBorderRadius.xl,
                          ),
                          boxShadow: AppShadows.card,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Required Blood Type',
                                      style: AppTextStyles.caption.copyWith(
                                        color: Colors.white70,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      type,
                                      style: AppTextStyles.heading1.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(
                                      AppBorderRadius.circle,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: statusColor,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        status,
                                        style: AppTextStyles.subtitle2.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Center Information
                    FadeInUp(
                      delay: const Duration(milliseconds: 100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Center Information',
                            style: AppTextStyles.subtitle2,
                          ),
                          const SizedBox(height: 16),
                          _InfoCard(
                            icon: Icons.local_hospital_rounded,
                            title: 'Hospital Name',
                            subtitle: name,
                            color: AppColors.primary,
                          ),
                          const SizedBox(height: 12),
                          _InfoCard(
                            icon: Icons.location_on_rounded,
                            title: 'Location',
                            subtitle: 'Karachi, Pakistan',
                            color: Colors.blue,
                          ),
                          const SizedBox(height: 12),
                          _InfoCard(
                            icon: Icons.speed_rounded,
                            title: 'Distance',
                            subtitle: distance,
                            color: Colors.purple,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Requirement Details
                    FadeInUp(
                      delay: const Duration(milliseconds: 150),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Requirement Details',
                            style: AppTextStyles.subtitle2,
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(
                                AppBorderRadius.lg,
                              ),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.05),
                              ),
                            ),
                            child: Column(
                              children: [
                                _RequirementRow(
                                  label: 'Blood Type Needed',
                                  value: type,
                                  icon: Icons.favorite_rounded,
                                ),
                                Divider(color: Colors.white.withOpacity(0.1)),
                                _RequirementRow(
                                  label: 'Urgency Level',
                                  value: status,
                                  icon: Icons.warning_rounded,
                                ),
                                Divider(color: Colors.white.withOpacity(0.1)),
                                _RequirementRow(
                                  label: 'Units Required',
                                  value: '3-5 units',
                                  icon: Icons.inventory_2_rounded,
                                ),
                                Divider(color: Colors.white.withOpacity(0.1)),
                                _RequirementRow(
                                  label: 'Needed By',
                                  value: 'Today',
                                  icon: Icons.schedule_rounded,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Facilities
                    FadeInUp(
                      delay: const Duration(milliseconds: 200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Available Facilities',
                            style: AppTextStyles.subtitle2,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              _FacilityBadge(
                                icon: Icons.local_hospital_rounded,
                                label: '24/7 Service',
                              ),
                              const SizedBox(width: 12),
                              _FacilityBadge(
                                icon: Icons.medical_services_rounded,
                                label: 'ICU Facility',
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              _FacilityBadge(
                                icon: Icons.directions_car_rounded,
                                label: 'Free Transport',
                              ),
                              const SizedBox(width: 12),
                              _FacilityBadge(
                                icon: Icons.verified_rounded,
                                label: 'Certified',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Contact Information
                    FadeInUp(
                      delay: const Duration(milliseconds: 250),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Contact Information',
                            style: AppTextStyles.subtitle2,
                          ),
                          const SizedBox(height: 16),
                          _ContactButton(
                            icon: Icons.phone_rounded,
                            label: 'Call Center',
                            value: '0300-1234567',
                            onTap: () => _launchPhone('03001234567'),
                            color: Colors.green,
                          ),
                          const SizedBox(height: 12),
                          _ContactButton(
                            icon: Icons.email_rounded,
                            label: 'Email',
                            value: 'contact@hospital.com',
                            onTap: () {},
                            color: Colors.blue,
                          ),
                          const SizedBox(height: 12),
                          _ContactButton(
                            icon: Icons.location_on_rounded,
                            label: 'Address',
                            value: 'Main Road, Karachi, Pakistan',
                            onTap: () {},
                            color: Colors.purple,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Action Buttons
                    FadeInUp(
                      delay: const Duration(milliseconds: 300),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppBorderRadius.circle,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Donation request submitted!',
                                    ),
                                    backgroundColor: AppColors.success,
                                  ),
                                );
                              },
                              icon: const Icon(Icons.done_rounded),
                              label: const Text(
                                'Commit to Donate',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: AppColors.primary,
                                  width: 1.5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppBorderRadius.circle,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                _launchPhone('03001234567');
                              },
                              icon: const Icon(Icons.phone_rounded),
                              label: const Text('Call Now'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppBorderRadius.lg),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppBorderRadius.md),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.caption.copyWith(color: Colors.white38),
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: AppTextStyles.subtitle1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RequirementRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _RequirementRow({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.caption.copyWith(color: Colors.white38),
                ),
                const SizedBox(height: 4),
                Text(value, style: AppTextStyles.subtitle2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FacilityBadge extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FacilityBadge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.primary, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.caption,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;
  final Color color;

  const _ContactButton({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppBorderRadius.md),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.white38,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(value, style: AppTextStyles.subtitle2),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white24,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
