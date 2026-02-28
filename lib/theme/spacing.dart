/// Production-ready spacing and sizing system for Blood Bank App
/// Follows Material Design 3 spacing scale
/// Ensures consistency across all UI components

class AppSpacing {
  // Base spacing unit (8dp)
  static const double baseUnit = 8.0;

  // Padding & Margins
  static const double xs = 4.0; // 0.5 unit
  static const double sm = 8.0; // 1 unit
  static const double md = 12.0; // 1.5 units
  static const double lg = 16.0; // 2 units
  static const double xl = 24.0; // 3 units
  static const double xxl = 32.0; // 4 units
  static const double xxxl = 48.0; // 6 units

  // Screen-level padding
  static const double screenPaddingHorizontal = lg; // 16dp
  static const double screenPaddingVertical = xl; // 24dp
  static const double screenPaddingSmall = sm; // 8dp

  // Component sizes
  static const double componentSmall = 32.0;
  static const double componentMedium = 40.0;
  static const double componentLarge = 48.0;
  static const double componentExtraLarge = 56.0;

  // Icon sizes
  static const double iconSmall = 16.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;
  static const double iconExtraLarge = 48.0;

  // Touch target sizes (minimum 48dp x 48dp for accessibility)
  static const double touchTargetMinimum = 48.0;
  static const double touchTargetCompact = 40.0;

  // Card & Container spacing
  static const double cardPadding = lg; // 16dp
  static const double cardMargin = md; // 12dp
  static const double cardSpacing = lg; // 16dp between cards

  // Input fields
  static const double inputHeight = 48.0;
  static const double inputCompactHeight = 40.0;
  static const double inputPaddingHorizontal = lg; // 16dp
  static const double inputPaddingVertical = md; // 12dp
  static const double inputBorderRadius = md; // 12dp

  // Button dimensions
  static const double buttonHeightLarge = 56.0;
  static const double buttonHeightMedium = 48.0;
  static const double buttonHeightSmall = 40.0;
  static const double buttonPaddingHorizontal = xl; // 24dp
  static const double buttonPaddingVertical = lg; // 16dp
  static const double buttonBorderRadius = lg; // 16dp

  // Chips & Tags
  static const double chipHeight = 32.0;
  static const double chipPaddingHorizontal = md; // 12dp
  static const double chipPaddingVertical = sm; // 8dp
  static const double chipBorderRadius = 16.0; // 16dp (full rounded)

  // AppBar dimensions
  static const double appBarHeight = 56.0;
  static const double appBarLargeHeight = 152.0;
  static const double appBarExtendedHeight = 200.0;

  // Bottom navigation
  static const double bottomNavHeight = 80.0;
  static const double bottomNavItemSize = 40.0;

  // Dialog & Sheet spacing
  static const double dialogPadding = xl; // 24dp
  static const double dialogElevation = lg; // 16dp
  static const double bottomSheetPadding = xl; // 24dp

  // Divider spacing
  static const double dividerThickness = 1.0;
  static const double dividerPadding = lg; // 16dp

  // Snackbar spacing
  static const double snackbarPaddingHorizontal = lg; // 16dp
  static const double snackbarPaddingVertical = md; // 12dp
  static const double snackbarMarginBottom = xl; // 24dp

  // Animation-related spacing
  static const double animationStartMargin = xl; // 24dp
  static const double particleSize = 4.0;
  static const double particleMaxSize = 8.0;

  // Blood bank specific
  static const double bloodTypeTileSize = 120.0;
  static const double bloodTypeSmallTileSize = 80.0;
  static const double emergencyButtonSize = 80.0;
  static const double emergencyGlowSize = 120.0;

  // Responsive breakpoints
  static const double mobileMaxWidth = 480.0;
  static const double tabletMinWidth = 600.0;
  static const double tabletMaxWidth = 840.0;
  static const double desktopMinWidth = 1200.0;

  // Layout constraints
  static const double maxContentWidth = 600.0;
  static const double maxCardWidth = 400.0;

  // List/Grid spacing
  static const double listItemHeight = 64.0;
  static const double listItemCompactHeight = 48.0;
  static const double gridSpacing = md; // 12dp
  static const double gridHorizontalSpacing = md; // 12dp
  static const double gridVerticalSpacing = md; // 12dp

  // Border radius
  static const double borderRadiusSmall = 6.0;
  static const double borderRadiusMedium = 12.0;
  static const double borderRadiusLarge = 16.0;
  static const double borderRadiusExtraLarge = 24.0;
  static const double borderRadiusFull = 9999.0; // Fully rounded

  // Stroke width
  static const double strokeThin = 0.5;
  static const double strokeRegular = 1.0;
  static const double strokeMedium = 1.5;
  static const double strokeThick = 2.0;

  // Opacity levels
  static const double opacityDisabled = 0.38;
  static const double opacityLight = 0.12;
  static const double opacityMedium = 0.38;
  static const double opacityHigh = 0.87;
  static const double opacityFull = 1.0;

  /// Get responsive padding based on screen width
  static double getResponsivePadding(double screenWidth) {
    if (screenWidth < mobileMaxWidth) {
      return sm; // 8dp on small screens
    } else if (screenWidth < tabletMinWidth) {
      return md; // 12dp on medium screens
    } else {
      return lg; // 16dp on large screens
    }
  }

  /// Get responsive font size based on screen width
  static double getResponsiveFontSize(double baseSize, double screenWidth) {
    if (screenWidth < mobileMaxWidth) {
      return baseSize * 0.9;
    } else if (screenWidth < tabletMinWidth) {
      return baseSize;
    } else {
      return baseSize * 1.1;
    }
  }

  /// Get responsive icon size based on screen width
  static double getResponsiveIconSize(double screenWidth) {
    if (screenWidth < mobileMaxWidth) {
      return iconSmall;
    } else if (screenWidth < tabletMinWidth) {
      return iconMedium;
    } else {
      return iconLarge;
    }
  }
}
