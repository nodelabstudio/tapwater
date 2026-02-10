import 'package:drift/drift.dart';

class DailyTags extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  TextColumn get tag => text().withLength(min: 1, max: 100)();
}
