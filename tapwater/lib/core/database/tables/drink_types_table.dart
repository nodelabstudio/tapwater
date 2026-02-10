import 'package:drift/drift.dart';

class DrinkTypes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get icon => text().withLength(min: 1, max: 10)();
  RealColumn get hydrationMultiplier => real().withDefault(const Constant(1.0))();
  IntColumn get defaultAmountMl => integer().withDefault(const Constant(250))();
  TextColumn get colorHex => text().withDefault(const Constant('FF2196F3'))();
  BoolColumn get isBuiltIn => boolean().withDefault(const Constant(true))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}
