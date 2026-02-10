import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/drink_types_table.dart';

part 'drink_type_dao.g.dart';

@DriftAccessor(tables: [DrinkTypes])
class DrinkTypeDao extends DatabaseAccessor<AppDatabase>
    with _$DrinkTypeDaoMixin {
  DrinkTypeDao(super.db);

  Stream<List<DrinkType>> watchAllActive() {
    return (select(drinkTypes)
          ..where((t) => t.isActive.equals(true))
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .watch();
  }

  Future<List<DrinkType>> getAllActive() {
    return (select(drinkTypes)
          ..where((t) => t.isActive.equals(true))
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .get();
  }

  Future<DrinkType?> getById(int id) {
    return (select(drinkTypes)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertDrinkType(DrinkTypesCompanion entry) {
    return into(drinkTypes).insert(entry);
  }

  Future<bool> updateDrinkType(DrinkTypesCompanion entry, int id) {
    return (update(drinkTypes)..where((t) => t.id.equals(id))).write(entry).then((rows) => rows > 0);
  }

  Future<int> deactivate(int id) {
    return (update(drinkTypes)..where((t) => t.id.equals(id)))
        .write(const DrinkTypesCompanion(isActive: Value(false)));
  }
}
