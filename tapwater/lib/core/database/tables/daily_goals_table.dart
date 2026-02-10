import 'package:drift/drift.dart';

class DailyGoals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get goalMl => integer().withDefault(const Constant(2000))();
  DateTimeColumn get effectiveFrom => dateTime()();
}
