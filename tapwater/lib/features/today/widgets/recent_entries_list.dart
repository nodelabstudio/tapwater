import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tapwater/core/database/app_database.dart';
import 'package:tapwater/core/models/enums.dart';
import 'package:tapwater/core/providers/drink_entry_providers.dart';
import 'package:tapwater/core/providers/drink_type_providers.dart';
import 'package:tapwater/core/providers/settings_providers.dart';
import 'package:tapwater/shared/extensions/amount_extensions.dart';

class RecentEntriesList extends ConsumerWidget {
  const RecentEntriesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(todayEntriesProvider);
    final drinkTypes = ref.watch(drinkTypesProvider);
    final unit = ref.watch(unitSystemProvider);

    return entries.when(
      loading: () => const SizedBox.shrink(),
      error: (e, st) => const SizedBox.shrink(),
      data: (entryList) {
        final recent = entryList.take(5).toList();
        if (recent.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'No entries yet today. Tap the button above to start!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          );
        }
        final types = drinkTypes.valueOrNull ?? [];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Recent',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            const SizedBox(height: 8),
            ...recent.map((e) => _EntryTile(
                  entry: e,
                  drinkType: types.where((t) => t.id == e.drinkTypeId).firstOrNull,
                  unit: unit,
                )),
          ],
        );
      },
    );
  }
}

class _EntryTile extends StatelessWidget {
  final DrinkEntry entry;
  final DrinkType? drinkType;
  final UnitSystem unit;

  const _EntryTile({
    required this.entry,
    this.drinkType,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    final timeStr = DateFormat.jm().format(entry.createdAt);
    return ListTile(
      dense: true,
      leading: Text(drinkType?.icon ?? '\u{1F4A7}', style: const TextStyle(fontSize: 24)),
      title: Text(drinkType?.name ?? 'Water'),
      subtitle: Text(timeStr),
      trailing: Text(
        entry.amountMl.displayAmount(unit),
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
