import 'package:flutter/material.dart';
import 'colors.dart';

/// Production-ready typography system for Blood Bank App
/// Follows Material Design 3 typography scale
/// Optimized for accessibility and readability

class AppTypography {
  // Font families
  static const String primaryFont = 'Poppins'; // Modern, clean
  static const String secondaryFont = 'Inter'; // System fallback
  static const String monoFont = 'JetBrains Mono'; // For data display

  // Display Styles (Large headlines)
  static const TextStyle displayLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 57.0,
    fontWeight: FontWeight.w700,
    height: 1.12,
    letterSpacing: -0.25,
    color: AppColors.textPrimary,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 45.0,
    fontWeight: FontWeight.w700,
    height: 1.16,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: 36.0,
    fontWeight: FontWeight.w700,
    height: 1.22,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  // Headline Styles (Section titles)
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 28.0,
    fontWeight: FontWeight.w700,
    height: 1.29,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
    height: 1.33,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0.15,
    color: AppColors.textPrimary,
  );

  // Title Styles (Card titles, subsections)
  static const TextStyle titleLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    height: 1.44,
    letterSpacing: 0.15,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    height: 1.5,
    letterSpacing: 0.15,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    height: 1.43,
    letterSpacing: 0.1,
    color: AppColors.textPrimary,
  );

  // Body Styles (Main content)
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: secondaryFont,
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: secondaryFont,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    height: 1.43,
    letterSpacing: 0.25,
    color: AppColors.textSecondary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: secondaryFont,
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    height: 1.33,
    letterSpacing: 0.4,
    color: AppColors.textSecondary,
  );

  // Label Styles (Buttons, chips, tags)
  static const TextStyle labelLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    height: 1.43,
    letterSpacing: 0.1,
    color: AppColors.textPrimary,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
    height: 1.33,
    letterSpacing: 0.5,
    color: AppColors.textSecondary,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: 11.0,
    fontWeight: FontWeight.w600,
    height: 1.45,
    letterSpacing: 0.5,
    color: AppColors.textTertiary,
  );

  // Blood Bank Specific Styles
  static const TextStyle bloodTypeHero = TextStyle(
    fontFamily: primaryFont,
    fontSize: 48.0,
    fontWeight: FontWeight.w800,
    height: 1.0,
    color: AppColors.primary,
  );

  static const TextStyle bloodTypeLabel = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppColors.textInverse,
  );

  static const TextStyle emergencyTitle = TextStyle(
    fontFamily: primaryFont,
    fontSize: 24.0,
    fontWeight: FontWeight.w800,
    height: 1.33,
    letterSpacing: 0.5,
    color: AppColors.emergencyRed,
  );

  static const TextStyle emergencySubtitle = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    height: 1.43,
    color: AppColors.emergencyRed,
  );

  static const TextStyle urgencyBadge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12.0,
    fontWeight: FontWeight.w700,
    height: 1.33,
    letterSpacing: 0.5,
    color: AppColors.textInverse,
  );

  // Input & Form Styles
  static const TextStyle inputHint = TextStyle(
    fontFamily: secondaryFont,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    height: 1.43,
    letterSpacing: 0.25,
    color: AppColors.textTertiary,
  );

  static const TextStyle inputLabel = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
    height: 1.33,
    letterSpacing: 0.4,
    color: AppColors.textSecondary,
  );

  // Error & Validation Styles
  static const TextStyle errorMessage = TextStyle(
    fontFamily: secondaryFont,
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    height: 1.33,
    color: AppColors.error,
  );

  static const TextStyle successMessage = TextStyle(
    fontFamily: secondaryFont,
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    height: 1.33,
    color: AppColors.success,
  );

  // Button Text Styles
  static const TextStyle buttonLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 15.0,
    fontWeight: FontWeight.w600,
    height: 1.33,
    letterSpacing: 0.1,
    color: AppColors.textInverse,
  );

  static const TextStyle buttonMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 13.0,
    fontWeight: FontWeight.w600,
    height: 1.38,
    letterSpacing: 0.1,
    color: AppColors.textInverse,
  );

  static const TextStyle buttonSmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: 11.0,
    fontWeight: FontWeight.w600,
    height: 1.45,
    letterSpacing: 0.5,
    color: AppColors.textInverse,
  );

  // Accessibility variants
  static TextStyle largeText(TextStyle style) {
    return style.copyWith(fontSize: (style.fontSize ?? 14) * 1.2);
  }

  static TextStyle boldText(TextStyle style) {
    return style.copyWith(fontWeight: FontWeight.w700);
  }

  static TextStyle disabledText(TextStyle style) {
    return style.copyWith(color: AppColors.textDisabled);
  }

  /// Get TextTheme for Material Design
  static TextTheme getTextTheme() {
    return const TextTheme(
      displayLarge: displayLarge,
      displayMedium: displayMedium,
      displaySmall: displaySmall,
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      labelLarge: labelLarge,
      labelMedium: labelMedium,
      labelSmall: labelSmall,
    );
  }
}
