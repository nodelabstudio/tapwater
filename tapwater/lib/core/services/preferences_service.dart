import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _onboardingCompleteKey = 'onboarding_complete';
const _themeModeKey = 'theme_mode';
const _accentColorKey = 'accent_color';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Must be overridden in main');
});

final onboardingCompleteProvider = Provider<bool>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getBool(_onboardingCompleteKey) ?? false;
});

Future<void> setOnboardingComplete(SharedPreferences prefs) async {
  await prefs.setBool(_onboardingCompleteKey, true);
}

final themeModeProvider = StateProvider<ThemeMode>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final value = prefs.getString(_themeModeKey) ?? 'system';
  switch (value) {
    case 'light':
      return ThemeMode.light;
    case 'dark':
      return ThemeMode.dark;
    default:
      return ThemeMode.system;
  }
});

Future<void> setThemeMode(SharedPreferences prefs, ThemeMode mode) async {
  final value = switch (mode) {
    ThemeMode.light => 'light',
    ThemeMode.dark => 'dark',
    _ => 'system',
  };
  await prefs.setString(_themeModeKey, value);
}

/// Preset accent color themes.
class AccentTheme {
  final String name;
  final Color color;
  const AccentTheme(this.name, this.color);
}

const accentThemes = [
  AccentTheme('Ocean Blue', Color(0xFF2196F3)),
  AccentTheme('Teal', Color(0xFF009688)),
  AccentTheme('Forest Green', Color(0xFF4CAF50)),
  AccentTheme('Lavender', Color(0xFF7C4DFF)),
  AccentTheme('Berry', Color(0xFF9C27B0)),
  AccentTheme('Coral', Color(0xFFFF5722)),
  AccentTheme('Sunset', Color(0xFFFF9800)),
  AccentTheme('Rose', Color(0xFFE91E63)),
  AccentTheme('Slate', Color(0xFF607D8B)),
  AccentTheme('Indigo', Color(0xFF3F51B5)),
];

final accentColorProvider = StateProvider<Color>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final hex = prefs.getString(_accentColorKey);
  if (hex != null) {
    return Color(int.parse(hex, radix: 16));
  }
  return const Color(0xFF2196F3); // Default Ocean Blue
});

Future<void> setAccentColor(SharedPreferences prefs, Color color) async {
  await prefs.setString(_accentColorKey, color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase());
}
