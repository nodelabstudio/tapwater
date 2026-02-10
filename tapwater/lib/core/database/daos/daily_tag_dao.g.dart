// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_tag_dao.dart';

// ignore_for_file: type=lint
mixin _$DailyTagDaoMixin on DatabaseAccessor<AppDatabase> {
  $DailyTagsTable get dailyTags => attachedDatabase.dailyTags;
  DailyTagDaoManager get managers => DailyTagDaoManager(this);
}

class DailyTagDaoManager {
  final _$DailyTagDaoMixin _db;
  DailyTagDaoManager(this._db);
  $$DailyTagsTableTableManager get dailyTags =>
      $$DailyTagsTableTableManager(_db.attachedDatabase, _db.dailyTags);
}
