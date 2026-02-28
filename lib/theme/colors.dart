import 'package:flutter/material.dart';

/// Production-ready color palette for Blood Bank App
/// Follows Material Design 3 guidelines with custom blood donation theme

class AppColors {
  // Primary Colors (Blood Red Theme)
  static const Color primary = Color(0xFFD32F2F); // Medical red
  static const Color primary50 = Color(0xFFFFEBEE);
  static const Color primary100 = Color(0xFFFFCDD2);
  static const Color primary200 = Color(0xFFEF9A9A);
  static const Color primary300 = Color(0xFFE57373);
  static const Color primary400 = Color(0xFFEF5350);
  static const Color primary500 = Color(0xFFD32F2F); // Main primary
  static const Color primary600 = Color(0xFFC62828);
  static const Color primary700 = Color(0xFFB71C1C);
  static const Color primary800 = Color(0xFF8B0000); // Dark blood red
  static const Color primary900 = Color(0xFF5C0000);

  // Secondary Colors (Complementary)
  static const Color secondary = Color(0xFFF57C00); // Orange (medical/heat)
  static const Color secondary50 = Color(0xFFFFF3E0);
  static const Color secondary100 = Color(0xFFFFE0B2);
  static const Color secondary200 = Color(0xFFFFCC80);
  static const Color secondary300 = Color(0xFFFFB74D);
  static const Color secondary400 = Color(0xFFFFA726);
  static const Color secondary500 = Color(0xFFF57C00);
  static const Color secondary600 = Color(0xFFF57C00);
  static const Color secondary700 = Color(0xFFE65100);
  static const Color secondary800 = Color(0xFFBF360C);
  static const Color secondary900 = Color(0xFF7E0000);

  // Tertiary Colors (Accent - Green for positive action)
  static const Color tertiary = Color(0xFF00897B); // Teal
  static const Color tertiary50 = Color(0xFFE0F2F1);
  static const Color tertiary100 = Color(0xFFB2DFDB);
  static const Color tertiary200 = Color(0xFF80CBC4);
  static const Color tertiary300 = Color(0xFF4DB6AC);
  static const Color tertiary400 = Color(0xFF26A69A);
  static const Color tertiary500 = Color(0xFF009688);
  static const Color tertiary600 = Color(0xFF00897B);
  static const Color tertiary700 = Color(0xFF00796B);
  static const Color tertiary800 = Color(0xFF004D40);

  // Neutral Colors (Backgrounds, text)
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5F5F5);
  static const Color outline = Color(0xFF828282);
  static const Color outlineVariant = Color(0xFFBDBDBD);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121); // Dark gray (87% opacity)
  static const Color textSecondary = Color(
    0xFF757575,
  ); // Medium gray (60% opacity)
  static const Color textTertiary = Color(
    0xFFBDBDBD,
  ); // Light gray (38% opacity)
  static const Color textInverse = Color(0xFFFFFFFF); // White on dark
  static const Color textDisabled = Color(0xFFE0E0E0); // Disabled text

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
  static const Color errorContainers = Color(0xFFF9DEDC);
  static const Color successContainers = Color(0xFFE8F5E9);
  static const Color warningContainers = Color(0xFFFFF3E0);
  static const Color infoContainers = Color(0xFFE3F2FD);

  // Emergency Mode Colors
  static const Color emergencyRed = Color(0xFFD32F2F);
  static const Color emergencyGlow = Color(0xFFEF5350);
  static const Color emergencyLight = Color(0xFFFFCDD2);

  // Urgency Levels
  static const Color urgencyO = Color(
    0xFF4CAF50,
  ); // Green - O Negative (Common)
  static const Color urgencyAPos = Color(0xFF2196F3); // Blue - A+
  static const Color urgencyANeg = Color(0xFF9C27B0); // Purple - A-
  static const Color urgencyBPos = Color(0xFFFF9800); // Orange - B+
  static const Color urgencyBNeg = Color(0xFFF44336); // Red - B-
  static const Color urgencyABPos = Color(0xFFFFC107); // Amber - AB+
  static const Color urgencyABNeg = Color(0xFF00BCD4); // Cyan - AB-

  // Overlay Colors
  static const Color scrimLight = Color(0x33000000); // 20% opacity black
  static const Color scrimMedium = Color(0x66000000); // 40% opacity black
  static const Color scrimDark = Color(0x99000000); // 60% opacity black

  // Gradient Colors (for animations)
  static const List<Color> bloodGradient = [
    Color(0xFFD32F2F),
    Color(0xFFB71C1C),
    Color(0xFF8B0000),
  ];

  static const List<Color> emergencyGradient = [
    Color(0xFFEF5350),
    Color(0xFFD32F2F),
    Color(0xFFBF360C),
  ];

  static const List<Color> warningGradient = [
    Color(0xFFFFC107),
    Color(0xFFFFB300),
    Color(0xFFFFA000),
  ];

  // Dark Mode Support (AMOLED optimized)
  static const Color darkBackground = Color(
    0xFF0D0D0D,
  ); // True black for AMOLED
  static const Color darkSurface = Color(0xFF1A1A1A);
  static const Color darkSurfaceVariant = Color(0xFF252525);
  static const Color darkCardBackground = Color(0xFF1A1A1A);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB3B3B3);
  static const Color darkTextTertiary = Color(0xFF808080);
  static const Color darkOutline = Color(0xFF404040);
  static const Color darkOutlineVariant = Color(0xFF2A2A2A);

  // Dark mode primary (brighter for contrast)
  static const Color darkPrimary = Color(0xFFFF3B3B);
  static const Color darkPrimaryContainer = Color(0xFF5C1A1A);
  static const Color darkOnPrimaryContainer = Color(0xFFFFDAD6);

  // Dark mode secondary
  static const Color darkSecondary = Color(0xFFFFB74D);
  static const Color darkSecondaryContainer = Color(0xFF5C3D1A);
  static const Color darkOnSecondaryContainer = Color(0xFFFFE0B2);

  // Dark mode tertiary
  static const Color darkTertiary = Color(0xFF4DB6AC);
  static const Color darkTertiaryContainer = Color(0xFF004D40);
  static const Color darkOnTertiaryContainer = Color(0xFFB2DFDB);

  // Dark mode status colors (brighter variants)
  static const Color darkSuccess = Color(0xFF4CAF50);
  static const Color darkWarning = Color(0xFFFFB300);
  static const Color darkError = Color(0xFFFF6B6B);
  static const Color darkInfo = Color(0xFF64B5F6);

  // Dark mode containers
  static const Color darkErrorContainer = Color(0xFF5C1A1A);
  static const Color darkSuccessContainer = Color(0xFF1A3D1A);
  static const Color darkWarningContainer = Color(0xFF5C4A1A);
  static const Color darkInfoContainer = Color(0xFF1A3D5C);

  // Dark mode emergency
  static const Color darkEmergencyRed = Color(0xFFFF3B3B);
  static const Color darkEmergencyGlow = Color(0xFFFF6B6B);

  // Dark mode overlay
  static const Color darkScrimLight = Color(0x33FFFFFF);
  static const Color darkScrimMedium = Color(0x66FFFFFF);

  /// Get color based on urgency level
  static Color getBloodTypeColor(String bloodType) {
    switch (bloodType.toUpperCase()) {
      case 'O_NEGATIVE':
      case 'O-':
        return urgencyO;
      case 'A_POSITIVE':
      case 'A+':
        return urgencyAPos;
      case 'A_NEGATIVE':
      case 'A-':
        return urgencyANeg;
      case 'B_POSITIVE':
      case 'B+':
        return urgencyBPos;
      case 'B_NEGATIVE':
      case 'B-':
        return urgencyBNeg;
      case 'AB_POSITIVE':
      case 'AB+':
        return urgencyABPos;
      case 'AB_NEGATIVE':
      case 'AB-':
        return urgencyABNeg;
      default:
        return primary;
    }
  }

  /// Get surface color with elevation
  static Color getSurfaceColor(int elevation) {
    switch (elevation) {
      case 0:
        return surface;
      case 1:
        return const Color(0xFFFCFCFC);
      case 2:
        return const Color(0xFFFAFAFA);
      case 3:
        return const Color(0xFFF8F8F8);
      case 4:
        return const Color(0xFFF6F6F6);
      default:
        return surface;
    }
  }

  /// Get dark surface color with elevation (Material You style)
  static Color getDarkSurfaceColor(int elevation) {
    switch (elevation) {
      case 0:
        return darkBackground;
      case 1:
        return darkSurface;
      case 2:
        return darkSurfaceVariant;
      case 3:
        return const Color(0xFF2A2A2A);
      case 4:
        return const Color(0xFF303030);
      default:
        return darkSurface;
    }
  }
}
