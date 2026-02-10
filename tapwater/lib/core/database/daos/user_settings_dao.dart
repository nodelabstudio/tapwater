import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/user_settings_table.dart';

part 'user_settings_dao.g.dart';

@DriftAccessor(tables: [UserSettings])
class UserSettingsDao extends DatabaseAccessor<AppDatabase>
    with _$UserSettingsDaoMixin {
  UserSettingsDao(super.db);

  Future<UserSetting> getSettings() async {
    final result = await select(userSettings).getSingleOrNull();
    if (result != null) return result;
    // Create defaults if none exist
    await into(userSettings).insert(const UserSettingsCompanion());
    return select(userSettings).getSingle();
  }

  Stream<UserSetting> watchSettings() {
    return select(userSettings).watchSingle();
  }

  Future<void> updateSettings(UserSettingsCompanion companion) async {
    final existing = await select(userSettings).getSingleOrNull();
    if (existing != null) {
      await (update(userSettings)..where((s) => s.id.equals(existing.id)))
          .write(companion);
    } else {
      await into(userSettings).insert(companion);
    }
  }
}
