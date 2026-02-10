import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/app_database.dart';
import 'database_provider.dart';

final drinkTypesProvider = StreamProvider<List<DrinkType>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.drinkTypeDao.watchAllActive();
});

final waterTypeProvider = FutureProvider<DrinkType?>((ref) async {
  final db = ref.watch(databaseProvider);
  return db.drinkTypeDao.getById(1); // Water is always ID 1
});
