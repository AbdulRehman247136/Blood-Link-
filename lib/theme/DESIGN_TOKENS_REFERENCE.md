# 🎨 Design Tokens Quick Reference

**Fast lookup guide for all design system values. When you need a specific token, find it here.**

---

## 🎨 Colors at a Glance

### Primary Colors (Medical Red)
```
AppColors.primary           #D32F2F    Used for: Main actions, primary buttons
AppColors.primary600        #C62828    Used for: Pressed state, dark variant
AppColors.primary700        #B71C1C    Used for: Hover state
AppColors.primary800        #8B0000    Used for: Dark blood red
AppColors.primary900        #5C0000    Used for: Darkest variant
```

### Secondary Colors (Orange)
```
AppColors.secondary         #F57C00    Used for: Secondary actions, heat
AppColors.secondary700      #E65100    Used for: Secondary pressed
AppColors.secondary800      #BF360C    Used for: Secondary dark
```

### Tertiary Colors (Teal)
```
AppColors.tertiary          #00897B    Used for: Positive actions, accents
AppColors.tertiary700       #00796B    Used for: Pressed state
AppColors.tertiary800       #004D40    Used for: Dark variant
```

### Status Colors
```
AppColors.success           #4CAF50    ✅ Positive actions, completion
AppColors.warning           #FFC107    ⚠️  Caution, alerts
AppColors.error             #F44336    ❌ Errors, critical
AppColors.info              #2196F3    ℹ️  Information, help
```

### Emergency & Text
```
AppColors.emergencyRed      #D32F2F    🚨 Emergency alerts
AppColors.emergencyGlow     #EF5350    ✨ Emergency glow effect
AppColors.textPrimary       #212121    Primary text (dark gray)
AppColors.textSecondary     #757575    Secondary text (medium gray)
AppColors.textInverse       #FFFFFF    Text on colored backgrounds
```

### Backgrounds
```
AppColors.surface           #FFFFFF    Card backgrounds
AppColors.background        #FAFAFA    Screen background
AppColors.surfaceVariant    #F5F5F5    Input field background
```

---

## 📐 Spacing System (8dp base unit)

### Quick Space Reference
```
AppSpacing.xs       4dp     (0.5 unit) - Icon padding, tight spacing
AppSpacing.sm       8dp     (1 unit)   - Small padding, dividers
AppSpacing.md       12dp    (1.5 units)- Medium padding, list gaps
AppSpacing.lg       16dp    (2 units)  - Standard padding (MOST COMMON)
AppSpacing.xl       24dp    (3 units)  - Large padding, section gaps
AppSpacing.xxl      32dp    (4 units)  - Extra large gaps
AppSpacing.xxxl     48dp    (6 units)  - Screen-level gaps
```

### Component Sizing
```
AppSpacing.buttonHeightSmall     40dp    - Compact button
AppSpacing.buttonHeightMedium    48dp    - Standard button
AppSpacing.buttonHeightLarge     56dp    - Large button
AppSpacing.inputHeight           48dp    - Form field height
AppSpacing.touchTargetMinimum    48dp    - Minimum tap area
```

### Border Radius
```
AppSpacing.borderRadiusSmall    6dp     - Subtle rounding
AppSpacing.borderRadiusMedium   12dp    - Standard rounding
AppSpacing.borderRadiusLarge    16dp    - Prominent rounding
AppSpacing.borderRadiusFull     9999dp  - Fully rounded (pills)
```

---

## 🔤 Typography Sizes & Weights

### Display Styles (Largest)
```
displayLarge    57sp  W700  Used for: App title page headers
displayMedium   45sp  W700  Used for: Large section headers
displaySmall    36sp  W700  Used for: Secondary page title
```

### Headline Styles
```
headlineLarge   28sp  W700  Used for: Main section title
headlineMedium  24sp  W600  Used for: Sub-section title
headlineSmall   20sp  W600  Used for: Tertiary title
```

### Title Styles
```
titleLarge      18sp  W600  Used for: Card title
titleMedium     16sp  W600  Used for: List item title
titleSmall      14sp  W600  Used for: Badge/chip text
```

### Body Styles
```
bodyLarge       16sp  W400  Used for: Main paragraph text
bodyMedium      14sp  W400  Used for: Supporting text
bodySmall       12sp  W400  Used for: Caption/helper text (MIN SIZE)
```

### Label Styles
```
labelLarge      14sp  W600  Used for: Button text
labelMedium     12sp  W600  Used for: Small button/tag
labelSmall      11sp  W600  Used for: Tiny label
```

### Special Styles
```
bloodTypeHero       48sp  W800  Used for: Blood type display
emergencyTitle      24sp  W800  Used for: Emergency alerts
urgencyBadge        12sp  W700  Used for: Status badges
```

---

## ⏱️ Animation Durations

### Quick Reference (in milliseconds)
```
quick           100ms   - Quick feedback (ripples, taps)
short           150ms   - Short transitions
standard        200ms   - STANDARD (use most often)
medium          300ms   - Medium transitions
long            400ms   - Longer transitions
lengthyShort    500ms   - Extended animation
lengthy         600ms   - Background animations

Emergency-specific:
emergencyPulse  600ms   - Pulse heartbeat
pageTransition  300ms   - Page slide
buttonRipple    200ms   - Material ripple
heartbeat       800ms   - Heartbeat animation
```

### Easing Curves
```
easeOutCurve        - Smooth entrance (cubic-bezier(0.2, 0, 0, 1))
accelerateCurve     - Quick exit (ease-in)
emphasizedCurve     - Important emphasis transitions
pageTransitionCurve - Page route transitions
elasticOutCurve     - Bouncy effect
```

---

## 🎭 Shadow System

### Elevation Shadows
```
elevation0   L 0  - No shadow, flat
elevation1   L 1  - Subtle, cards
elevation2   L 2  - Regular, FAB
elevation3   L 3  - Prominent, dialogs
elevation4   L 4  - Deep, modals
elevation5   L 5  - Maximum, alerts
```

### Colored Shadows
```
primaryShadow       - Red shadow (20% opacity)
emergencyShadow     - Red glow (40% opacity)
successShadow       - Green shadow (20% opacity)
```

### Component-Specific
```
cardShadow          - Light shadow (elevation 1)
buttonShadow        - Button elevation
dialogShadow        - Modal dialog shadow
menuShadow          - Dropdown/menu shadow
```

### Glow Effects
```
glowRed             - Soft red glow
glowRedIntense      - Strong red glow
glowOrange          - Orange glow
glowGreen           - Green glow
```

---

## 📱 Responsive Breakpoints

### Screen Width Breakpoints
```
< 480px         Small phone (320-479)
480-600px       Regular phone (480-599)
600-840px       Tablet portrait (600-839)
840-1200px      Tablet landscape (840-1199)
≥ 1200px        Desktop (1200+)
```

### Responsive Function Selection
```
For padding:    AppSpacing.getResponsivePadding(screenWidth)
For font:       AppSpacing.getResponsiveFontSize(size, screenWidth)
For icons:      AppSpacing.getResponsiveIconSize(screenWidth)
```

---

## 🩸 Blood Type Colors (Dynamic)

Use: `AppColors.getBloodTypeColor('A_POSITIVE')`

```
O- (O Negative)     #4CAF50   Green   - Most needed
O+ (O Positive)     #4CAF50   Green   - Common universal
A+ (A Positive)     #2196F3   Blue    - Common
A- (A Negative)     #9C27B0   Purple  - Less common
B+ (B Positive)     #FF9800   Orange  - Less common
B- (B Negative)     #F44336   Red     - Rare
AB+ (AB Positive)   #FFC107   Amber   - Rare
AB- (AB Negative)   #00BCD4   Cyan    - Rarest
```

---

## 🎯 Common Patterns

### Emergency Button
```dart
Container(
  decoration: BoxDecoration(
    color: AppColors.emergencyRed,
    borderRadius: BorderRadius.circular(AppSpacing.borderRadiusLarge),
    boxShadow: AppShadows.glowRedIntense,
  ),
  padding: EdgeInsets.all(AppSpacing.xl),
  child: Text('EMERGENCY', style: AppTypography.emergencyTitle),
)
```

### Card with Hover
```dart
Container(
  decoration: BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
    boxShadow: isHovered ? AppShadows.cardShadowHovered : AppShadows.cardShadow,
  ),
  padding: EdgeInsets.all(AppSpacing.cardPadding),
)
```

### Form Input
```dart
TextField(
  decoration: InputDecoration(
    labelText: 'Name',
    labelStyle: AppTypography.inputLabel,
    hintStyle: AppTypography.inputHint,
    contentPadding: EdgeInsets.symmetric(
      horizontal: AppSpacing.inputPaddingHorizontal,
      vertical: AppSpacing.inputPaddingVertical,
    ),
  ),
)
```

### Blood Type Badge
```dart
Container(
  padding: EdgeInsets.symmetric(
    horizontal: AppSpacing.md,
    vertical: AppSpacing.xs,
  ),
  decoration: BoxDecoration(
    color: AppColors.getBloodTypeColor('O_NEGATIVE'),
    borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
  ),
  child: Text('O-', style: AppTypography.labelSmall),
)
```

### List Item
```dart
Container(
  height: AppSpacing.listItemHeight,
  padding: EdgeInsets.all(AppSpacing.lg),
  decoration: BoxDecoration(
    boxShadow: AppShadows.cardShadow,
  ),
  child: Row(...),
)
```

---

## 🔍 When to Use Each Component

### Colors
- **primary** - All main actions, primary buttons
- **secondary** - Secondary actions, alternatives
- **success** - Positive confirmations, completion
- **warning** - Caution, pending states
- **error** - Errors, critical actions
- **emergencyRed** - Only for actual emergencies

### Typography
- **displaySmall** - App title, main page header
- **headlineLarge** - Section title
- **titleLarge** - Card title
- **bodyMedium** - Main content
- **bodySmall** - Helper text, captions
- **labelLarge** - Button text

### Spacing
- **sm (8dp)** - Icon padding, tight spacing
- **lg (16dp)** - Standard padding (default)
- **xl (24dp)** - Section gaps, large padding
- **screenPaddingHorizontal** - Screen edge padding
- **buttonHeightMedium** - Standard button height
- **touchTargetMinimum** - Always >= 48dp

### Shadows
- **cardShadow** - Cards, containers
- **buttonShadow** - Buttons
- **elevation1-5** - Various depths
- **glowRed** - Emergency effects

### Animations
- **standard (200ms)** - Most animations
- **medium (300ms)** - Page transitions
- **emergencyPulse (600ms)** - Emergency animations

---

## 📊 Design Token Statistics

| Category | Count | Range |
|----------|-------|-------|
| Colors | 150+ | Primary, Secondary, Status, Status |
| Spacing Values | 20+ | 4dp to 9999dp |
| Typography Styles | 25+ | 11sp to 57sp |
| Animation Durations | 12+ | 50ms to 3000ms |
| Shadow Presets | 15+ | Elevation 0-5, Glow, Colored |

---

## ⚡ Performance Tips

1. **Use const whenever possible**
   ```dart
   const SizedBox(height: AppSpacing.lg)  // ✅ Const
   SizedBox(height: AppSpacing.lg)        // ❌ Not const
   ```

2. **Cache animations**
   ```dart
   late AnimationController _controller;
   ```

3. **Use theme instead of custom decorations**
   ```dart
   ElevatedButton(...)  // ✅ Uses theme
   Container with custom decoration  // ❌ Duplicates theme
   ```

4. **Avoid unnecessary rebuilds**
   ```dart
   Container(boxShadow: AppShadows.cardShadow)  // ✅ Single evaluation
   ```

---

## 🎓 Design Token Hierarchy

```
AppTheme (Complete theme)
├── AppColors (Color palette)
├── AppTypography (Text styles)
├── AppSpacing (Sizes & spacing)
├── AppShadows (Elevations & shadows)
└── AppAnimations (Durations & curves)
```

Import all: `import 'theme/index.dart'`  
Import specific: `import 'theme/colors.dart'`

---

## 📞 Cheat Sheet

**Quick Copy-Paste Values:**

```dart
// Import
import 'theme/index.dart';

// Primary Red
color: AppColors.primary                    // #D32F2F

// Standard Spacing
padding: EdgeInsets.all(AppSpacing.lg)     // 16dp

// Title Text
Text('Title', style: AppTypography.headlineLarge)

// Standard Button
ElevatedButton(onPressed: () {}, child: Text('Action'))

// Card with Shadow
Container(
  decoration: BoxDecoration(
    color: AppColors.surface,
    boxShadow: AppShadows.cardShadow,
    borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
  ),
)

// Smooth Animation
AnimatedContainer(
  duration: AppAnimations.standard,
  curve: AppAnimations.easeOutCurve,
)
```

---

**Keep this document open while coding for quick reference!**

Version: 1.0.0 | Updated: February 28, 2026 | Status: Production Ready ✅
