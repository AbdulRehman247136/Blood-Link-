// Example: Using Design System in a Real Screen
// This file demonstrates best practices for implementing screens using the design system

import 'package:flutter/material.dart';
import '../theme/index.dart'; // Import all design system components

/// Example screen showing how to use the complete design system
/// This demonstrates:
/// - Color usage for blood bank context
/// - Typography hierarchy
/// - Proper spacing and responsive layout
/// - Shadow and elevation
/// - Animation implementation
/// - Accessibility compliance

class DesignSystemExampleScreen extends StatefulWidget {
  const DesignSystemExampleScreen({Key? key}) : super(key: key);

  @override
  State<DesignSystemExampleScreen> createState() =>
      _DesignSystemExampleScreenState();
}

class _DesignSystemExampleScreenState extends State<DesignSystemExampleScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    // Emergency pulse animation
    _pulseController = AnimationController(
      duration: AppAnimations.emergencyPulse,
      vsync: this,
    )..repeat(reverse: true);

    // Fade in/out animation
    _fadeController = AnimationController(
      duration: AppAnimations.standard,
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildEmergencySection(),
            _buildBloodTypesSection(),
            _buildDonorCardsSection(),
            _buildButtonsSection(),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  // ================================
  // APPBAR
  // ================================

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text('Blood Bank', style: AppTypography.headlineSmall),
      centerTitle: false,
      elevation: 0,
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.textPrimary,
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {},
          tooltip: 'Settings',
          iconSize: AppSpacing.iconMedium,
        ),
      ],
    );
  }

  // ================================
  // EMERGENCY SECTION (with animation)
  // ================================

  Widget _buildEmergencySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPaddingHorizontal,
        vertical: AppSpacing.xl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'EMERGENCY REQUEST',
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.emergencyRed,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ScaleTransition(
            scale: Tween<double>(begin: 1.0, end: 1.15).animate(
              CurvedAnimation(
                parent: _pulseController,
                curve: AppAnimations.emergencyEaseCurve,
              ),
            ),
            child: GestureDetector(
              onTap: _showEmergencyDialog,
              child: Container(
                width: double.infinity,
                height: AppSpacing.emergencyButtonSize + AppSpacing.xl,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: AppColors.emergencyGradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(
                    AppSpacing.borderRadiusLarge,
                  ),
                  boxShadow: AppShadows.emergencyShadow,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.emergency,
                      color: AppColors.textInverse,
                      size: AppSpacing.iconLarge,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'REQUEST BLOOD\nEMERGENCY',
                      textAlign: TextAlign.center,
                      style: AppTypography.emergencyTitle.copyWith(
                        color: AppColors.textInverse,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Sending emergency request to nearby donors',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  void _showEmergencyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Emergency Blood Request',
          style: AppTypography.headlineMedium,
        ),
        content: Text(
          'Your emergency request has been sent to all nearby donors.',
          style: AppTypography.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'CLOSE',
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================================
  // BLOOD TYPES SECTION
  // ================================

  Widget _buildBloodTypesSection() {
    final bloodTypes = [
      ('O-', 'Most Needed'),
      ('A+', 'Common'),
      ('B+', 'Common'),
      ('AB-', 'Rare'),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPaddingHorizontal,
        vertical: AppSpacing.xl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'BLOOD TYPES',
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.textSecondary,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: AppSpacing.gridSpacing,
            crossAxisSpacing: AppSpacing.gridSpacing,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: bloodTypes.map((type) {
              return _buildBloodTypeCard(type.$1, type.$2);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBloodTypeCard(String bloodType, String status) {
    final color = AppColors.getBloodTypeColor(bloodType);

    return GestureDetector(
      onTap: () => _showBloodTypeDetails(bloodType),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusLarge),
          boxShadow: AppShadows.cardShadow,
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              bloodType,
              style: AppTypography.bloodTypeHero.copyWith(color: color),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              status,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBloodTypeDetails(String bloodType) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Blood Type: $bloodType',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textInverse,
          ),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ================================
  // DONOR CARDS SECTION
  // ================================

  Widget _buildDonorCardsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPaddingHorizontal,
        vertical: AppSpacing.xl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'NEARBY DONORS',
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.textSecondary,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _buildDonorCard(
            name: 'Ahmed Khan',
            bloodType: 'O-',
            distance: '2.5 km',
            rating: 4.8,
          ),
          const SizedBox(height: AppSpacing.cardSpacing),
          _buildDonorCard(
            name: 'Fatima Ali',
            bloodType: 'A+',
            distance: '3.1 km',
            rating: 4.9,
          ),
        ],
      ),
    );
  }

  Widget _buildDonorCard({
    required String name,
    required String bloodType,
    required String distance,
    required double rating,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
        boxShadow: AppShadows.cardShadow,
      ),
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primary100,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 2),
            ),
            child: Center(
              child: Text(
                name[0],
                style: AppTypography.headlineSmall.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTypography.titleMedium),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.getBloodTypeColor(bloodType),
                        borderRadius: BorderRadius.circular(
                          AppSpacing.borderRadiusMedium,
                        ),
                      ),
                      child: Text(
                        bloodType,
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.textInverse,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Text(
                      distance,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Rating
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.star,
                color: AppColors.warning,
                size: AppSpacing.iconMedium,
              ),
              Text(rating.toString(), style: AppTypography.labelSmall),
            ],
          ),
        ],
      ),
    );
  }

  // ================================
  // BUTTONS SECTION (Interactive states)
  // ================================

  Widget _buildButtonsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPaddingHorizontal,
        vertical: AppSpacing.xl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'BUTTON STATES',
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.textSecondary,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          // Primary Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Primary Button', style: AppTypography.buttonLarge),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          // Outlined Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              child: Text(
                'Outlined Button',
                style: AppTypography.buttonLarge.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          // Disabled Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: null,
              child: Text('Disabled Button', style: AppTypography.buttonLarge),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }

  // ================================
  // FLOATING ACTION BUTTON
  // ================================

  Widget _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () {},
      icon: const Icon(Icons.add),
      label: Text('New Request', style: AppTypography.labelLarge),
    );
  }
}
