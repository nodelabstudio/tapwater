import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tapwater/core/database/app_database.dart';
import 'package:tapwater/core/models/enums.dart';
import 'package:tapwater/core/providers/database_provider.dart';
import 'package:tapwater/core/providers/drink_type_providers.dart';
import 'package:tapwater/core/providers/settings_providers.dart';
import 'package:tapwater/shared/extensions/amount_extensions.dart';

void showDrinkPickerSheet(
  BuildContext context,
  WidgetRef ref, {
  DrinkType? preselectedType,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) => _DrinkPickerContent(preselectedType: preselectedType),
  );
}

class _DrinkPickerContent extends ConsumerStatefulWidget {
  final DrinkType? preselectedType;
  const _DrinkPickerContent({this.preselectedType});

  @override
  ConsumerState<_DrinkPickerContent> createState() => _DrinkPickerContentState();
}

class _DrinkPickerContentState extends ConsumerState<_DrinkPickerContent> {
  DrinkType? _selectedType;
  late TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _selectedType = widget.preselectedType;
    _amountController = TextEditingController(
      text: (widget.preselectedType?.defaultAmountMl ?? 250).toString(),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final drinkTypes = ref.watch(drinkTypesProvider);
    final unit = ref.watch(unitSystemProvider);

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Add Drink',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          // Drink type selector
          drinkTypes.when(
            loading: () => const CircularProgressIndicator(),
            error: (e, st) => const Text('Error loading drink types'),
            data: (types) => Wrap(
              spacing: 8,
              runSpacing: 8,
              children: types.map((type) {
                final selected = _selectedType?.id == type.id;
                final color = Color(int.parse(type.colorHex, radix: 16));
                return ChoiceChip(
                  label: Text('${type.icon} ${type.name}'),
                  selected: selected,
                  selectedColor: color.withValues(alpha: 0.2),
                  onSelected: (_) {
                    setState(() {
                      _selectedType = type;
                      _amountController.text = type.defaultAmountMl.toString();
                    });
                  },
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
          // Amount input
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Amount (${unit.abbreviation})',
              border: const OutlineInputBorder(),
              suffixText: unit.abbreviation,
            ),
          ),
          const SizedBox(height: 8),
          // Quick amounts
          Row(
            children: [
              for (final amt in _quickAmounts(unit))
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: OutlinedButton(
                      onPressed: () => _amountController.text = amt.toString(),
                      child: Text('$amt'),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: _selectedType == null ? null : _save,
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  List<int> _quickAmounts(UnitSystem unit) {
    if (unit == UnitSystem.imperial) {
      return [8, 12, 16, 24];
    }
    return [150, 250, 350, 500];
  }

  Future<void> _save() async {
    final type = _selectedType;
    if (type == null) return;

    final unit = ref.read(unitSystemProvider);
    var amountMl = int.tryParse(_amountController.text) ?? type.defaultAmountMl;
    if (unit == UnitSystem.imperial) {
      amountMl = amountMl.toMl().round();
    }

    HapticFeedback.mediumImpact();
    final db = ref.read(databaseProvider);
    await db.drinkEntryDao.insertEntry(DrinkEntriesCompanion.insert(
      drinkTypeId: type.id,
      amountMl: amountMl,
      createdAt: DateTime.now(),
    ));

    if (mounted) Navigator.pop(context);
  }
}
