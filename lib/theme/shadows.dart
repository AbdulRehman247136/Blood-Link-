import 'package:flutter/material.dart';
import 'colors.dart';

/// Production-ready shadow and elevation system for Blood Bank App
/// Provides consistent depth and visual hierarchy

class AppShadows {
  // Elevation levels (Material Design 3)
  static const int elevation0 = 0;
  static const int elevation1 = 1;
  static const int elevation2 = 2;
  static const int elevation3 = 3;
  static const int elevation4 = 4;
  static const int elevation5 = 5;

  // Level 0 - Flat (no shadow)
  static const List<BoxShadow> elevation0Shadow = [];

  // Level 1 - Raised (subtle)
  static const List<BoxShadow> elevation1Shadow = [
    BoxShadow(
      color: Color(0x0D000000), // 5% opacity
      offset: Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x1A000000), // 10% opacity
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];

  // Level 2 - Regular
  static const List<BoxShadow> elevation2Shadow = [
    BoxShadow(
      color: Color(0x0D000000),
      offset: Offset(0, 3),
      blurRadius: 6,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];

  // Level 3 - Prominent
  static const List<BoxShadow> elevation3Shadow = [
    BoxShadow(
      color: Color(0x0D000000),
      offset: Offset(0, 6),
      blurRadius: 12,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 3),
      blurRadius: 6,
      spreadRadius: 0,
    ),
  ];

  // Level 4 - Deep
  static const List<BoxShadow> elevation4Shadow = [
    BoxShadow(
      color: Color(0x0D000000),
      offset: Offset(0, 9),
      blurRadius: 18,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 5),
      blurRadius: 10,
      spreadRadius: 0,
    ),
  ];

  // Level 5 - Maximum
  static const List<BoxShadow> elevation5Shadow = [
    BoxShadow(
      color: Color(0x0D000000),
      offset: Offset(0, 12),
      blurRadius: 24,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 6),
      blurRadius: 12,
      spreadRadius: 0,
    ),
  ];

  // Colored shadows for special effects
  static const List<BoxShadow> primaryShadow = [
    BoxShadow(
      color: Color(0x33D32F2F), // 20% red
      offset: Offset(0, 4),
      blurRadius: 8,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> emergencyShadow = [
    BoxShadow(
      color: Color(0x66D32F2F), // 40% red
      offset: Offset(0, 6),
      blurRadius: 16,
      spreadRadius: -2,
    ),
  ];

  static const List<BoxShadow> successShadow = [
    BoxShadow(
      color: Color(0x334CAF50), // 20% green
      offset: Offset(0, 4),
      blurRadius: 8,
      spreadRadius: 0,
    ),
  ];

  // Glow effects for animations
  static const List<BoxShadow> glowRed = [
    BoxShadow(color: AppColors.primary, blurRadius: 20, spreadRadius: 2),
  ];

  static const List<BoxShadow> glowRedIntense = [
    BoxShadow(color: AppColors.primary, blurRadius: 30, spreadRadius: 4),
  ];

  static const List<BoxShadow> glowOrange = [
    BoxShadow(color: AppColors.secondary, blurRadius: 20, spreadRadius: 2),
  ];

  static const List<BoxShadow> glowGreen = [
    BoxShadow(color: AppColors.success, blurRadius: 20, spreadRadius: 2),
  ];

  // Neumorphism effect (subtle)
  static const List<BoxShadow> neumorphismInset = [
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(2, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x0D000000),
      offset: Offset(-2, -2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> neumorphismOutset = [
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(3, 3),
      blurRadius: 6,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x0D000000),
      offset: Offset(-3, -3),
      blurRadius: 6,
      spreadRadius: 0,
    ),
  ];

  // Card shadows
  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> cardShadowHovered = [
    BoxShadow(
      color: Color(0x26000000),
      offset: Offset(0, 4),
      blurRadius: 8,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> cardShadowPressed = [
    BoxShadow(
      color: Color(0x0D000000),
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];

  // Button shadows
  static const List<BoxShadow> buttonShadow = [
    BoxShadow(
      color: Color(0x2D000000),
      offset: Offset(0, 3),
      blurRadius: 6,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> buttonShadowHovered = [
    BoxShadow(
      color: Color(0x3A000000),
      offset: Offset(0, 6),
      blurRadius: 12,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> buttonShadowPressed = [
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];

  // Dialog shadows
  static const List<BoxShadow> dialogShadow = [
    BoxShadow(
      color: Color(0x4D000000), // 30% opacity
      offset: Offset(0, 12),
      blurRadius: 24,
      spreadRadius: -4,
    ),
  ];

  // Menu/Dropdown shadows
  static const List<BoxShadow> menuShadow = [
    BoxShadow(
      color: Color(0x33000000),
      offset: Offset(0, 5),
      blurRadius: 10,
      spreadRadius: -2,
    ),
  ];

  /// Get shadow based on elevation level
  static List<BoxShadow> getElevationShadow(int elevation) {
    switch (elevation) {
      case 0:
        return elevation0Shadow;
      case 1:
        return elevation1Shadow;
      case 2:
        return elevation2Shadow;
      case 3:
        return elevation3Shadow;
      case 4:
        return elevation4Shadow;
      case 5:
        return elevation5Shadow;
      default:
        return elevation0Shadow;
    }
  }

  /// Get shadow for interactive states
  static List<BoxShadow> getInteractiveShadow({
    required bool isPressed,
    required bool isHovered,
    required bool isEnabled,
    bool isButton = false,
  }) {
    if (!isEnabled) {
      return elevation0Shadow;
    }

    if (isPressed) {
      return isButton ? buttonShadowPressed : cardShadowPressed;
    }

    if (isHovered) {
      return isButton ? buttonShadowHovered : cardShadowHovered;
    }

    return isButton ? buttonShadow : cardShadow;
  }

  /// Create custom shadow
  static BoxShadow createCustomShadow({
    required Color color,
    Offset offset = const Offset(0, 0),
    double blurRadius = 4.0,
    double spreadRadius = 0.0,
  }) {
    return BoxShadow(
      color: color,
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
    );
  }

  /// Create glow effect
  static List<BoxShadow> createGlowEffect({
    required Color color,
    double intensity = 1.0,
  }) {
    return [
      BoxShadow(
        color: color.withValues(alpha: 0.5 * intensity),
        blurRadius: 20 * intensity,
        spreadRadius: 2 * intensity,
      ),
    ];
  }
}

