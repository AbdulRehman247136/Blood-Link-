// IMPLEMENTATION GUIDE: Using the Design System in Your App
// This file contains best practices, patterns, and a checklist for proper usage

import 'package:flutter/material.dart';
import 'index.dart';
import '../screens/dashboard_screen.dart';

// ============================================================================
// PATTERN 1: Using the Theme in MaterialApp
// ============================================================================

void configureTheme() {
  // ✅ CORRECT: Apply the complete theme
  MaterialApp(
    title: 'Blood Bank',
    theme: AppTheme.lightTheme,
    // darkTheme: AppTheme.darkTheme, // Future enhancement
    home: const DashboardScreen(),
  );

  // ❌ INCORRECT: Don't create custom themes without reason
  // This breaks consistency:
  // theme: ThemeData(
  //   primaryColor: Colors.red,
  //   appBarTheme: AppBarTheme(...), // Duplicates config
  // );
}

// ============================================================================
// PATTERN 2: Applying Colors Correctly
// ============================================================================

class ColorUsageExample extends StatelessWidget {
  const ColorUsageExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ✅ CORRECT: Use AppColors for all colors
        Container(
          color: AppColors.primary,
          child: Text(
            'Primary Action',
            style: TextStyle(color: AppColors.textInverse),
          ),
        ),

        // ✅ Use status colors appropriately
        Container(color: AppColors.success, child: const Text('Success')),

        // ✅ Use dynamic blood type colors
        Container(
          color: AppColors.getBloodTypeColor('O_NEGATIVE'),
          child: const Text('O-'),
        ),

        // ❌ INCORRECT: Don't hardcode colors
        // Container(color: Color(0xFFD32F2F), ...)

        // ❌ INCORRECT: Don't mix Material and AppColors
        // Container(color: Colors.red, ...) // Use AppColors.primary
      ],
    );
  }
}

// ============================================================================
// PATTERN 3: Text Styling Hierarchy
// ============================================================================

class TextStyleExample extends StatelessWidget {
  const TextStyleExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Page/Screen Heading
        Text('Find Blood Donors', style: AppTypography.displaySmall),
        const SizedBox(height: AppSpacing.xl),

        // Section Heading
        Text('Nearby Donors', style: AppTypography.headlineMedium),
        const SizedBox(height: AppSpacing.lg),

        // Card/Component Title
        Text('Ahmed Khan', style: AppTypography.titleLarge),
        const SizedBox(height: AppSpacing.md),

        // Body content
        Text(
          'Located 2.5 km away. Verified donor with 50+ donations.',
          style: AppTypography.bodyMedium,
        ),
        const SizedBox(height: AppSpacing.md),

        // Supporting text
        Text('Last donated 3 months ago', style: AppTypography.bodySmall),
        const SizedBox(height: AppSpacing.lg),

        // Labels and badges
        Text('O Negative', style: AppTypography.labelLarge),
      ],
    );
  }
}

// ============================================================================
// PATTERN 4: Spacing and Layout
// ============================================================================

class SpacingExample extends StatelessWidget {
  const SpacingExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          // ✅ Screen-level padding
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPaddingHorizontal,
            vertical: AppSpacing.screenPaddingVertical,
          ),
          child: Column(
            children: [
              // Section spacing
              const SizedBox(height: AppSpacing.xl),

              // Card with proper padding
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.cardPadding),
                  child: Column(
                    children: [
                      Text('Card Title', style: AppTypography.titleLarge),
                      const SizedBox(height: AppSpacing.md), // Inner spacing
                      Text(
                        'Card content goes here',
                        style: AppTypography.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),

              // Gap between cards
              const SizedBox(height: AppSpacing.cardSpacing),

              // Button with proper sizing
              SizedBox(
                width: double.infinity,
                height: AppSpacing.buttonHeightMedium,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Continue', style: AppTypography.buttonLarge),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// PATTERN 5: Shadows and Elevation
// ============================================================================

class ShadowExample extends StatelessWidget {
  const ShadowExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ✅ Card shadow
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
            boxShadow: AppShadows.cardShadow,
          ),
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: const Text('Card with elevation 1'),
        ),

        const SizedBox(height: AppSpacing.lg),

        // ✅ Button shadow
        Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
            boxShadow: AppShadows.buttonShadow,
          ),
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Text('Button with shadow', style: AppTypography.buttonLarge),
        ),

        const SizedBox(height: AppSpacing.lg),

        // ✅ Emergency glow
        Container(
          decoration: BoxDecoration(
            color: AppColors.emergencyRed,
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
            boxShadow: AppShadows.glowRedIntense,
          ),
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Text('Emergency alert', style: AppTypography.buttonLarge),
        ),

        const SizedBox(height: AppSpacing.lg),

        // ✅ Get elevation dynamically
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
            boxShadow: AppShadows.getElevationShadow(3),
          ),
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: const Text('Dynamic elevation 3'),
        ),
      ],
    );
  }
}

// ============================================================================
// PATTERN 6: Animations
// ============================================================================

class AnimationExample extends StatefulWidget {
  const AnimationExample({super.key});

  @override
  State<AnimationExample> createState() => _AnimationExampleState();
}

class _AnimationExampleState extends State<AnimationExample>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppAnimations.standard,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ✅ Standard animation  (200ms, ease-out)
        AnimatedContainer(
          duration: AppAnimations.standard,
          curve: AppAnimations.easeOutCurve,
          color: Colors.red,
          width: 100,
          height: 100,
        ),

        const SizedBox(height: AppSpacing.lg),

        // ✅ Multiple animations with stagger
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(3, (index) {
            return SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(0, 0.5),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _controller,
                      curve: Interval(
                        index * 0.1,
                        (index + 1) * 0.1 + 0.3,
                        curve: AppAnimations.easeOutCurve,
                      ),
                    ),
                  ),
              child: CircleAvatar(
                backgroundColor: AppColors.primary,
                child: Text('$index'),
              ),
            );
          }),
        ),

        const SizedBox(height: AppSpacing.lg),

        // ✅ Emergency pulse (animated, repeating)
        _buildPulseAnimation(),
      ],
    );
  }

  Widget _buildPulseAnimation() {
    return ScaleTransition(
      scale: Tween<double>(begin: 1.0, end: 1.1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: AppAnimations.emergencyEaseCurve,
        ),
      ),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: AppColors.emergencyRed,
          shape: BoxShape.circle,
          boxShadow: AppShadows.glowRed,
        ),
        child: const Center(
          child: Icon(Icons.emergency, color: Colors.white, size: 40),
        ),
      ),
    );
  }
}

// ============================================================================
// PATTERN 7: Responsive Design
// ============================================================================

class ResponsiveExample extends StatelessWidget {
  const ResponsiveExample({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= AppSpacing.tabletMinWidth;
    // final isDesktop = screenWidth >= AppSpacing.desktopMinWidth;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.getResponsivePadding(screenWidth),
        ),
        child: isTablet
            ? Row(
                children: [
                  Expanded(child: _buildPanel('Left Panel')),
                  const SizedBox(width: AppSpacing.lg),
                  Expanded(child: _buildPanel('Right Panel')),
                ],
              )
            : Column(children: [_buildPanel('Full Width Panel')]),
      ),
    );
  }

  Widget _buildPanel(String title) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Text(title, style: AppTypography.titleLarge),
      ),
    );
  }
}

// ============================================================================
// PATTERN 8: Interactive States
// ============================================================================

class InteractiveStateExample extends StatefulWidget {
  const InteractiveStateExample({super.key});

  @override
  State<InteractiveStateExample> createState() =>
      _InteractiveStateExampleState();
}

class _InteractiveStateExampleState extends State<InteractiveStateExample> {
  bool isCardHovered = false;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ✅ Card with hover state
        MouseRegion(
          onEnter: (_) => setState(() => isCardHovered = true),
          onExit: (_) => setState(() => isCardHovered = false),
          child: AnimatedContainer(
            duration: AppAnimations.short,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(
                AppSpacing.borderRadiusMedium,
              ),
              boxShadow: AppShadows.getInteractiveShadow(
                isPressed: isPressed,
                isHovered: isCardHovered,
                isEnabled: true,
                isButton: false,
              ),
            ),
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Text('Hover over me', style: AppTypography.titleMedium),
          ),
        ),

        const SizedBox(height: AppSpacing.xl),

        // ✅ Button with press state
        GestureDetector(
          onTapDown: (_) => setState(() => isPressed = true),
          onTapUp: (_) => setState(() => isPressed = false),
          onTapCancel: () => setState(() => isPressed = false),
          child: AnimatedContainer(
            duration: AppAnimations.quick,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(
                AppSpacing.buttonBorderRadius,
              ),
              boxShadow: AppShadows.getInteractiveShadow(
                isPressed: isPressed,
                isHovered: false,
                isEnabled: true,
                isButton: true,
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.buttonPaddingHorizontal,
              vertical: AppSpacing.buttonPaddingVertical,
            ),
            child: Text('Press me', style: AppTypography.buttonLarge),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// IMPLEMENTATION CHECKLIST
// ============================================================================

// Before shipping your screen, verify:

/*

✅ COLORS
  [ ] Using AppColors for all colors (no hardcoded hex)
  [ ] Using AppColors.getBloodTypeColor() for blood types
  [ ] Using proper emergency colors in emergency states
  [ ] Text colors have sufficient contrast (WCAG AA minimum)
  [ ] Using AppColors.textInverse for text on colored backgrounds

✅ TYPOGRAPHY
  [ ] Using AppTypography styles (not custom TextStyle)
  [ ] Heading hierarchy is logical (Display > Headline > Title)
  [ ] Body text uses AppTypography.bodyMedium or closer variant
  [ ] Labels use AppTypography.labelLarge or smaller
  [ ] No font sizes < 12sp (accessibility)

✅ SPACING
  [ ] Using AppSpacing constants (no hardcoded 10, 15, 20, etc.)
  [ ] Screen padding = AppSpacing.screenPaddingHorizontal
  [ ] Card padding = AppSpacing.cardPadding
  [ ] Touch targets >= 48dp (AppSpacing.touchTargetMinimum)
  [ ] Using AppSpacing.getResponsivePadding() for responsive layouts

✅ SHADOWS & ELEVATION
  [ ] Cards use AppShadows.cardShadow
  [ ] Buttons use AppShadows.buttonShadow
  [ ] Dialogs use AppShadows.dialogShadow
  [ ] Emergency states use AppShadows.emergencyShadow or glowRed
  [ ] No custom shadow definitions (use AppShadows)

✅ ANIMATIONS
  [ ] Standard transitions use AppAnimations.standard (200ms)
  [ ] Page transitions use AppAnimations.pageTransition (300ms)
  [ ] Emergency states use AppAnimations.emergencyPulse (600ms)
  [ ] Using appropriate curves (easeOut for entrance, accelerate for exit)
  [ ] All animations < 600ms (except background loops)
  [ ] No animation under 100ms (feels jerky)

✅ RESPONSIVE DESIGN
  [ ] Layouts adapt for mobile, tablet, desktop (use breakpoints)
  [ ] Text sizes scale with AppSpacing.getResponsiveFontSize()
  [ ] No hard-coded screen widths
  [ ] Testing on 360px (small phone), 768px (tablet), 1200px+ (desktop)

✅ ACCESSIBILITY
  [ ] All interactive elements >= 48dp tap targets
  [ ] Color contrast ratio >= 4.5:1 for text
  [ ] Icons have semantic labels (tooltip or label)
  [ ] Form fields have labels, not just placeholders
  [ ] Supporting reduced motion (duration = 50ms if needed)

✅ THEME CONSISTENCY
  [ ] Using AppTheme.lightTheme in MaterialApp
  [ ] No overriding theme properties at widget level
  [ ] No custom ThemeData definitions
  [ ] Using Material Design 3 components

✅ PLAY STORE READINESS
  [ ] No debug banners (debugShowCheckedModeBanner: false)
  [ ] No console warnings during app run
  [ ] No layout overflows or rendering issues
  [ ] Smooth animations with no jank (60 FPS)
  [ ] App closes cleanly on back button

*/

// ============================================================================
// COMMON MISTAKES TO AVOID
// ============================================================================

class MistakesToAvoid {
  // ❌ MISTAKE 1: Hardcoding colors
  void wrongColorUsage() {
    Container(
      // color: Color(0xFFD32F2F), // WRONG!
      color: AppColors.primary, // CORRECT
    );
  }

  // ❌ MISTAKE 2: Creating custom TextStyles
  void wrongTextStyle() {
    Text(
      'Hello',
      // style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold), // WRONG!
      style: AppTypography.headlineSmall, // CORRECT
    );
  }

  // ❌ MISTAKE 3: Hardcoding padding values
  void wrongSpacing() {
    Padding(
      // padding: EdgeInsets.all(16), // WRONG!
      padding: const EdgeInsets.all(AppSpacing.lg), // CORRECT
    );
  }

  // ❌ MISTAKE 4: Custom animations
  void wrongAnimation() {
    AnimatedContainer(
      // duration: Duration(milliseconds: 250), // WRONG!
      duration: AppAnimations.standard, // CORRECT
    );
  }

  // ❌ MISTAKE 5: Inconsistent shadows
  void wrongShadows() {
    Container(
      // decoration: BoxDecoration(
      //   boxShadow: [
      //     BoxShadow(color: Colors.black, blurRadius: 4), // WRONG!
      //   ],
      // ),
      decoration: BoxDecoration(
        boxShadow: AppShadows.cardShadow, // CORRECT
      ),
    );
  }
}

// ============================================================================
// QUICK REFERENCE
// ============================================================================

/*

IMPORT SHORTCUT:
  import 'theme/index.dart'; // Imports all components

COLOR QUICK REFERENCE:
  AppColors.primary          - Main red
  AppColors.textPrimary      - Dark text
  AppColors.textInverse      - White text
  AppColors.success          - Green
  AppColors.warning          - Yellow
  AppColors.error            - Red

SPACING QUICK REFERENCE:
  AppSpacing.sm              - 8dp
  AppSpacing.lg              - 16dp (default)
  AppSpacing.xl              - 24dp

TYPOGRAPHY QUICK REFERENCE:
  AppTypography.displaySmall - Page title
  AppTypography.headlineSmall - Section title
  AppTypography.titleLarge   - Card title
  AppTypography.bodyMedium   - Body text

ANIMATION QUICK REFERENCE:
  AppAnimations.standard     - 200ms (most common)
  AppAnimations.medium       - 300ms
  AppAnimations.emergencyPulse - 600ms

*/
