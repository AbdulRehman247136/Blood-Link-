import 'package:bloodbanks/widgets/theme_toggle.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 60, bottom: 40),
        child: Column(
          children: [
            _ProfileHeader(),
            const SizedBox(height: 32),
            _ImpactStats(),
            const SizedBox(height: 32),
            _AchievementsSection(),
            const SizedBox(height: 32),
            _DonationHistory(),
            const SizedBox(height: 40),
            _SettingsOptions(),
            const SizedBox(height: 20),
            _SignOutButton(context),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.primaryGradient,
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.surface,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(Icons.person, color: Colors.white, size: 50),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit, color: Colors.white, size: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('John Doe', style: AppTextStyles.heading2),
          Text(
            'BloodLink+ Elite Donor',
            style: AppTextStyles.body2.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _ImpactStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatCard(
            value: '12',
            label: 'Donations',
            icon: Icons.water_drop,
            color: AppColors.primary,
          ),
          _StatCard(
            value: '5',
            label: 'Lives Saved',
            icon: Icons.favorite,
            color: Colors.blue,
          ),
          _StatCard(
            value: '850',
            label: 'Impact Score',
            icon: Icons.star,
            color: Colors.amber,
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value, label;
  final IconData icon;
  final Color color;
  const _StatCard({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withAlpha(20),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(value, style: AppTextStyles.heading3),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(color: Colors.white38),
        ),
      ],
    );
  }
}

class _AchievementsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Achievements', style: AppTextStyles.subtitle1),
          const SizedBox(height: 16),
          SizedBox(
            height: 90,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _Badge(
                  icon: Icons.flash_on,
                  label: 'First Drop',
                  color: Colors.orange,
                ),
                _Badge(
                  icon: Icons.group,
                  label: 'Recruiter',
                  color: Colors.blue,
                ),
                _Badge(
                  icon: Icons.verified,
                  label: 'Verified',
                  color: Colors.green,
                ),
                _Badge(
                  icon: Icons.military_tech,
                  label: 'Hero',
                  color: Colors.purple,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _Badge({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withValues(alpha: 0.2)),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(fontSize: 10),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _DonationHistory extends StatelessWidget {
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
              Text('Donation History', style: AppTextStyles.subtitle1),
              Text(
                'View All',
                style: AppTextStyles.caption.copyWith(color: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _HistoryItem(
            date: 'Oct 12, 2025',
            location: 'City Hospital',
            amount: '350ml',
          ),
          _HistoryItem(
            date: 'Aug 05, 2025',
            location: 'Red Cross Center',
            amount: '400ml',
          ),
        ],
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final String date, location, amount;
  const _HistoryItem({
    required this.date,
    required this.location,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(location, style: AppTextStyles.subtitle2),
                Text(
                  date,
                  style: AppTextStyles.caption.copyWith(color: Colors.white38),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: AppTextStyles.body2.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _SettingsOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          _OptionTile(
            title: 'Personal Information',
            icon: Icons.person_outline,
          ),
          _OptionTile(
            title: 'Medical Records',
            icon: Icons.description_outlined,
          ),
          _OptionTile(
            title: 'Notification Settings',
            icon: Icons.notifications_none_outlined,
            isToggle: true,
          ),
          const SizedBox(height: 24),
          const ThemeModeSelector(),
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isToggle;

  const _OptionTile({
    required this.title,
    required this.icon,
    this.isToggle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        tileColor: AppColors.surface,
        leading: Icon(icon, color: Colors.white70, size: 22),
        title: Text(title, style: AppTextStyles.body2),
        trailing: isToggle
            ? Switch(
                value: true,
                onChanged: (value) {},
                activeThumbColor: AppColors.primary,
              )
            : const Icon(Icons.chevron_right, color: Colors.white24),
        onTap: () {},
      ),
    );
  }
}

class _SignOutButton extends StatelessWidget {
  final BuildContext context;
  const _SignOutButton(this.context);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
        );
      },
      child: Text(
        'SIGN OUT',
        style: AppTextStyles.caption.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
