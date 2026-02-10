// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drink_entry_dao.dart';

// ignore_for_file: type=lint
mixin _$DrinkEntryDaoMixin on DatabaseAccessor<AppDatabase> {
  $DrinkTypesTable get drinkTypes => attachedDatabase.drinkTypes;
  $DrinkEntriesTable get drinkEntries => attachedDatabase.drinkEntries;
  DrinkEntryDaoManager get managers => DrinkEntryDaoManager(this);
}

class DrinkEntryDaoManager {
  final _$DrinkEntryDaoMixin _db;
  DrinkEntryDaoManager(this._db);
  $$DrinkTypesTableTableManager get drinkTypes =>
      $$DrinkTypesTableTableManager(_db.attachedDatabase, _db.drinkTypes);
  $$DrinkEntriesTableTableManager get drinkEntries =>
      $$DrinkEntriesTableTableManager(_db.attachedDatabase, _db.drinkEntries);
}
