import 'package:drift/drift.dart';
import 'drink_types_table.dart';

class DrinkEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get drinkTypeId => integer().references(DrinkTypes, #id)();
  IntColumn get amountMl => integer()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get source => text().withDefault(const Constant('manual'))();
}
