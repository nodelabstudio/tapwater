import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tapwater/core/database/app_database.dart';
import 'package:tapwater/core/models/enums.dart';
import 'package:go_router/go_router.dart';
import 'package:tapwater/core/providers/daily_goal_providers.dart';
import 'package:tapwater/core/providers/database_provider.dart';
import 'package:tapwater/core/providers/drink_entry_providers.dart';
import 'package:tapwater/core/providers/purchase_providers.dart';
import 'package:tapwater/core/providers/settings_providers.dart';
import 'package:tapwater/core/services/notification_service.dart';
import 'package:tapwater/shared/extensions/amount_extensions.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(userSettingsProvider);
    final goalMl = ref.watch(goalMlProvider);
    final unit = ref.watch(unitSystemProvider);
    final purchaseState = ref.watch(purchaseProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: settings.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
        data: (s) => ListView(
          children: [
            // Daily Goal
            _SectionHeader('Daily Goal'),
            ListTile(
              leading: const Icon(Icons.flag),
              title: const Text('Daily Goal'),
              subtitle: Text(goalMl.displayAmount(unit)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _editGoal(context, ref, goalMl),
            ),
            const Divider(),

            // Units
            _SectionHeader('Preferences'),
            ListTile(
              leading: const Icon(Icons.straighten),
              title: const Text('Units'),
              subtitle: Text(unit.label),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _toggleUnits(ref, s),
            ),

            // Day Boundary (Pro)
            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text('Day Boundary'),
              subtitle: Text(s.dayBoundaryHour == 0
                  ? 'Midnight (default)'
                  : '${s.dayBoundaryHour}:00'),
              trailing: purchaseState.canSetDayBoundary
                  ? const Icon(Icons.chevron_right)
                  : const Icon(Icons.lock_outline, size: 18),
              onTap: () {
                if (purchaseState.canSetDayBoundary) {
                  _editDayBoundary(context, ref, s.dayBoundaryHour);
                } else {
                  context.push('/paywall');
                }
              },
            ),
            const Divider(),

            // Subscription
            _SectionHeader('Subscription'),
            ListTile(
              leading: const Icon(Icons.star_outline),
              title: Text(purchaseState.tier == PurchaseTier.free
                  ? 'Upgrade to Pro'
                  : 'Current Plan: ${purchaseState.tier.name}'),
              subtitle: Text(purchaseState.tier == PurchaseTier.free
                  ? 'Unlock editing, custom drinks, and more'
                  : 'Thank you for your support!'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/paywall'),
            ),
            const Divider(),

            // Reminders
            _SectionHeader('Reminders'),
            SwitchListTile(
              secondary: const Icon(Icons.notifications_outlined),
              title: const Text('Reminders'),
              subtitle: Text(s.remindersEnabled
                  ? 'Every ${s.reminderIntervalMinutes} min, ${s.reminderStartHour}:00 - ${s.reminderEndHour}:00'
                  : 'Off'),
              value: s.remindersEnabled,
              onChanged: (v) => _toggleReminders(ref, s, v),
            ),
            const Divider(),

            // About
            _SectionHeader('About'),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('TapWater'),
              subtitle: const Text('Version 1.0.0'),
            ),
            ListTile(
              leading: const Icon(Icons.email_outlined),
              title: const Text('Contact Support'),
              subtitle: const Text('tapwater@use.startmail.com'),
            ),
            const Divider(),

            // Danger Zone
            _SectionHeader('Data'),
            ListTile(
              leading: Icon(Icons.delete_forever,
                  color: Theme.of(context).colorScheme.error),
              title: Text('Delete All Data',
                  style: TextStyle(color: Theme.of(context).colorScheme.error)),
              onTap: () => _deleteAllData(context, ref),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  static const double _mlPerOz = 29.5735;

  Future<void> _editGoal(BuildContext context, WidgetRef ref, int currentMl) async {
    final unit = ref.read(unitSystemProvider);
    final isOz = unit == UnitSystem.imperial;
    // Convert current ml goal to display units for the slider
    double displayValue = isOz ? currentMl / _mlPerOz : currentMl.toDouble();
    displayValue = displayValue.roundToDouble();
    final sliderMin = isOz ? 34.0 : 1000.0;
    final sliderMax = isOz ? 170.0 : 5000.0;
    final divisions = isOz ? 136 : 40;
    final unitLabel = isOz ? 'oz' : 'ml';

    final result = await showDialog<int>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Daily Goal'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${displayValue.round()} $unitLabel',
                  style: Theme.of(context).textTheme.headlineSmall),
              Slider(
                value: displayValue.clamp(sliderMin, sliderMax),
                min: sliderMin,
                max: sliderMax,
                divisions: divisions,
                onChanged: (v) => setState(() => displayValue = v.roundToDouble()),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            FilledButton(
                onPressed: () {
                  final ml = isOz ? (displayValue * _mlPerOz).round() : displayValue.round();
                  Navigator.pop(context, ml);
                },
                child: const Text('Save')),
          ],
        ),
      ),
    );
    if (result != null) {
      ref.read(databaseProvider).dailyGoalDao.setGoal(result);
    }
  }

  Future<void> _toggleUnits(WidgetRef ref, UserSetting s) async {
    final newUnit = s.unitSystem == 'metric' ? 'imperial' : 'metric';
    await ref.read(databaseProvider).userSettingsDao.updateSettings(
          UserSettingsCompanion(unitSystem: drift.Value(newUnit)),
        );
  }

  Future<void> _editDayBoundary(
      BuildContext context, WidgetRef ref, int current) async {
    final result = await showDialog<int>(
      context: context,
      builder: (context) {
        int hour = current;
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: const Text('Day Boundary'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(hour == 0 ? 'Midnight' : '$hour:00'),
                Slider(
                  value: hour.toDouble(),
                  min: 0,
                  max: 6,
                  divisions: 6,
                  onChanged: (v) => setState(() => hour = v.round()),
                ),
                const Text('Useful for shift workers. Day resets at this hour.',
                    style: TextStyle(fontSize: 12)),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel')),
              FilledButton(
                  onPressed: () => Navigator.pop(context, hour),
                  child: const Text('Save')),
            ],
          ),
        );
      },
    );
    if (result != null) {
      await ref.read(databaseProvider).userSettingsDao.updateSettings(
            UserSettingsCompanion(dayBoundaryHour: drift.Value(result)),
          );
    }
  }

  Future<void> _toggleReminders(
      WidgetRef ref, UserSetting s, bool enabled) async {
    await ref.read(databaseProvider).userSettingsDao.updateSettings(
          UserSettingsCompanion(remindersEnabled: drift.Value(enabled)),
        );
    final notif = NotificationService();
    if (enabled) {
      await notif.requestPermission();
      await notif.scheduleReminders(
        startHour: s.reminderStartHour,
        endHour: s.reminderEndHour,
        intervalMinutes: s.reminderIntervalMinutes,
      );
    } else {
      await notif.cancelAll();
    }
  }

  Future<void> _deleteAllData(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete All Data'),
        content: const Text(
          'This will permanently delete all your entries, goals, and settings. '
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel')),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete Everything'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(databaseProvider).deleteAllData();
      // Force all providers to refresh so UI reflects the deletion
      ref.invalidate(goalMlProvider);
      ref.invalidate(userSettingsProvider);
      ref.invalidate(todayEntriesProvider);
      ref.invalidate(todayTotalMlProvider);
      ref.invalidate(weeklyTotalsProvider);
    }
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}
