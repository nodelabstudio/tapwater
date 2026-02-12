import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tapwater/app.dart';
import 'package:tapwater/config/theme/app_colors.dart';
import 'package:tapwater/core/database/app_database.dart';
import 'package:tapwater/core/providers/database_provider.dart';
import 'package:tapwater/core/providers/health_providers.dart';
import 'package:tapwater/core/providers/settings_providers.dart';
import 'package:tapwater/shared/extensions/amount_extensions.dart';

class QuickAddButton extends ConsumerWidget {
  const QuickAddButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unit = ref.watch(unitSystemProvider);
    final amountLabel = 250.displayAmount(unit);

    return SizedBox(
      width: 160,
      height: 160,
      child: Material(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(80),
        elevation: 4,
        child: InkWell(
          borderRadius: BorderRadius.circular(80),
          onTap: () => _addWater(context, ref),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.water_drop, color: Colors.white, size: 48),
              const SizedBox(height: 8),
              Text(
                '+ $amountLabel',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addWater(BuildContext context, WidgetRef ref) async {
    HapticFeedback.mediumImpact();
    final db = ref.read(databaseProvider);
    final unit = ref.read(unitSystemProvider);
    final displayLabel = 250.displayAmount(unit);
    final now = DateTime.now();
    final entryId = await db.drinkEntryDao.insertEntry(DrinkEntriesCompanion.insert(
      drinkTypeId: 1, // Water
      amountMl: 250,
      createdAt: now,
    ));

    // Sync to HealthKit if enabled
    final healthEnabled = ref.read(healthKitEnabledProvider);
    syncToHealthKit(enabled: healthEnabled, amountMl: 250, timestamp: now);

    if (!context.mounted) return;
    final messenger = rootScaffoldMessengerKey.currentState;
    if (messenger == null) return;
    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        content: Text('Added $displayLabel of Water'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
        showCloseIcon: true,
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            db.drinkEntryDao.deleteEntry(entryId);
          },
        ),
      ),
    );
    // Force dismiss after 5s — Flutter skips auto-dismiss when
    // accessibleNavigation is true and an action is present.
    Future.delayed(const Duration(seconds: 5), () {
      rootScaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    });
  }
}
