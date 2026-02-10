import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/app_database.dart';
import 'database_provider.dart';

final currentGoalProvider = StreamProvider<DailyGoal?>((ref) {
  final db = ref.watch(databaseProvider);
  return db.dailyGoalDao.watchCurrentGoal();
});

final goalMlProvider = Provider<int>((ref) {
  final goal = ref.watch(currentGoalProvider).valueOrNull;
  return goal?.goalMl ?? 2000;
});
