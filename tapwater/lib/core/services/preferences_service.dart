import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _onboardingCompleteKey = 'onboarding_complete';

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
