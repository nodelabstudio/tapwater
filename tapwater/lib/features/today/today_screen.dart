import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tapwater/core/providers/daily_goal_providers.dart';
import 'package:tapwater/core/providers/drink_entry_providers.dart';
import 'package:tapwater/core/providers/settings_providers.dart';
import 'package:tapwater/shared/extensions/amount_extensions.dart';
import 'widgets/daily_tags_section.dart';
import 'widgets/favorites_bar.dart';
import 'widgets/milestone_message.dart';
import 'widgets/progress_ring.dart';
import 'widgets/quick_add_button.dart';
import 'widgets/recent_entries_list.dart';

class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalMl = ref.watch(todayTotalMlProvider).valueOrNull ?? 0;
    final goalMl = ref.watch(goalMlProvider);
    final unit = ref.watch(unitSystemProvider);
    final displayText =
        '${totalMl.displayAmount(unit)} / ${goalMl.displayAmount(unit)}';

    return Scaffold(
      appBar: AppBar(title: const Text('TapWater')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            ProgressRing(
              currentMl: totalMl,
              goalMl: goalMl,
              displayText: displayText,
            ),
            MilestoneMessage(currentMl: totalMl, goalMl: goalMl),
            const SizedBox(height: 24),
            const QuickAddButton(),
            const SizedBox(height: 24),
            const FavoritesBar(),
            const SizedBox(height: 16),
            const DailyTagsSection(),
            const SizedBox(height: 16),
            const RecentEntriesList(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
