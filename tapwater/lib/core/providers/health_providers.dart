import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/health_service.dart';
import '../services/preferences_service.dart';

const _healthKitEnabledKey = 'healthkit_enabled';

final healthKitEnabledProvider = StateProvider<bool>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getBool(_healthKitEnabledKey) ?? false;
});

Future<void> setHealthKitEnabled(SharedPreferences prefs, bool enabled) async {
  await prefs.setBool(_healthKitEnabledKey, enabled);
}

/// Writes water intake to HealthKit if enabled.
Future<void> syncToHealthKit({
  required bool enabled,
  required int amountMl,
  required DateTime timestamp,
}) async {
  if (!enabled) return;
  await HealthService.writeWaterIntake(
    amountMl: amountMl,
    timestamp: timestamp,
  );
}
