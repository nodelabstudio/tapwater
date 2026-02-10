import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/drink_entries_table.dart';
import '../tables/drink_types_table.dart';

part 'drink_entry_dao.g.dart';

@DriftAccessor(tables: [DrinkEntries, DrinkTypes])
class DrinkEntryDao extends DatabaseAccessor<AppDatabase>
    with _$DrinkEntryDaoMixin {
  DrinkEntryDao(super.db);

  Stream<List<DrinkEntry>> watchEntriesForDay(DateTime start, DateTime end) {
    return (select(drinkEntries)
          ..where((e) =>
              e.createdAt.isBiggerOrEqualValue(start) &
              e.createdAt.isSmallerThanValue(end))
          ..orderBy([(e) => OrderingTerm.desc(e.createdAt)]))
        .watch();
  }

  Future<List<DrinkEntry>> getEntriesForDay(DateTime start, DateTime end) {
    return (select(drinkEntries)
          ..where((e) =>
              e.createdAt.isBiggerOrEqualValue(start) &
              e.createdAt.isSmallerThanValue(end))
          ..orderBy([(e) => OrderingTerm.desc(e.createdAt)]))
        .get();
  }

  Stream<int> watchTotalMlForDay(DateTime start, DateTime end) {
    final totalMl = drinkEntries.amountMl.sum();
    final query = selectOnly(drinkEntries)
      ..addColumns([totalMl])
      ..where(drinkEntries.createdAt.isBiggerOrEqualValue(start) &
          drinkEntries.createdAt.isSmallerThanValue(end));
    return query.watchSingle().map((row) => row.read(totalMl) ?? 0);
  }

  Future<int> getTotalMlForDay(DateTime start, DateTime end) async {
    final totalMl = drinkEntries.amountMl.sum();
    final query = selectOnly(drinkEntries)
      ..addColumns([totalMl])
      ..where(drinkEntries.createdAt.isBiggerOrEqualValue(start) &
          drinkEntries.createdAt.isSmallerThanValue(end));
    final row = await query.getSingle();
    return row.read(totalMl) ?? 0;
  }

  Future<int> insertEntry(DrinkEntriesCompanion entry) {
    return into(drinkEntries).insert(entry);
  }

  Future<bool> updateEntry(DrinkEntriesCompanion entry, int id) {
    return (update(drinkEntries)..where((e) => e.id.equals(id)))
        .write(entry)
        .then((rows) => rows > 0);
  }

  Future<int> deleteEntry(int id) {
    return (delete(drinkEntries)..where((e) => e.id.equals(id))).go();
  }

  /// Get all entries in a date range, for building the bubble calendar.
  Future<List<DrinkEntry>> getEntriesInRange(DateTime start, DateTime end) {
    return (select(drinkEntries)
          ..where((e) =>
              e.createdAt.isBiggerOrEqualValue(start) &
              e.createdAt.isSmallerThanValue(end))
          ..orderBy([(e) => OrderingTerm.asc(e.createdAt)]))
        .get();
  }

  Future<DrinkEntry?> getLastEntry() {
    return (select(drinkEntries)
          ..orderBy([(e) => OrderingTerm.desc(e.createdAt)])
          ..limit(1))
        .getSingleOrNull();
  }
}
