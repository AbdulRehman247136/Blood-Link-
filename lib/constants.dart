import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ============ COLORS ============
class AppColors {
  // Primary red palette (vibrant crimson)
  static const primary = Color(0xFFC62828);
  static const primaryDark = Color(0xFF8E0000);
  static const primaryLight = Color(0xFFFF5F52);
  static const secondary = Color(0xFFD32F2F);

  // Status Colors
  static const success = Color(0xFF25D366); // WhatsApp Green
  static const warning = Color(0xFFE67E22);
  static const error = Color(0xFFDA0B2E);
  static const errorLight = Color(0xFFFF6B6B);
  static const borderColor = Color(0xFF404040);

  // ─── Background & Surfaces ───────────────────────
  static const background = Color(0xFF121212); // Deep Charcoal
  static const surface = Color(0xFF1E1E1E); // Surface Dark
  static const surfaceVariant = Color(0xFF252525); // Inputs / Elevated
  static const cardBackground = Color(0xFF1E1E1E);

  // Specific backgrounds from design
  static const backgroundDarkAlt = Color(0xFF221013); // Login Dark Reddish
  static const surfaceDarkAlt = Color(0xFF34181D); // Register Surface

  // Text Colors
  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFF94A3B8); // Slate 400
  static const textMuted = Color(0xFF64748B); // Slate 500
  static const textOnPrimary = Colors.white;

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFDA0B2E), Color(0xFFB00925)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient glassGradient = LinearGradient(
    colors: [Colors.white10, Colors.white12],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkBgGradient = LinearGradient(
    colors: [Color(0xFF121212), Color(0xFF1A1A1A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const successLight = Color(
    0xFFB2F5B2,
  ); // Light green for success backgrounds
}

// ============ SPACING ============
class AppSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 20.0;
  static const xxl = 24.0;
  static const xxxl = 32.0;
}

// ============ BORDER RADIUS ============
class AppBorderRadius {
  static const sm = 12.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const xxl = 48.0;
  static const circle = 999.0;
}

// ============ TEXT STYLES ============
class AppTextStyles {
  // Using Manrope for the new design
  static TextStyle get heading1 => GoogleFonts.manrope(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static TextStyle get heading2 => GoogleFonts.manrope(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static TextStyle get heading3 => GoogleFonts.manrope(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle get subtitle1 => GoogleFonts.manrope(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle get subtitle2 => GoogleFonts.manrope(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static TextStyle get body1 => GoogleFonts.manrope(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static TextStyle get body2 => GoogleFonts.manrope(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle get button => GoogleFonts.manrope(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    letterSpacing: 0.5,
  );

  static TextStyle get caption => GoogleFonts.manrope(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textMuted,
  );

  static TextStyle get badge => GoogleFonts.manrope(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}

// ============ SHADOWS ============
class AppShadows {
  static List<BoxShadow> get primaryGlow => [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.3),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> get glassShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.3),
      blurRadius: 32,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> get button => [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.4),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get card => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.2),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get cardHeavy => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.3),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get fab => [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.5),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];
}

// ============ DURATIONS ============
class AppDurations {
  static const fast = Duration(milliseconds: 200);
  static const normal = Duration(milliseconds: 400);
  static const slow = Duration(milliseconds: 600);
}
