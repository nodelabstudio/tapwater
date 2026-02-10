import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/app_database.dart';
import '../../shared/extensions/date_extensions.dart';
import 'database_provider.dart';
import 'settings_providers.dart';

final todayEntriesProvider = StreamProvider<List<DrinkEntry>>((ref) {
  final db = ref.watch(databaseProvider);
  final dayBoundary = ref.watch(dayBoundaryHourProvider);
  final now = DateTime.now();
  final start = now.startOfDay(dayBoundaryHour: dayBoundary);
  final end = now.endOfDay(dayBoundaryHour: dayBoundary);
  return db.drinkEntryDao.watchEntriesForDay(start, end);
});

final todayTotalMlProvider = StreamProvider<int>((ref) {
  final db = ref.watch(databaseProvider);
  final dayBoundary = ref.watch(dayBoundaryHourProvider);
  final now = DateTime.now();
  final start = now.startOfDay(dayBoundaryHour: dayBoundary);
  final end = now.endOfDay(dayBoundaryHour: dayBoundary);
  return db.drinkEntryDao.watchTotalMlForDay(start, end);
});

final entriesForDateProvider =
    StreamProvider.family<List<DrinkEntry>, DateTime>((ref, date) {
  final db = ref.watch(databaseProvider);
  final dayBoundary = ref.watch(dayBoundaryHourProvider);
  final start = date.startOfDay(dayBoundaryHour: dayBoundary);
  final end = date.endOfDay(dayBoundaryHour: dayBoundary);
  return db.drinkEntryDao.watchEntriesForDay(start, end);
});

final totalMlForDateProvider =
    FutureProvider.family<int, DateTime>((ref, date) {
  final db = ref.watch(databaseProvider);
  final dayBoundary = ref.watch(dayBoundaryHourProvider);
  final start = date.startOfDay(dayBoundaryHour: dayBoundary);
  final end = date.endOfDay(dayBoundaryHour: dayBoundary);
  return db.drinkEntryDao.getTotalMlForDay(start, end);
});

final weeklyTotalsProvider =
    FutureProvider<List<MapEntry<DateTime, int>>>((ref) async {
  final db = ref.watch(databaseProvider);
  final dayBoundary = ref.watch(dayBoundaryHourProvider);
  final now = DateTime.now();
  final results = <MapEntry<DateTime, int>>[];
  for (int i = 6; i >= 0; i--) {
    final day = now.subtract(Duration(days: i));
    final start = day.startOfDay(dayBoundaryHour: dayBoundary);
    final end = day.endOfDay(dayBoundaryHour: dayBoundary);
    final total = await db.drinkEntryDao.getTotalMlForDay(start, end);
    results.add(MapEntry(start, total));
  }
  return results;
});
