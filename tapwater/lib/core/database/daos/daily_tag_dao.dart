import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/daily_tags_table.dart';

part 'daily_tag_dao.g.dart';

@DriftAccessor(tables: [DailyTags])
class DailyTagDao extends DatabaseAccessor<AppDatabase>
    with _$DailyTagDaoMixin {
  DailyTagDao(super.db);

  Future<List<DailyTag>> getTagsForDate(DateTime start, DateTime end) {
    return (select(dailyTags)
          ..where((t) =>
              t.date.isBiggerOrEqualValue(start) &
              t.date.isSmallerThanValue(end)))
        .get();
  }

  Stream<List<DailyTag>> watchTagsForDate(DateTime start, DateTime end) {
    return (select(dailyTags)
          ..where((t) =>
              t.date.isBiggerOrEqualValue(start) &
              t.date.isSmallerThanValue(end)))
        .watch();
  }

  Future<int> addTag(DateTime date, String tag) {
    return into(dailyTags).insert(DailyTagsCompanion(
      date: Value(date),
      tag: Value(tag),
    ));
  }

  Future<int> removeTag(int id) {
    return (delete(dailyTags)..where((t) => t.id.equals(id))).go();
  }
}
