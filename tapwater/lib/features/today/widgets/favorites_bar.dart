import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tapwater/core/database/app_database.dart';
import 'package:tapwater/core/providers/drink_type_providers.dart';
import 'package:tapwater/core/providers/purchase_providers.dart';
import 'package:tapwater/features/shared/custom_drink_sheet.dart';
import 'package:tapwater/features/shared/drink_picker_sheet.dart';

class FavoritesBar extends ConsumerWidget {
  const FavoritesBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drinkTypes = ref.watch(drinkTypesProvider);
    final canCustomize = ref.watch(purchaseProvider).canUseCustomDrinks;

    return drinkTypes.when(
      loading: () => const SizedBox(height: 80),
      error: (e, st) => const SizedBox.shrink(),
      data: (types) => SizedBox(
        height: 80,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: types.length + (canCustomize ? 1 : 0),
          separatorBuilder: (_, i) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            if (index == types.length) {
              return _AddCustomChip();
            }
            final type = types[index];
            return _FavoriteChip(drinkType: type);
          },
        ),
      ),
    );
  }
}

class _AddCustomChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => showCustomDrinkSheet(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: theme.colorScheme.outlineVariant,
                style: BorderStyle.solid,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.add,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Custom',
            style: theme.textTheme.labelSmall,
            overflow: TextOverflow.ellipsis,
          ),
        ],
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
    final canCustomize = ref.watch(purchaseProvider).canUseCustomDrinks;
    return GestureDetector(
      onTap: () {
        if (!canUse) {
          context.push('/paywall');
          return;
        }
        showDrinkPickerSheet(context, ref, preselectedType: drinkType);
      },
      onLongPress: canCustomize && !drinkType.isBuiltIn
          ? () => showCustomDrinkSheet(context, existing: drinkType)
          : null,
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
