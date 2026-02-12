import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tapwater/core/database/app_database.dart';
import 'package:tapwater/core/providers/database_provider.dart';
import 'package:tapwater/core/providers/purchase_providers.dart';
import 'package:tapwater/core/providers/settings_providers.dart';
import 'package:tapwater/shared/extensions/date_extensions.dart';

final _todayTagsProvider = StreamProvider<List<DailyTag>>((ref) {
  final db = ref.watch(databaseProvider);
  final dayBoundary = ref.watch(dayBoundaryHourProvider);
  final now = DateTime.now();
  final start = now.startOfDay(dayBoundaryHour: dayBoundary);
  final end = now.endOfDay(dayBoundaryHour: dayBoundary);
  return db.dailyTagDao.watchTagsForDate(start, end);
});

class DailyTagsSection extends ConsumerWidget {
  const DailyTagsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canUseTags = ref.watch(purchaseProvider).canUseTags;

    if (!canUseTags) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: _lockedTagsCard(context),
      );
    }

    final tags = ref.watch(_todayTagsProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Notes',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.add, size: 20),
                onPressed: () => _addTag(context, ref),
                tooltip: 'Add note',
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          tags.when(
            loading: () => const SizedBox.shrink(),
            error: (e, st) => const SizedBox.shrink(),
            data: (tagList) {
              if (tagList.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Tap + to add notes about your day',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant,
                        ),
                  ),
                );
              }
              return Wrap(
                spacing: 8,
                runSpacing: 4,
                children: tagList.map((tag) {
                  return Chip(
                    label: Text(tag.tag),
                    deleteIcon: const Icon(Icons.close, size: 16),
                    onDeleted: () => ref
                        .read(databaseProvider)
                        .dailyTagDao
                        .removeTag(tag.id),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _lockedTagsCard(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.note_alt_outlined),
        title: const Text('Daily Notes'),
        subtitle: const Text('Track habits, mood, and more'),
        trailing: const Icon(Icons.lock_outline, size: 18),
        onTap: () => context.push('/paywall'),
        dense: true,
      ),
    );
  }

  Future<void> _addTag(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Note'),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLength: 100,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            hintText: 'e.g. Gym day, Felt tired, Hot weather...',
            border: OutlineInputBorder(),
          ),
          onSubmitted: (v) => Navigator.pop(context, v),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Add'),
          ),
        ],
      ),
    );

    if (result != null && result.trim().isNotEmpty) {
      final dayBoundary = ref.read(dayBoundaryHourProvider);
      final now = DateTime.now();
      final start = now.startOfDay(dayBoundaryHour: dayBoundary);
      await ref.read(databaseProvider).dailyTagDao.addTag(start, result.trim());
    }
    controller.dispose();
  }
}
