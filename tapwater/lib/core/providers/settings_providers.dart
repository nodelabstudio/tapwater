import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/app_database.dart';
import '../models/enums.dart';
import 'database_provider.dart';

final userSettingsProvider = StreamProvider<UserSetting>((ref) {
  final db = ref.watch(databaseProvider);
  return db.userSettingsDao.watchSettings();
});

final unitSystemProvider = Provider<UnitSystem>((ref) {
  final settings = ref.watch(userSettingsProvider).valueOrNull;
  if (settings == null) return UnitSystem.metric;
  return settings.unitSystem == 'imperial'
      ? UnitSystem.imperial
      : UnitSystem.metric;
});

final dayBoundaryHourProvider = Provider<int>((ref) {
  final settings = ref.watch(userSettingsProvider).valueOrNull;
  return settings?.dayBoundaryHour ?? 0;
});
