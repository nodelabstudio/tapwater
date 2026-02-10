import 'package:drift/drift.dart';

class UserSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get unitSystem => text().withDefault(const Constant('metric'))();
  IntColumn get dayBoundaryHour => integer().withDefault(const Constant(0))();
  BoolColumn get remindersEnabled => boolean().withDefault(const Constant(false))();
  IntColumn get reminderStartHour => integer().withDefault(const Constant(8))();
  IntColumn get reminderEndHour => integer().withDefault(const Constant(22))();
  IntColumn get reminderIntervalMinutes => integer().withDefault(const Constant(120))();
}
