import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Theme mode options for the app
enum AppThemeMode {
  system, // Follow system preference
  light, // Force light mode
  dark, // Force dark mode
}

/// Key for storing theme preference
const String _themePreferenceKey = 'app_theme_mode';

/// Theme state that holds current mode and resolved brightness
class ThemeState {
  final AppThemeMode themeMode;
  final Brightness resolvedBrightness;
  final bool isInitialized;

  const ThemeState({
    this.themeMode = AppThemeMode.system,
    this.resolvedBrightness = Brightness.light,
    this.isInitialized = false,
  });

  ThemeState copyWith({
    AppThemeMode? themeMode,
    Brightness? resolvedBrightness,
    bool? isInitialized,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      resolvedBrightness: resolvedBrightness ?? this.resolvedBrightness,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }

  /// Get Flutter's ThemeMode from current state
  ThemeMode get flutterThemeMode {
    switch (themeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  /// Check if dark mode is currently active
  bool get isDarkMode => resolvedBrightness == Brightness.dark;
}

/// Theme notifier that manages theme state with persistence
class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier() : super(const ThemeState()) {
    _initialize();
  }

  /// Initialize theme from stored preference
  Future<void> _initialize() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedMode = prefs.getInt(_themePreferenceKey);

      AppThemeMode themeMode = AppThemeMode.system;
      if (storedMode != null &&
          storedMode >= 0 &&
          storedMode < AppThemeMode.values.length) {
        themeMode = AppThemeMode.values[storedMode];
      }

      final resolvedBrightness = _resolveBrightness(themeMode);

      state = state.copyWith(
        themeMode: themeMode,
        resolvedBrightness: resolvedBrightness,
        isInitialized: true,
      );
    } catch (e) {
      // Fallback to system theme if initialization fails
      state = state.copyWith(
        themeMode: AppThemeMode.system,
        resolvedBrightness: _getSystemBrightness(),
        isInitialized: true,
      );
    }
  }

  /// Set theme mode and persist preference
  Future<void> setThemeMode(AppThemeMode mode) async {
    final resolvedBrightness = _resolveBrightness(mode);

    state = state.copyWith(
      themeMode: mode,
      resolvedBrightness: resolvedBrightness,
    );

    // Persist preference
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_themePreferenceKey, mode.index);
    } catch (e) {
      // Silently fail - state is already updated
      debugPrint('Failed to persist theme preference: $e');
    }
  }

  /// Toggle between light and dark mode
  Future<void> toggleTheme() async {
    final newMode = state.isDarkMode ? AppThemeMode.light : AppThemeMode.dark;
    await setThemeMode(newMode);
  }

  /// Update resolved brightness when system theme changes
  void onSystemBrightnessChanged() {
    if (state.themeMode == AppThemeMode.system) {
      state = state.copyWith(resolvedBrightness: _getSystemBrightness());
    }
  }

  /// Resolve brightness based on theme mode
  Brightness _resolveBrightness(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return Brightness.light;
      case AppThemeMode.dark:
        return Brightness.dark;
      case AppThemeMode.system:
        return _getSystemBrightness();
    }
  }

  /// Get current system brightness
  Brightness _getSystemBrightness() {
    return SchedulerBinding.instance.platformDispatcher.platformBrightness;
  }
}

/// Provider for theme state
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier();
});

/// Convenience provider for checking dark mode
final isDarkModeProvider = Provider<bool>((ref) {
  return ref.watch(themeProvider).isDarkMode;
});

/// Convenience provider for getting Flutter ThemeMode
final flutterThemeModeProvider = Provider<ThemeMode>((ref) {
  return ref.watch(themeProvider).flutterThemeMode;
});
