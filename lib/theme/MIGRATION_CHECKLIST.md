# 🎯 Design System Migration Checklist

Use this checklist to systematically migrate your existing screens to the new design system.

---

## Phase 1: Setup (Complete First)

- [ ] Update `main.dart` to use `AppTheme.lightTheme`
- [ ] Remove `debugShowCheckedModeBanner: true` (keep false for Play Store)
- [ ] Test app builds and runs without errors
- [ ] Verify no lint warnings appear
- [ ] Run `flutter analyze` - should show no issues

---

## Phase 2: Critical Screens (High Priority)

These screens are most visible to users. Migrate these first.

### Dashboard / Home Screen
- [ ] Replace all color hardcodes with `AppColors.*`
- [ ] Replace all `TextStyle` with `AppTypography.*`
- [ ] Replace all padding/margin with `AppSpacing.*`
- [ ] Add shadows using `AppShadows.*`
- [ ] Test layout on multiple screen sizes (360px, 420px, 768px)
- [ ] Verify all touch targets are ≥ 48dp
- [ ] Run animation test: smooth at 60 FPS (no jank)
- [ ] Test dark mode readiness (visual check)

### Emergency Request Screen
- [ ] Replace emergency red color: `AppColors.emergencyRed`
- [ ] Replace glow effect: `AppShadows.currentGlow` or `glowRed`
- [ ] Set button size: `AppSpacing.emergencyButtonSize`
- [ ] Add pulse animation: `AppAnimations.emergencyPulse`
- [ ] Verify contrast ratio (red text on red background readable?)
- [ ] Test on low light condition (sunlight readability)

### Blood Type Selection Screen
- [ ] Use `AppColors.getBloodTypeColor()` for each type
- [ ] Replace title with `AppTypography.headlineLarge`
- [ ] Replace labels with `AppTypography.labelLarge`
- [ ] Set button size to `AppSpacing.buttonHeightMedium`
- [ ] Use `AppSpacing.gridSpacing` between cards
- [ ] Verify all buttons have >= 48dp touch area

### Profile Screen
- [ ] Update avatar background: `AppColors.primary100`
- [ ] Update profile fields with proper typography hierarchy
- [ ] Use `AppSpacing.cardPadding` for card content
- [ ] Apply `AppShadows.cardShadow` to cards
- [ ] Replace buttons with theme buttons
- [ ] Test dropdown/picker styling

---

## Phase 3: Feature Screens (Medium Priority)

### Find Donors / Donor List
- [ ] Apply `AppTypography.headlineSmall` to feature title
- [ ] Apply `AppTypography.titleMedium` to donor names
- [ ] Use response card styling: `AppShadows.cardShadow`
- [ ] Add hover effect using `AppShadows.cardShadowHovered`
- [ ] Implement `AppSpacing.listItemHeight` for each card
- [ ] Use `AppColors.getBloodTypeColor()` for type badges
- [ ] Add distance/location text: `AppTypography.bodySmall`
- [ ] Verify swipe/delete gestures still work

### Donor Contact Screen
- [ ] Apply message input theme (should auto-apply via `AppTheme`)
- [ ] Use button theme for Send/Call buttons
- [ ] Apply proper spacing: `AppSpacing.lg` between message areas
- [ ] Use `AppShadows.buttonShadow` for action buttons
- [ ] Add message animation: `AppAnimations.slideIn`
- [ ] Test keyboard interaction and layout

### Request Form / Blood Request Screen
- [ ] Update form labels: `AppTypography.inputLabel`
- [ ] Update form hints: `AppTypography.inputHint`
- [ ] All inputs should auto-apply `inputDecorationTheme` from `AppTheme`
- [ ] Use `AppSpacing.lg` for form field spacing
- [ ] Apply `AppShadows.buttonShadow` to submit button
- [ ] Add success message: `AppTypography.successMessage`
- [ ] Add error message: `AppTypography.errorMessage`

### Alerts Screen
- [ ] Use `AppColors.warning` for alert borders
- [ ] Use `AppColors.error` for critical alerts
- [ ] Use `AppColors.success` for resolved alerts
- [ ] Apply `AppTypography.headlineSmall` to alert titles
- [ ] Use `AppSpacing.cardSpacing` between alerts
- [ ] Add badge: `AppTypography.urgencyBadge`

---

## Phase 4: Utility Screens (Lower Priority)

### Leaderboard Screen
- [ ] Apply typography hierarchy
- [ ] Use `AppSpacing.listItemHeight` for rows
- [ ] Apply `AppShadows.elevation1Shadow` to cards
- [ ] Update medal/rank icons: `AppSpacing.iconLarge`

### Community Feed Screen
- [ ] Apply card styling consistently
- [ ] Use proper text hierarchy
- [ ] Implement `AppSpacing.cardSpacing` between posts
- [ ] Add like button animation: `AppAnimations.quick` duration

### Onboarding Screen
- [ ] Update headings: `AppTypography.displaySmall`
- [ ] Update descriptions: `AppTypography.bodyLarge`
- [ ] Use `AppSpacing.screenPaddingVertical` for vertical spacing
- [ ] Implement slide transition: `AppAnimations.pageTransition`
- [ ] Verify dot indicators use proper colors

### Settings / Profile Settings Screen
- [ ] Apply toggle theme (auto-applied via `AppTheme`)
- [ ] Use `AppTypography.titleMedium` for section headers
- [ ] Use `AppSpacing.lg` for section spacing
- [ ] Apply `AppShadows.cardShadow` to settings groups

### Login / Register Screen
- [ ] Update title: `AppTypography.displayMedium`
- [ ] Update subtitle: `AppTypography.titleLarge`
- [ ] Form inputs auto-apply theme styling
- [ ] Login button uses theme styling
- [ ] Background/gradient uses `AppColors` palette
- [ ] Test on short screens (landscape)

---

## Phase 5: Widgets & Components (Reusable Elements)

### Animated Stat Card Widget
- [ ] Use `AppSpacing.componentMedium` for card size
- [ ] Apply `AppShadows.cardShadow` (no shadow? Use elevation0)
- [ ] Update animation: `AppAnimations.medium` duration
- [ ] Use `AppTypography.bodySmall` for stat label
- [ ] Use `AppTypography.titleLarge` for stat value

### Blood Filters Widget
- [ ] Update chip styling (theme auto-applies)
- [ ] Use `AppColors.getBloodTypeColor()` for selected state
- [ ] Apply `AppSpacing.chipPaddingHorizontal` for padding
- [ ] Verify filter logic still works

### Donor Card Widget
- [ ] Update card shadow: `AppShadows.cardShadow`
- [ ] Apply hover effect: `AppShadows.cardShadowHovered`
- [ ] Use `AppTypography.titleMedium` for donor name
- [ ] Use `AppTypography.bodySmall` for metadata
- [ ] Update buttons to use theme

### Urgent Requests Widget
- [ ] Use `AppColors.emergencyRed` for urgent badge
- [ ] Apply `AppShadows.emergencyShadow` for glow
- [ ] Update title: `AppTypography.emergencyTitle`
- [ ] Set urgency color: `AppColors.warning` for pending

---

## Phase 6: Testing & Validation

### Accessibility Testing
- [ ] [ ] Run accessibility audit on each screen
- [ ] [ ] Verify all buttons >= 48dp (tap with finger)
- [ ] [ ] Check text contrast ratios (use contrast checker tool)
- [ ] [ ] Test with TalkBack/VoiceOver enabled
- [ ] [ ] Verify semantic labels on images/icons
- [ ] [ ] Test with system font size increased to 200%

### Performance Testing
- [ ] [ ] Run on low-end device (e.g., older Android)
- [ ] [ ] Check frame rate: smooth 60 FPS (no jank)
- [ ] [ ] Verify animations don't cause stuttering
- [ ] [ ] Test with reduced motion enabled
- [ ] [ ] Check memory usage (Profile > Memory)

### Responsive Testing
- [ ] [ ] Test on 360px width (small phone)
- [ ] [ ] Test on 420px width (regular phone)
- [ ] [ ] Test on 600px width (tablet portrait)
- [ ] [ ] Test on 840px width (tablet landscape)
- [ ] [ ] Test on 1200px width (desktop/large tablet)
- [ ] [ ] Verify text doesn't overflow
- [ ] [ ] Verify layouts adapt properly (no hardcoded widths)

### Platform Testing
- [ ] [ ] Test on Android (multiple SDK versions)
- [ ] [ ] Test on iOS (if available)
- [ ] [ ] Test on different screen densities (density test)
- [ ] [ ] Test in landscape orientation
- [ ] [ ] Test with screen rotation

### Browser Testing (if web version exists)
- [ ] [ ] Test on Chrome (Desktop & Mobile)
- [ ] [ ] Test on Safari
- [ ] [ ] Test on Firefox
- [ ] [ ] Verify responsive behavior

---

## Phase 7: Code Quality

### Style Consistency
- [ ] [ ] All colors from `AppColors`
- [ ] [ ] All text from `AppTypography`
- [ ] [ ] All spacing from `AppSpacing`
- [ ] [ ] All shadows from `AppShadows`
- [ ] [ ] All animations from `AppAnimations`
- [ ] [ ] No hardcoded design values

### Code Organization
- [ ] [ ] Import using `import 'theme/index.dart'` (or specific files)
- [ ] [ ] No custom theme definitions in widgets
- [ ] [ ] No Material color overrides
- [ ] [ ] Consistent naming conventions

### Error Handling
- [ ] [ ] No console warnings (`flutter analyze`)
- [ ] [ ] No debug banners in release mode
- [ ] [ ] No layout overflows
- [ ] [ ] No null pointer exceptions
- [ ] [ ] Proper error states with `AppColors.error`

---

## Phase 8: Play Store Preparation

### Content Requirements
- [ ] [ ] No fake emergency claims
- [ ] [ ] Disclaimer added (UI demo version if no backend)
- [ ] [ ] Privacy policy (link or in-app page)
- [ ] [ ] Terms of service reviewed
- [ ] [ ] No misleading health claims

### Technical Requirements
- [ ] [ ] Target SDK: Latest version
- [ ] [ ] Min SDK: 21 or higher
- [ ] [ ] `debugShowCheckedModeBanner: false`
- [ ] [ ] No unnecessary permissions
- [ ] [ ] Internet permission removed (if no backend)

### Visual Requirements
- [ ] [ ] Professional app icon created
- [ ] [ ] No blurry or pixelated graphics
- [ ] [ ] Consistent branding throughout
- [ ] [ ] Screenshot previews capture best features
- [ ] [ ] App name is clear and memorable

### Performance Requirements
- [ ] [ ] App size < 100 MB
- [ ] [ ] Initial load < 2 seconds
- [ ] [ ] All screens respond smoothly
- [ ] [ ] No memory leaks
- [ ] [ ] Animations smooth @ 60 FPS

---

## Phase 9: Final Review Checklist

Before submitting to Play Store:

- [ ] All screens migrated to design system
- [ ] Testing complete on multiple devices
- [ ] All accessibility requirements met
- [ ] Performance verified (no jank)
- [ ] No console errors/warnings
- [ ] Screenshots created for Play Store
- [ ] App title & description optimized for SEO
- [ ] Privacy policy & T&C in place
- [ ] Version number incremented
- [ ] Release notes prepared
- [ ] Build tested in release mode
- [ ] Team review completed
- [ ] Beta testing feedback addressed

---

## Scoring

Count your completed items:

| Range | Status | Action |
|-------|--------|--------|
| 0-20% | Just Started | Continue with Phase 1-2 |
| 21-40% | On Track | Focus on Phase 3-4 |
| 41-60% | Good Progress | Complete Phase 5-6 |
| 61-80% | Nearly Done | Move to Phase 7-8 |
| 81-100% | Ready | Phase 9 - Final review |

---

## Tips for Success

### ✅ DO
- Start with critical screens
- Test frequently on actual devices
- Ask team members to review updates
- Commit changes incrementally (git commits for each screen)
- Keep design system documentation updated
- Use find/replace for bulk updates (carefully!)

### ❌ DON'T
- Try to migrate everything at once
- Skip accessibility testing
- Assume simulator is same as real device
- Forget to test in release mode
- Hardcode colors "just this once"
- Skip on low-end device testing

---

## Timeline Estimate

- **Phase 1 (Setup):** 15 minutes
- **Phase 2 (Critical screens):** 2-3 hours
- **Phase 3 (Feature screens):** 2-3 hours
- **Phase 4 (Utility screens):** 1-2 hours
- **Phase 5 (Components):** 1 hour
- **Phase 6 (Testing):** 3-4 hours
- **Phase 7 (Code quality):** 1 hour
- **Phase 8 (Play Store prep):** 2-3 hours
- **Phase 9 (Final review):** 1 hour

**Total: 14-19 hours** (spread over 1-2 weeks for best results)

---

## Questions?

Reference these documents:
- `GETTING_STARTED.md` - Quick start guide
- `README.md` - Complete API reference
- `IMPLEMENTATION_GUIDE.dart` - Best practices & patterns
- `example_screen.dart` - Real-world example

---

**Last Updated:** February 28, 2026  
**Version:** 1.0.0  
**Status:** Ready to Use ✅
