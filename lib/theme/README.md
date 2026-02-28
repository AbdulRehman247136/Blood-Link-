# 🎨 Blood Bank App Design System

Production-ready Material Design 3 design system for the Blood Bank Flutter application. This system ensures consistency, accessibility, and Play Store compliance across all UI components.

## 📂 File Structure

```
lib/theme/
├── colors.dart          # Color palette & blood type colors
├── typography.dart      # Text styles & font system
├── spacing.dart         # Spacing, sizing & responsive breakpoints
├── shadows.dart         # Elevations & shadow effects
├── animations.dart      # Animation durations & curves
├── theme.dart          # Main Material Design 3 theme
└── README.md           # This file
```

## 🎯 Quick Start

### 1. Apply Theme to Your App

Update your `main.dart`:

```dart
import 'package:flutter/material.dart';
import 'theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Bank',
      theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme, // Future enhancement
      home: const HomeScreen(),
    );
  }
}
```

### 2. Use Colors

```dart
import 'package:flutter/material.dart';
import 'theme/colors.dart';

Container(
  color: AppColors.primary,        // Main red
  child: Text(
    'Emergency',
    style: TextStyle(color: AppColors.textInverse),
  ),
)
```

### 3. Use Typography

```dart
import 'theme/typography.dart';

Text(
  'Find Blood Donors',
  style: AppTypography.headlineLarge,
)

Text(
  'Tap to request emergency blood',
  style: AppTypography.bodySmall,
)
```

### 4. Use Spacing

```dart
import 'theme/spacing.dart';

Padding(
  padding: const EdgeInsets.all(AppSpacing.lg),  // 16dp
  child: ElevatedButton(
    onPressed: () {},
    child: const Text('Request Blood'),
  ),
)
```

### 5. Use Shadows & Elevation

```dart
import 'theme/shadows.dart';

Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: AppShadows.elevation2Shadow,
  ),
  child: const Text('Card Content'),
)
```

### 6. Use Animations

```dart
import 'theme/animations.dart';

AnimatedContainer(
  duration: AppAnimations.standard,
  curve: AppAnimations.easeOutCurve,
  color: Colors.red,
  child: const Text('Animated'),
)
```

---

## 📋 Design System Components

### Colors (`colors.dart`)

**Primary Colors (Medical Red)**
- `AppColors.primary` - Main red (#D32F2F)
- `AppColors.primary50` to `primary900` - Shade variations

**Status Colors**
- `AppColors.success` - Green (#4CAF50)
- `AppColors.warning` - Yellow (#FFC107)
- `AppColors.error` - Red (#F44336)
- `AppColors.info` - Blue (#2196F3)

**Emergency Mode**
- `AppColors.emergencyRed` - Alert red
- `AppColors.emergencyGlow` - Glow effect
- `AppColors.emergencyLight` - Background tint

**Blood Type Colors**
```dart
AppColors.urgencyO        // O- (Green)
AppColors.urgencyAPos     // A+ (Blue)
AppColors.urgencyBPos     // B+ (Orange)
AppColors.urgencyABNeg    // AB- (Cyan)
// ... and more
```

**Get blood type color dynamically:**
```dart
Color typeColor = AppColors.getBloodTypeColor('A_POSITIVE');
```

---

### Typography (`typography.dart`)

**Display Styles (Headlines)**
```dart
AppTypography.displayLarge    // 57sp, bold (main titles)
AppTypography.displayMedium   // 45sp, bold
AppTypography.displaySmall    // 36sp, bold
```

**Heading Styles**
```dart
AppTypography.headlineLarge   // 28sp, bold (section titles)
AppTypography.headlineMedium  // 24sp, semibold
AppTypography.headlineSmall   // 20sp, semibold
```

**Title Styles**
```dart
AppTypography.titleLarge      // 18sp, semibold (card titles)
AppTypography.titleMedium     // 16sp, semibold
AppTypography.titleSmall      // 14sp, semibold
```

**Body Styles**
```dart
AppTypography.bodyLarge       // 16sp, regular (main content)
AppTypography.bodyMedium      // 14sp, regular
AppTypography.bodySmall       // 12sp, regular (captions)
```

**Blood Bank Specific**
```dart
AppTypography.bloodTypeHero    // 48sp, bold (blood type display)
AppTypography.emergencyTitle   // 24sp, bold, emergency red
AppTypography.urgencyBadge     // 12sp, bold (badge text)
```

**Accessibility Helpers:**
```dart
AppTypography.largeText(style)       // Enlarge for low vision
AppTypography.boldText(style)        // Make text bolder
AppTypography.disabledText(style)    // Dim disabled text
```

---

### Spacing (`spacing.dart`)

**Base Units**
```dart
AppSpacing.xs    // 4dp
AppSpacing.sm    // 8dp
AppSpacing.md    // 12dp
AppSpacing.lg    // 16dp (standard padding)
AppSpacing.xl    // 24dp
AppSpacing.xxl   // 32dp
AppSpacing.xxxl  // 48dp
```

**Component Sizes**
```dart
AppSpacing.componentSmall       // 32dp (small button)
AppSpacing.componentMedium      // 40dp (medium button)
AppSpacing.componentLarge       // 48dp (large button)
AppSpacing.componentExtraLarge  // 56dp (extra large)
```

**Touch Targets (Accessibility - minimum 48dp)**
```dart
AppSpacing.touchTargetMinimum  // 48dp
AppSpacing.touchTargetCompact  // 40dp
```

**Button Dimensions**
```dart
AppSpacing.buttonHeightLarge    // 56dp
AppSpacing.buttonHeightMedium   // 48dp
AppSpacing.buttonHeightSmall    // 40dp
AppSpacing.buttonBorderRadius   // 16dp
AppSpacing.buttonPaddingHorizontal // 24dp
```

**Input Fields**
```dart
AppSpacing.inputHeight          // 48dp
AppSpacing.inputCompactHeight   // 40dp
AppSpacing.inputPaddingHorizontal // 16dp
AppSpacing.inputBorderRadius    // 12dp
```

**Responsive Functions:**
```dart
// Get padding based on screen width
double padding = AppSpacing.getResponsivePadding(screenWidth);

// Get responsive font size
double fontSize = AppSpacing.getResponsiveFontSize(14, screenWidth);

// Get responsive icon size
double iconSize = AppSpacing.getResponsiveIconSize(screenWidth);
```

---

### Shadows & Elevation (`shadows.dart`)

**Elevation Levels**
```dart
AppShadows.elevation0Shadow  // No shadow (flat)
AppShadows.elevation1Shadow  // Subtle (cards)
AppShadows.elevation2Shadow  // Regular (FAB)
AppShadows.elevation3Shadow  // Prominent (dialogs)
AppShadows.elevation4Shadow  // Deep (modals)
AppShadows.elevation5Shadow  // Maximum (alerts)
```

**Colored Shadows**
```dart
AppShadows.primaryShadow     // Red tint
AppShadows.emergencyShadow   // Emergency red glow
AppShadows.successShadow     // Green tint
```

**Glow Effects**
```dart
AppShadows.glowRed           // Red glow
AppShadows.glowRedIntense    // Strong red glow
AppShadows.glowOrange        // Orange glow
AppShadows.glowGreen         // Green glow
```

**Component-Specific**
```dart
AppShadows.cardShadow        // Light shadow
AppShadows.cardShadowHovered // Elevated on hover
AppShadows.cardShadowPressed // Reduced on press

AppShadows.buttonShadow      // Button elevation
AppShadows.buttonShadowHovered // Elevated on hover

AppShadows.dialogShadow      // Dialog modal shadow
AppShadows.menuShadow        // Dropdown menu shadow
```

**Usage:**
```dart
Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: AppShadows.elevation2Shadow,
  ),
)

// Get shadow by elevation level
boxShadow: AppShadows.getElevationShadow(3),

// Get interactive state shadow
boxShadow: AppShadows.getInteractiveShadow(
  isPressed: isPressed,
  isHovered: isHovered,
  isEnabled: isEnabled,
  isButton: true,
),
```

---

### Animations (`animations.dart`)

**Durations**
```dart
// Quick feedback
AppAnimations.quick        // 100ms
AppAnimations.short        // 150ms
AppAnimations.standard     // 200ms (most common)
AppAnimations.medium       // 300ms
AppAnimations.long         // 400ms

// Long-running
AppAnimations.lengthy      // 600ms
AppAnimations.backgroundSlow // 1000ms

// Feature-specific
AppAnimations.emergencyPulse // 600ms
AppAnimations.heartbeat      // 800ms
AppAnimations.pageTransition // 300ms
```

**Curves**
```dart
AppAnimations.easeOutCurve       // Standard entrance
AppAnimations.accelerateCurve    // Exit (ease-in)
AppAnimations.emphasizedCurve    // Important transitions
AppAnimations.pageTransitionCurve // Page transitions
AppAnimations.elasticOutCurve    // Bounce effect
```

**Usage:**
```dart
AnimatedContainer(
  duration: AppAnimations.standard,
  curve: AppAnimations.easeOutCurve,
  color: Colors.red,
)

// Stagger animations for sequences
Future.delayed(
  AppAnimations.getStaggerDelay(index),
  () => setState(() {}),
)
```

**Pre-configured AnimationTiming:**
```dart
AnimationTiming.entrance           // 200ms, ease-out
AnimationTiming.emphasis           // 300ms, emphasized
AnimationTiming.emergency          // 600ms, emergency curve
AnimationTiming.pageTransition     // 300ms, page slide
AnimationTiming.cardFlip           // 500ms, ease-in-out
AnimationTiming.buttonPress        // 100ms, button curve
AnimationTiming.heartbeat          // 800ms, heartbeat curve
```

**Accessibility support (reduced motion):**
```dart
final timing = AnimationTiming.entrance;
final accessibleTiming = timing.withAccessibilityReduction();
// Returns: 50ms, linear (respects prefers-reduced-motion)
```

---

### Complete Theme (`theme.dart`)

**Apply to MaterialApp:**
```dart
MaterialApp(
  theme: AppTheme.lightTheme,
)
```

**Theme includes pre-configured:**
- ✅ AppBar styling
- ✅ Card theming
- ✅ Button styles (Elevated, Outlined, Text)
- ✅ Input field decoration
- ✅ Chip & Dialog theming
- ✅ Navigation bar styles
- ✅ Tab bar styling
- ✅ Progress indicators
- ✅ Switch, Checkbox, Radio themes
- ✅ Tooltip theming
- ✅ Page transition animations

**Helper utilities:**
```dart
// Check if dark mode
bool isDark = ThemeHelper.isDarkMode(context);

// Get contrasting text color for any background
Color textColor = ThemeHelper.getTextColorForBackground(bgColor);

// Get responsive spacing
double spacing = ThemeHelper.getResponsiveSpacing(
  context,
  mobile: 8,
  tablet: 12,
  desktop: 16,
);
```

---

## 🎯 Play Store Optimization Checklist

Using this design system ensures:

- ✅ **Consistent branding** - One source of truth for colors, fonts, spacing
- ✅ **Accessibility** - Minimum 48dp touch targets, proper contrast ratios
- ✅ **Performance** - Optimized shadows, efficient animations (< 300ms standard)
- ✅ **Responsiveness** - Adaptive spacing and fonts for all screen sizes
- ✅ **Material Design 3** - Latest Google design standards
- ✅ **User trust** - Professional, polished appearance
- ✅ **Maintainability** - Easy to update globally

---

## 🚀 Advanced Usage

### Custom Theme Variant
```dart
final customTheme = AppTheme.createCustomTheme(
  primaryColor: Color(0xFF8B0000), // Dark blood red
  brightness: Brightness.light,
);
```

### Create custom color combination
```dart
final bloodGradient = const LinearGradient(
  colors: AppColors.bloodGradient,
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
```

### Create emergency pulse animation
```dart
AnimationController pulseController = AnimationController(
  duration: AppAnimations.emergencyPulse,
  vsync: this,
);
pulseController.repeat();

ScaleTransition(
  scale: Tween<double>(begin: 1.0, end: 1.2).animate(
    CurvedAnimation(
      parent: pulseController,
      curve: AppAnimations.emergencyEaseCurve,
    ),
  ),
  child: Container(
    width: 80,
    height: 80,
    decoration: BoxDecoration(
      color: AppColors.emergencyRed,
      borderRadius: BorderRadius.circular(40),
      boxShadow: AppShadows.glowRedIntense,
    ),
  ),
)
```

### Responsive layout with breakpoints
```dart
final screenWidth = MediaQuery.of(context).size.width;
final isTablet = screenWidth >= AppSpacing.tabletMinWidth;
final isDesktop = screenWidth >= AppSpacing.desktopMinWidth;

return isTablet
    ? GridView.count(childAspectRatio: 2.0, mainAxisSpacing: AppSpacing.lg)
    : ListView(children: []);
```

---

## 📱 Breaking Changes & Migrations

### From custom styles to design system

**Before:**
```dart
Text(
  'Title',
  style: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Color(0xFFD32F2F),
  ),
)
```

**After:**
```dart
Text(
  'Title',
  style: AppTypography.headlineLarge,
)
```

---

## 🔄 Future Enhancements

- [ ] Dark theme variant
- [ ] Accessibility high-contrast mode
- [ ] Custom theme builder UI
- [ ] Animation preset animations library
- [ ] Neumorphism style variants

---

## 📞 Support

For design system updates or issues:
1. Update the relevant `_*.dart` file in `lib/theme/`
2. Export from `theme.dart` if creating new module
3. Update this README with new components
4. Run `flutter analyze` to check for conflicts

---

**Design System Version:** 1.0.0  
**Material Design Version:** 3.0  
**Last Updated:** February 2026  
**Status:** Production Ready ✅
