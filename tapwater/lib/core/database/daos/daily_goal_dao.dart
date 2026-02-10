import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/daily_goals_table.dart';

part 'daily_goal_dao.g.dart';

@DriftAccessor(tables: [DailyGoals])
class DailyGoalDao extends DatabaseAccessor<AppDatabase>
    with _$DailyGoalDaoMixin {
  DailyGoalDao(super.db);

  Future<DailyGoal?> getCurrentGoal() {
    return (select(dailyGoals)
          ..orderBy([(g) => OrderingTerm.desc(g.effectiveFrom)])
          ..limit(1))
        .getSingleOrNull();
  }

  Stream<DailyGoal?> watchCurrentGoal() {
    return (select(dailyGoals)
          ..orderBy([(g) => OrderingTerm.desc(g.effectiveFrom)])
          ..limit(1))
        .watchSingleOrNull();
  }

  Future<int> setGoal(int goalMl) {
    return into(dailyGoals).insert(DailyGoalsCompanion(
      goalMl: Value(goalMl),
      effectiveFrom: Value(DateTime.now()),
    ));
  }

  Future<int> getGoalForDate(DateTime date) async {
    final goal = await (select(dailyGoals)
          ..where((g) => g.effectiveFrom.isSmallerOrEqualValue(date))
          ..orderBy([(g) => OrderingTerm.desc(g.effectiveFrom)])
          ..limit(1))
        .getSingleOrNull();
    return goal?.goalMl ?? 2000;
  }
}
