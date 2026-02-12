import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../shared/extensions/amount_extensions.dart';
import '../services/widget_service.dart';
import 'daily_goal_providers.dart';
import 'drink_entry_providers.dart';
import 'drink_type_providers.dart';
import 'settings_providers.dart';

final widgetUpdateProvider = Provider<void>((ref) {
  final totalMl = ref.watch(todayTotalMlProvider).valueOrNull ?? 0;
  final goalMl = ref.watch(goalMlProvider);
  final unit = ref.watch(unitSystemProvider);
  final entries = ref.watch(todayEntriesProvider).valueOrNull ?? [];
  final drinkTypes = ref.watch(drinkTypesProvider).valueOrNull ?? [];

  final drinkTypeMap = {for (final dt in drinkTypes) dt.id: dt};
  final progressPercent =
      goalMl > 0 ? min(1.0, totalMl / goalMl) : 0.0;
  final displayTotal = totalMl.displayAmount(unit);
  final displayGoal = goalMl.displayAmount(unit);

  final timeFormat = DateFormat.jm();
  final recent = entries
      .take(3)
      .map((e) {
        final dt = drinkTypeMap[e.drinkTypeId];
        return <String, String>{
          'icon': dt?.icon ?? '💧',
          'name': dt?.name ?? 'Water',
          'amount': e.amountMl.displayAmount(unit),
          'time': timeFormat.format(e.createdAt),
        };
      })
      .toList();

  WidgetService.updateWidgetData(
    totalMl: totalMl,
    goalMl: goalMl,
    progressPercent: progressPercent,
    displayTotal: displayTotal,
    displayGoal: displayGoal,
    recentEntries: recent,
  );
});
