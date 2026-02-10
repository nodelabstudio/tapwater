import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tapwater/config/theme/app_colors.dart';
import 'package:tapwater/core/providers/database_provider.dart';
import 'package:tapwater/core/providers/daily_goal_providers.dart';
import 'package:tapwater/core/providers/settings_providers.dart';
import 'package:tapwater/shared/extensions/date_extensions.dart';

/// A provider that fetches daily totals for the entire year, keyed by date string.
final yearlyTotalsProvider =
    FutureProvider.family<Map<String, int>, int>((ref, year) async {
  final db = ref.watch(databaseProvider);
  final dayBoundary = ref.watch(dayBoundaryHourProvider);
  final start = DateTime(year, 1, 1).startOfDay(dayBoundaryHour: dayBoundary);
  final end = DateTime(year + 1, 1, 1).startOfDay(dayBoundaryHour: dayBoundary);
  final entries = await db.drinkEntryDao.getEntriesInRange(start, end);

  // Group entries by day
  final Map<String, int> dailyTotals = {};
  for (final entry in entries) {
    final day = DateTime(entry.createdAt.year, entry.createdAt.month, entry.createdAt.day);
    final key = '${day.year}-${day.month}-${day.day}';
    dailyTotals[key] = (dailyTotals[key] ?? 0) + entry.amountMl;
  }
  return dailyTotals;
});

class BubbleCalendar extends ConsumerWidget {
  const BubbleCalendar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentYear = DateTime.now().year;
    final goalMl = ref.watch(goalMlProvider);
    final yearlyData = ref.watch(yearlyTotalsProvider(currentYear));

    return yearlyData.when(
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (e, st) => Center(child: Text('Error: $e')),
      data: (dailyTotals) => _BubbleCalendarBody(
        year: currentYear,
        dailyTotals: dailyTotals,
        goalMl: goalMl,
      ),
    );
  }
}

class _BubbleCalendarBody extends StatelessWidget {
  final int year;
  final Map<String, int> dailyTotals;
  final int goalMl;

  const _BubbleCalendarBody({
    required this.year,
    required this.dailyTotals,
    required this.goalMl,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$year',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 12),
          // 2-column grid of months
          for (int row = 0; row < 6; row++) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _MonthGrid(
                    year: year,
                    month: row * 2 + 1,
                    dailyTotals: dailyTotals,
                    goalMl: goalMl,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _MonthGrid(
                    year: year,
                    month: row * 2 + 2,
                    dailyTotals: dailyTotals,
                    goalMl: goalMl,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ],
      ),
    );
  }
}

class _MonthGrid extends StatelessWidget {
  final int year;
  final int month;
  final Map<String, int> dailyTotals;
  final int goalMl;

  const _MonthGrid({
    required this.year,
    required this.month,
    required this.dailyTotals,
    required this.goalMl,
  });

  static const _monthNames = [
    '', 'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(year, month, 1);
    final daysInMonth = DateTime(year, month + 1, 0).day;
    // Monday = 1 (ISO), shift so Monday is column 0
    final startWeekday = (firstDay.weekday - 1) % 7;
    final today = DateTime.now();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _monthNames[month],
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 6),
        // Build rows of 7 bubbles
        ..._buildWeekRows(startWeekday, daysInMonth, today),
      ],
    );
  }

  List<Widget> _buildWeekRows(int startWeekday, int daysInMonth, DateTime today) {
    final rows = <Widget>[];
    int dayCounter = 1;
    final totalSlots = startWeekday + daysInMonth;
    final totalRows = (totalSlots / 7).ceil();

    for (int week = 0; week < totalRows; week++) {
      final bubbles = <Widget>[];
      for (int col = 0; col < 7; col++) {
        final slotIndex = week * 7 + col;
        if (slotIndex < startWeekday || dayCounter > daysInMonth) {
          // Empty slot
          bubbles.add(const _Bubble(intensity: -1));
        } else {
          final date = DateTime(year, month, dayCounter);
          final key = '$year-$month-$dayCounter';
          final totalMl = dailyTotals[key] ?? 0;
          final isFuture = date.isAfter(today);

          double intensity;
          if (isFuture) {
            intensity = -1; // Empty for future dates
          } else if (totalMl == 0) {
            intensity = 0; // No data
          } else {
            // Scale: 0.0 (none) to 1.0 (goal met or exceeded)
            intensity = (totalMl / goalMl).clamp(0.0, 1.0);
          }

          bubbles.add(_Bubble(intensity: intensity));
          dayCounter++;
        }
      }
      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: bubbles,
          ),
        ),
      );
    }
    return rows;
  }
}

class _Bubble extends StatelessWidget {
  /// -1 = empty/invisible, 0 = no intake, 0.0-1.0 = hydration level
  final double intensity;

  const _Bubble({required this.intensity});

  @override
  Widget build(BuildContext context) {
    if (intensity < 0) {
      // Invisible placeholder
      return const SizedBox(width: 18, height: 18);
    }

    Color color;
    if (intensity == 0) {
      // No data - very light gray
      color = AppColors.primary.withValues(alpha: 0.08);
    } else {
      // Scale from light blue to dark blue
      // Min opacity 0.2, max 1.0
      final alpha = 0.2 + (intensity * 0.8);
      color = AppColors.primaryDark.withValues(alpha: alpha);
    }

    return Container(
      width: 18,
      height: 18,
      margin: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
