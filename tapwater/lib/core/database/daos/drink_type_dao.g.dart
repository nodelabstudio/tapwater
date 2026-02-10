// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drink_type_dao.dart';

// ignore_for_file: type=lint
mixin _$DrinkTypeDaoMixin on DatabaseAccessor<AppDatabase> {
  $DrinkTypesTable get drinkTypes => attachedDatabase.drinkTypes;
  DrinkTypeDaoManager get managers => DrinkTypeDaoManager(this);
}

class DrinkTypeDaoManager {
  final _$DrinkTypeDaoMixin _db;
  DrinkTypeDaoManager(this._db);
  $$DrinkTypesTableTableManager get drinkTypes =>
      $$DrinkTypesTableTableManager(_db.attachedDatabase, _db.drinkTypes);
}
