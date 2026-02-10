// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_goal_dao.dart';

// ignore_for_file: type=lint
mixin _$DailyGoalDaoMixin on DatabaseAccessor<AppDatabase> {
  $DailyGoalsTable get dailyGoals => attachedDatabase.dailyGoals;
  DailyGoalDaoManager get managers => DailyGoalDaoManager(this);
}

class DailyGoalDaoManager {
  final _$DailyGoalDaoMixin _db;
  DailyGoalDaoManager(this._db);
  $$DailyGoalsTableTableManager get dailyGoals =>
      $$DailyGoalsTableTableManager(_db.attachedDatabase, _db.dailyGoals);
}
