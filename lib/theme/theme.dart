import 'package:flutter/material.dart';
import 'colors.dart';
import 'typography.dart';
import 'spacing.dart';
import 'shadows.dart';
import 'animations.dart';

/// Production-ready Material Design 3 theme for Blood Bank App
/// Integrates color, typography, spacing, and animation systems
/// Provides consistent design language across entire application

class AppTheme {
  // Private constructor - static access only
  AppTheme._();

  /// Light theme data
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.textInverse,
        primaryContainer: AppColors.primary100,
        onPrimaryContainer: AppColors.primary800,
        secondary: AppColors.secondary,
        onSecondary: AppColors.textInverse,
        secondaryContainer: AppColors.secondary100,
        onSecondaryContainer: AppColors.secondary800,
        tertiary: AppColors.tertiary,
        onTertiary: AppColors.textInverse,
        tertiaryContainer: AppColors.tertiary100,
        onTertiaryContainer: AppColors.tertiary800,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        surfaceVariant: AppColors.surfaceVariant,
        onSurfaceVariant: AppColors.textSecondary,
        outline: AppColors.outline,
        outlineVariant: AppColors.outlineVariant,
        background: AppColors.background,
        onBackground: AppColors.textPrimary,
        error: AppColors.error,
        onError: AppColors.textInverse,
        errorContainer: AppColors.errorContainers,
        onErrorContainer: AppColors.error,
        scrim: AppColors.scrimDark,
      ),
      textTheme: AppTypography.getTextTheme(),
      scaffoldBackgroundColor: AppColors.background,

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTypography.headlineSmall,
        toolbarTextStyle: AppTypography.bodyMedium,
        surfaceTintColor: AppColors.primary,
        shadowColor: AppColors.scrimLight,
      ),

      // Card Theme
      cardTheme: CardTheme(
        backgroundColor: AppColors.surface,
        surfaceTintColor: AppColors.primary,
        elevation: 1,
        shadowColor: AppColors.scrimLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
        ),
        margin: const EdgeInsets.all(AppSpacing.cardMargin),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textInverse,
        elevation: 6,
        splashColor: AppColors.primary200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusLarge),
        ),
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textInverse,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.buttonPaddingHorizontal,
            vertical: AppSpacing.buttonPaddingVertical,
          ),
          minimumSize: const Size(
            double.infinity,
            AppSpacing.buttonHeightMedium,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.buttonBorderRadius),
          ),
          elevation: 4,
          shadowColor: AppColors.scrimMedium,
          textStyle: AppTypography.buttonLarge,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.buttonPaddingHorizontal,
            vertical: AppSpacing.buttonPaddingVertical,
          ),
          minimumSize: const Size(
            double.infinity,
            AppSpacing.buttonHeightMedium,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.buttonBorderRadius),
            side: const BorderSide(color: AppColors.primary, width: 2),
          ),
          side: const BorderSide(color: AppColors.primary),
          textStyle: AppTypography.buttonLarge,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.buttonPaddingHorizontal,
            vertical: AppSpacing.buttonPaddingVertical,
          ),
          textStyle: AppTypography.buttonLarge,
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceVariant,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.inputPaddingHorizontal,
          vertical: AppSpacing.inputPaddingVertical,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.inputBorderRadius),
          borderSide: const BorderSide(color: AppColors.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.inputBorderRadius),
          borderSide: const BorderSide(
            color: AppColors.outlineVariant,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.inputBorderRadius),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.inputBorderRadius),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.inputBorderRadius),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.inputBorderRadius),
          borderSide: const BorderSide(color: AppColors.textDisabled, width: 1),
        ),
        labelStyle: AppTypography.inputLabel,
        hintStyle: AppTypography.inputHint,
        errorStyle: AppTypography.errorMessage,
        helperStyle: AppTypography.bodySmall,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        isDense: false,
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceVariant,
        disabledColor: AppColors.textDisabled,
        selectedColor: AppColors.primary,
        secondarySelectedColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.chipPaddingHorizontal,
          vertical: AppSpacing.chipPaddingVertical,
        ),
        labelStyle: AppTypography.labelLarge,
        secondaryLabelStyle: AppTypography.labelLarge.copyWith(
          color: AppColors.textInverse,
        ),
        brightness: Brightness.light,
        elevation: 1,
        shadowColor: AppColors.scrimLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.chipBorderRadius),
        ),
      ),

      // Dialog Theme
      dialogTheme: DialogTheme(
        backgroundColor: AppColors.surface,
        elevation: 5,
        shadowColor: AppColors.scrimDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusLarge),
        ),
        titleTextStyle: AppTypography.headlineSmall,
        contentTextStyle: AppTypography.bodyMedium,
        actionsPadding: const EdgeInsets.all(AppSpacing.lg),
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.surface,
        shadowColor: AppColors.scrimDark,
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSpacing.borderRadiusLarge),
            topRight: Radius.circular(AppSpacing.borderRadiusLarge),
          ),
        ),
        modalElevation: 5,
        modalBackgroundColor: AppColors.surface,
      ),

      // Snackbar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.textPrimary,
        contentTextStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.textInverse,
        ),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
        ),
        behavior: SnackBarBehavior.floating,
        actionTextColor: AppColors.primary200,
      ),

      // Navigation Bar Theme
      navigationBarTheme: NavigationBarThemeData(
        height: AppSpacing.bottomNavHeight,
        backgroundColor: AppColors.surface,
        elevation: 8,
        shadowColor: AppColors.scrimMedium,
        surfaceTintColor: AppColors.primary,
        labelTextStyle: MaterialStatePropertyAll(
          AppTypography.labelSmall.copyWith(fontSize: 12),
        ),
        iconTheme: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return IconThemeData(
              color: AppColors.primary,
              size: AppSpacing.iconMedium,
            );
          }
          return IconThemeData(
            color: AppColors.textSecondary,
            size: AppSpacing.iconMedium,
          );
        }),
        indicatorColor: AppColors.primary100,
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        elevation: 8,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        selectedLabelStyle: AppTypography.labelSmall,
        unselectedLabelStyle: AppTypography.labelSmall,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        enableFeedback: true,
      ),

      // Tab Bar Theme
      tabBarTheme: TabBarTheme(
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: AppTypography.labelLarge,
        unselectedLabelStyle: AppTypography.labelMedium,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: AppColors.primary,
            width: AppSpacing.strokeMedium,
          ),
          insets: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        ),
        dividerColor: AppColors.outlineVariant,
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStatePropertyAll(AppColors.primary),
        trackColor: MaterialStatePropertyAll(AppColors.primary200),
        splashRadius: 20,
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStatePropertyAll(AppColors.primary),
        checkColor: MaterialStatePropertyAll(AppColors.textInverse),
        side: const BorderSide(color: AppColors.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSmall),
        ),
      ),

      // Radio Theme
      radioTheme: RadioThemeData(
        fillColor: MaterialStatePropertyAll(AppColors.primary),
        overlayColor: MaterialStatePropertyAll(
          AppColors.primary.withOpacity(0.1),
        ),
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearMinHeight: 4,
        circularTrackColor: AppColors.primary100,
        refreshBackgroundColor: AppColors.background,
      ),

      // Slider Theme
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.primary,
        inactiveTrackColor: AppColors.primary100,
        thumbColor: AppColors.primary,
        overlayColor: AppColors.primary.withOpacity(0.12),
        valueIndicatorColor: AppColors.primary,
        valueIndicatorTextStyle: AppTypography.bodySmall.copyWith(
          color: AppColors.textInverse,
        ),
        trackHeight: 4.0,
        showValueIndicator: ShowValueIndicator.onInteraction,
        disabledActiveTrackColor: AppColors.textDisabled,
        disabledInactiveTrackColor: AppColors.textDisabled,
        disabledThumbColor: AppColors.textDisabled,
      ),

      // Tooltip Theme
      tooltipTheme: TooltipThemeData(
        textStyle: AppTypography.bodySmall.copyWith(
          color: AppColors.textInverse,
        ),
        decoration: BoxDecoration(
          color: AppColors.textPrimary,
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSmall),
          boxShadow: AppShadows.elevation3Shadow,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        margin: const EdgeInsets.all(AppSpacing.md),
        verticalOffset: AppSpacing.lg,
        preferBelow: true,
        showDuration: const Duration(milliseconds: 3000),
        waitDuration: const Duration(milliseconds: 200),
      ),

      // Icon Theme
      iconTheme: IconThemeData(
        color: AppColors.textPrimary,
        size: AppSpacing.iconMedium,
      ),

      // Page Transition Animation
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
        },
      ),

      // Interaction Model
      interactions: [const LongPressMoveUpdateGestureRecognizer()],

      // Other Settings
      visualDensity: VisualDensity.adaptivePlatformDensity,
      useMaterial3: true,
      applyElevationOverlayColor: true,
    );
  }

  /// Dark theme data (future enhancement)
  static ThemeData get darkTheme {
    // TODO: Implement dark theme variant
    return lightTheme.copyWith(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
    );
  }

  /// Create custom theme with custom primary color
  static ThemeData createCustomTheme({
    required Color primaryColor,
    Brightness brightness = Brightness.light,
  }) {
    final baseTheme = brightness == Brightness.light ? lightTheme : darkTheme;
    return baseTheme.copyWith(
      colorScheme: baseTheme.colorScheme.copyWith(
        primary: primaryColor,
        surface: brightness == Brightness.light
            ? AppColors.surface
            : AppColors.darkSurface,
      ),
    );
  }
}

/// Helper class for theme utilities
class ThemeHelper {
  // Private constructor
  ThemeHelper._();

  /// Check if dark mode is enabled
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  /// Get contrasting text color based on background
  static Color getTextColorForBackground(Color backgroundColor) {
    // Calculate luminance
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? AppColors.textPrimary : AppColors.textInverse;
  }

  /// Apply elevation shadow
  static List<BoxShadow> getElevationShadow(int elevation) {
    return AppShadows.getElevationShadow(elevation);
  }

  /// Get responsive spacing
  static double getResponsiveSpacing(
    BuildContext context, {
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    final width = MediaQuery.of(context).size.width;
    if (width < AppSpacing.tabletMinWidth) {
      return mobile;
    } else if (width < AppSpacing.desktopMinWidth) {
      return tablet;
    } else {
      return desktop;
    }
  }
}
