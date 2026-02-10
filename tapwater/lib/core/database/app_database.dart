import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../../shared/constants/default_drink_types.dart';
import 'tables/drink_entries_table.dart';
import 'tables/drink_types_table.dart';
import 'tables/daily_goals_table.dart';
import 'tables/user_settings_table.dart';
import 'tables/daily_tags_table.dart';
import 'daos/drink_entry_dao.dart';
import 'daos/drink_type_dao.dart';
import 'daos/daily_goal_dao.dart';
import 'daos/user_settings_dao.dart';
import 'daos/daily_tag_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [DrinkEntries, DrinkTypes, DailyGoals, UserSettings, DailyTags],
  daos: [DrinkEntryDao, DrinkTypeDao, DailyGoalDao, UserSettingsDao, DailyTagDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          await _seedData();
        },
      );

  Future<void> _seedData() async {
    // Seed default drink types
    for (final dt in defaultDrinkTypes) {
      await into(drinkTypes).insert(DrinkTypesCompanion.insert(
        name: dt.name,
        icon: dt.icon,
        hydrationMultiplier: Value(dt.hydrationMultiplier),
        defaultAmountMl: Value(dt.defaultAmountMl),
        colorHex: Value(dt.colorHex),
        sortOrder: Value(dt.sortOrder),
      ));
    }

    // Seed default daily goal
    await into(dailyGoals).insert(DailyGoalsCompanion.insert(
      effectiveFrom: DateTime.now(),
    ));

    // Seed default user settings
    await into(userSettings).insert(const UserSettingsCompanion());
  }

  Future<void> deleteAllData() async {
    await transaction(() async {
      await delete(drinkEntries).go();
      await delete(dailyTags).go();
      await delete(dailyGoals).go();
      await (delete(drinkTypes)..where((t) => t.isBuiltIn.equals(false))).go();
      // Reset built-in types to active
      await (update(drinkTypes)..where((t) => t.isBuiltIn.equals(true)))
          .write(const DrinkTypesCompanion(isActive: Value(true)));
      // Re-seed goal and settings
      await delete(userSettings).go();
      await into(dailyGoals).insert(DailyGoalsCompanion.insert(
        effectiveFrom: DateTime.now(),
      ));
      await into(userSettings).insert(const UserSettingsCompanion());
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'tapwater.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
