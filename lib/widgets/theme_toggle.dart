import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';
import '../theme/colors.dart';

/// Animated theme toggle button with smooth transitions
class ThemeToggleButton extends ConsumerWidget {
  final double size;
  final bool showLabel;

  const ThemeToggleButton({
    super.key,
    this.size = 48.0,
    this.showLabel = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => ref.read(themeProvider.notifier).toggleTheme(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDarkMode
              ? AppColors.darkSurfaceVariant
              : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(size / 2),
          border: Border.all(
            color: isDarkMode
                ? AppColors.darkOutline
                : AppColors.outline.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => RotationTransition(
                turns: animation,
                child: FadeTransition(opacity: animation, child: child),
              ),
              child: Icon(
                isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                key: ValueKey(isDarkMode),
                size: size * 0.5,
                color: isDarkMode ? AppColors.darkPrimary : AppColors.primary,
              ),
            ),
            if (showLabel) ...[
              const SizedBox(width: 8),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  isDarkMode ? 'Dark' : 'Light',
                  key: ValueKey(isDarkMode),
                  style: theme.textTheme.labelMedium,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Theme mode selector with system option
class ThemeModeSelector extends ConsumerWidget {
  const ThemeModeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final theme = Theme.of(context);
    final isDark = themeState.isDarkMode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Theme Mode', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.darkSurfaceVariant
                : AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark
                  ? AppColors.darkOutlineVariant
                  : AppColors.outlineVariant,
            ),
          ),
          child: Column(
            children: [
              _ThemeModeOption(
                mode: AppThemeMode.system,
                currentMode: themeState.themeMode,
                icon: Icons.brightness_auto_rounded,
                label: 'System',
                description: 'Follow device settings',
                onTap: () => ref
                    .read(themeProvider.notifier)
                    .setThemeMode(AppThemeMode.system),
              ),
              Divider(
                height: 1,
                color: isDark
                    ? AppColors.darkOutlineVariant
                    : AppColors.outlineVariant,
              ),
              _ThemeModeOption(
                mode: AppThemeMode.light,
                currentMode: themeState.themeMode,
                icon: Icons.light_mode_rounded,
                label: 'Light',
                description: 'Always use light theme',
                onTap: () => ref
                    .read(themeProvider.notifier)
                    .setThemeMode(AppThemeMode.light),
              ),
              Divider(
                height: 1,
                color: isDark
                    ? AppColors.darkOutlineVariant
                    : AppColors.outlineVariant,
              ),
              _ThemeModeOption(
                mode: AppThemeMode.dark,
                currentMode: themeState.themeMode,
                icon: Icons.dark_mode_rounded,
                label: 'Dark',
                description: 'Always use dark theme (AMOLED)',
                onTap: () => ref
                    .read(themeProvider.notifier)
                    .setThemeMode(AppThemeMode.dark),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ThemeModeOption extends StatelessWidget {
  final AppThemeMode mode;
  final AppThemeMode currentMode;
  final IconData icon;
  final String label;
  final String description;
  final VoidCallback onTap;

  const _ThemeModeOption({
    required this.mode,
    required this.currentMode,
    required this.icon,
    required this.label,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSelected = mode == currentMode;
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isSelected
                      ? (isDark ? AppColors.darkPrimary : AppColors.primary)
                      : (isDark ? AppColors.darkSurface : AppColors.surface),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 22,
                  color: isSelected
                      ? Colors.white
                      : (isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.textSecondary),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? AppColors.darkTextTertiary
                            : AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isSelected ? 1.0 : 0.0,
                child: Icon(
                  Icons.check_circle_rounded,
                  color: isDark ? AppColors.darkPrimary : AppColors.primary,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Compact theme toggle for AppBar actions
class CompactThemeToggle extends ConsumerWidget {
  const CompactThemeToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);

    return IconButton(
      onPressed: () => ref.read(themeProvider.notifier).toggleTheme(),
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: FadeTransition(opacity: animation, child: child),
        ),
        child: Icon(
          isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
          key: ValueKey(isDarkMode),
        ),
      ),
      tooltip: isDarkMode ? 'Switch to light mode' : 'Switch to dark mode',
    );
  }
}

