import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tapwater/core/models/enums.dart';
import 'package:tapwater/core/providers/daily_goal_providers.dart';
import 'package:tapwater/core/providers/database_provider.dart';
import 'package:tapwater/core/providers/drink_entry_providers.dart';
import 'package:tapwater/core/providers/drink_type_providers.dart';
import 'package:tapwater/core/providers/purchase_providers.dart';
import 'package:tapwater/core/providers/settings_providers.dart';
import 'package:tapwater/shared/extensions/amount_extensions.dart';
import 'package:tapwater/shared/extensions/date_extensions.dart';

/// Analytics data computed from drink history.
class _AnalyticsData {
  final int currentStreak;
  final int longestStreak;
  final int averageDailyMl;
  final int daysTracked;
  final Map<String, _BeverageBreakdown> beverageBreakdown;

  const _AnalyticsData({
    required this.currentStreak,
    required this.longestStreak,
    required this.averageDailyMl,
    required this.daysTracked,
    required this.beverageBreakdown,
  });
}

class _BeverageBreakdown {
  final String name;
  final String icon;
  final String colorHex;
  final int totalMl;

  const _BeverageBreakdown({
    required this.name,
    required this.icon,
    required this.colorHex,
    required this.totalMl,
  });
}

final _analyticsDataProvider = FutureProvider<_AnalyticsData>((ref) async {
  ref.watch(todayEntriesProvider);
  final db = ref.watch(databaseProvider);
  final goalMl = ref.watch(goalMlProvider);
  final dayBoundary = ref.watch(dayBoundaryHourProvider);
  final types = ref.watch(drinkTypesProvider).valueOrNull ?? [];
  final typeMap = {for (final t in types) t.id: t};

  final now = DateTime.now();

  // Compute streaks and daily totals for last 90 days
  int currentStreak = 0;
  int longestStreak = 0;
  int runningStreak = 0;
  int totalMlAll = 0;
  int daysWithData = 0;
  final beverageTotals = <int, int>{};

  for (int i = 0; i < 90; i++) {
    final day = now.subtract(Duration(days: i));
    final start = day.startOfDay(dayBoundaryHour: dayBoundary);
    final end = day.endOfDay(dayBoundaryHour: dayBoundary);

    final entries = await db.drinkEntryDao.getEntriesForDay(start, end);
    final dayTotal = entries.fold<int>(0, (sum, e) => sum + e.amountMl);

    if (dayTotal > 0) {
      daysWithData++;
      totalMlAll += dayTotal;
    }

    // Track beverage breakdown
    for (final entry in entries) {
      beverageTotals[entry.drinkTypeId] =
          (beverageTotals[entry.drinkTypeId] ?? 0) + entry.amountMl;
    }

    // Streak calculation
    if (dayTotal >= goalMl) {
      runningStreak++;
      if (i == 0 || currentStreak > 0) {
        currentStreak = runningStreak;
      }
      if (runningStreak > longestStreak) {
        longestStreak = runningStreak;
      }
    } else {
      if (i == 0) currentStreak = 0;
      runningStreak = 0;
    }
  }

  final avgDaily = daysWithData > 0 ? (totalMlAll / daysWithData).round() : 0;

  // Build beverage breakdown
  final breakdown = <String, _BeverageBreakdown>{};
  for (final entry in beverageTotals.entries) {
    final type = typeMap[entry.key];
    if (type != null) {
      breakdown[type.name] = _BeverageBreakdown(
        name: type.name,
        icon: type.icon,
        colorHex: type.colorHex,
        totalMl: entry.value,
      );
    }
  }

  return _AnalyticsData(
    currentStreak: currentStreak,
    longestStreak: longestStreak,
    averageDailyMl: avgDaily,
    daysTracked: daysWithData,
    beverageBreakdown: breakdown,
  );
});

class InsightsAnalytics extends ConsumerWidget {
  const InsightsAnalytics({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canUseAnalytics = ref.watch(purchaseProvider).canUseAnalytics;

    if (!canUseAnalytics) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Card(
          child: ListTile(
            leading: const Icon(Icons.insights),
            title: const Text('Insights & Analytics'),
            subtitle: const Text('Streaks, averages, and beverage breakdown'),
            trailing: const Icon(Icons.lock_outline, size: 18),
            onTap: () => context.push('/paywall'),
          ),
        ),
      );
    }

    final analytics = ref.watch(_analyticsDataProvider);

    return analytics.when(
      loading: () => const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, st) => const SizedBox.shrink(),
      data: (data) => _AnalyticsContent(data: data),
    );
  }
}

class _AnalyticsContent extends ConsumerWidget {
  final _AnalyticsData data;
  const _AnalyticsContent({required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final unit = ref.watch(unitSystemProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats row
          Row(
            children: [
              _StatCard(
                icon: Icons.local_fire_department,
                label: 'Current\nStreak',
                value: '${data.currentStreak}',
                unit: 'days',
                color: Colors.orange,
              ),
              const SizedBox(width: 8),
              _StatCard(
                icon: Icons.emoji_events,
                label: 'Longest\nStreak',
                value: '${data.longestStreak}',
                unit: 'days',
                color: Colors.amber,
              ),
              const SizedBox(width: 8),
              _StatCard(
                icon: Icons.show_chart,
                label: 'Daily\nAverage',
                value: data.averageDailyMl.displayAmount(unit).split(' ')[0],
                unit: unit.abbreviation,
                color: theme.colorScheme.primary,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Beverage breakdown
          if (data.beverageBreakdown.isNotEmpty) ...[
            Text('Beverage Breakdown (90 days)',
                style: theme.textTheme.titleSmall),
            const SizedBox(height: 12),
            SizedBox(
              height: 180,
              child: Row(
                children: [
                  Expanded(
                    child: _BeveragePieChart(
                        breakdown: data.beverageBreakdown),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _BeverageLegend(
                      breakdown: data.beverageBreakdown,
                      unit: unit,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String unit;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 4),
              Text(
                value,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(unit,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  )),
              const SizedBox(height: 2),
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BeveragePieChart extends StatelessWidget {
  final Map<String, _BeverageBreakdown> breakdown;
  const _BeveragePieChart({required this.breakdown});

  @override
  Widget build(BuildContext context) {
    final total = breakdown.values.fold<int>(0, (s, b) => s + b.totalMl);
    if (total == 0) return const SizedBox.shrink();

    final sections = breakdown.values.map((b) {
      final color = Color(int.parse(b.colorHex, radix: 16));
      final pct = b.totalMl / total * 100;
      return PieChartSectionData(
        value: pct,
        title: pct >= 5 ? '${pct.round()}%' : '',
        color: color,
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();

    return PieChart(
      PieChartData(
        sections: sections,
        sectionsSpace: 2,
        centerSpaceRadius: 30,
      ),
    );
  }
}

class _BeverageLegend extends StatelessWidget {
  final Map<String, _BeverageBreakdown> breakdown;
  final UnitSystem unit;
  const _BeverageLegend({required this.breakdown, required this.unit});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sorted = breakdown.values.toList()
      ..sort((a, b) => b.totalMl.compareTo(a.totalMl));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: sorted.take(6).map((b) {
        final color = Color(int.parse(b.colorHex, radix: 16));
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  '${b.icon} ${b.name}',
                  style: theme.textTheme.labelSmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                b.totalMl.displayAmount(unit),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
