import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tapwater/core/providers/drink_entry_providers.dart';
import 'package:tapwater/core/providers/drink_type_providers.dart';
import 'package:tapwater/core/providers/purchase_providers.dart';
import 'package:tapwater/core/providers/settings_providers.dart';
import 'package:tapwater/features/history/widgets/entry_edit_sheet.dart';
import 'package:tapwater/shared/extensions/amount_extensions.dart';
import 'calendar_strip.dart';

class DailyEntriesList extends ConsumerWidget {
  const DailyEntriesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(selectedDateProvider);
    final entries = ref.watch(entriesForDateProvider(date));
    final drinkTypes = ref.watch(drinkTypesProvider);
    final unit = ref.watch(unitSystemProvider);

    return entries.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
      data: (entryList) {
        if (entryList.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(32),
            child: Text(
              'No entries for this day.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          );
        }
        final types = drinkTypes.valueOrNull ?? [];
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: entryList.length,
          itemBuilder: (context, index) {
            final entry = entryList[index];
            final type =
                types.where((t) => t.id == entry.drinkTypeId).firstOrNull;
            final canEdit = ref.watch(purchaseProvider).canEditEntries;
            return ListTile(
              leading: Text(
                type?.icon ?? '\u{1F4A7}',
                style: const TextStyle(fontSize: 24),
              ),
              title: Text(type?.name ?? 'Water'),
              subtitle: Text(DateFormat.jm().format(entry.createdAt)),
              trailing: Text(
                entry.amountMl.displayAmount(unit),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              onTap: () {
                if (canEdit) {
                  showEntryEditSheet(context, ref, entry);
                } else {
                  context.push('/paywall');
                }
              },
            );
          },
        );
      },
    );
  }
}
