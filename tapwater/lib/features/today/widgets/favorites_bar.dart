import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tapwater/core/database/app_database.dart';
import 'package:tapwater/core/providers/drink_type_providers.dart';
import 'package:tapwater/core/providers/purchase_providers.dart';
import 'package:tapwater/features/shared/drink_picker_sheet.dart';

class FavoritesBar extends ConsumerWidget {
  const FavoritesBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drinkTypes = ref.watch(drinkTypesProvider);

    return drinkTypes.when(
      loading: () => const SizedBox(height: 80),
      error: (e, st) => const SizedBox.shrink(),
      data: (types) => SizedBox(
        height: 80,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: types.length,
          separatorBuilder: (_, i) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final type = types[index];
            return _FavoriteChip(drinkType: type);
          },
        ),
      ),
    );
  }
}

class _FavoriteChip extends ConsumerWidget {
  final DrinkType drinkType;
  const _FavoriteChip({required this.drinkType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Color(int.parse(drinkType.colorHex, radix: 16));
    final isWater = drinkType.id == 1;
    final canUse = isWater || ref.watch(purchaseProvider).canUseNonWaterFavorites;
    return GestureDetector(
      onTap: () {
        if (!canUse) {
          context.push('/paywall');
          return;
        }
        showDrinkPickerSheet(context, ref, preselectedType: drinkType);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Center(
              child: Text(
                drinkType.icon,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            drinkType.name,
            style: Theme.of(context).textTheme.labelSmall,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
