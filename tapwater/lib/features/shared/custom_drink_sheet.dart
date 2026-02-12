import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tapwater/core/database/app_database.dart';
import 'package:tapwater/core/models/enums.dart';
import 'package:tapwater/core/providers/database_provider.dart';
import 'package:tapwater/core/providers/settings_providers.dart';
import 'package:tapwater/shared/extensions/amount_extensions.dart';

/// Shows a bottom sheet for creating or editing a custom drink type.
void showCustomDrinkSheet(BuildContext context, {DrinkType? existing}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => _CustomDrinkContent(existing: existing),
  );
}

const _iconOptions = [
  '\u{1F4A7}', // water drop
  '\u{2615}',  // coffee
  '\u{1FAD6}', // teapot
  '\u{1F9C3}', // juice box
  '\u{1F95B}', // milk
  '\u{1F964}', // cup with straw
  '\u{1F353}', // strawberry
  '\u{1F3C3}', // runner
  '\u{1F37A}', // beer
  '\u{1F377}', // wine
  '\u{1F375}', // tea cup
  '\u{1F9CB}', // bubble tea
  '\u{1F378}', // cocktail
  '\u{1F379}', // tropical drink
  '\u{1FAD7}', // pouring liquid
  '\u{1F95C}', // peanut (nut milk)
  '\u{1F36B}', // chocolate (hot cocoa)
  '\u{1F34A}', // tangerine (citrus)
  '\u{1F34F}', // apple
  '\u{1F952}', // cucumber (infused water)
];

const _colorOptions = [
  'FF2196F3', // Blue
  'FF795548', // Brown
  'FF8BC34A', // Light Green
  'FFFF9800', // Orange
  'FFE91E63', // Pink
  'FF9C27B0', // Purple
  'FF00BCD4', // Cyan
  'FF4CAF50', // Green
  'FFFF5722', // Deep Orange
  'FF607D8B', // Blue Grey
  'FFF44336', // Red
  'FF3F51B5', // Indigo
];

class _CustomDrinkContent extends ConsumerStatefulWidget {
  final DrinkType? existing;
  const _CustomDrinkContent({this.existing});

  @override
  ConsumerState<_CustomDrinkContent> createState() =>
      _CustomDrinkContentState();
}

class _CustomDrinkContentState extends ConsumerState<_CustomDrinkContent> {
  late TextEditingController _nameController;
  late TextEditingController _amountController;
  late String _selectedIcon;
  late String _selectedColor;
  late double _hydrationMultiplier;

  bool get _isEditing => widget.existing != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.existing?.name ?? '');
    _amountController = TextEditingController();
    _selectedIcon = widget.existing?.icon ?? _iconOptions[0];
    _selectedColor = widget.existing?.colorHex ?? _colorOptions[0];
    _hydrationMultiplier = widget.existing?.hydrationMultiplier ?? 1.0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_amountController.text.isEmpty) {
      final defaultMl = widget.existing?.defaultAmountMl ?? 250;
      final unit = ref.read(unitSystemProvider);
      _amountController.text = (unit == UnitSystem.imperial
              ? defaultMl.toOz().round()
              : defaultMl)
          .toString();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final unit = ref.watch(unitSystemProvider);
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurfaceVariant
                      .withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _isEditing ? 'Edit Drink Type' : 'Create Drink Type',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            // Name
            TextField(
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
                hintText: 'e.g. Coconut Water',
              ),
              maxLength: 50,
            ),
            const SizedBox(height: 12),
            // Icon picker
            Text('Icon', style: theme.textTheme.labelLarge),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _iconOptions.map((icon) {
                final selected = icon == _selectedIcon;
                return GestureDetector(
                  onTap: () => setState(() => _selectedIcon = icon),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: selected
                            ? theme.colorScheme.primary
                            : theme.colorScheme.outlineVariant,
                        width: selected ? 2 : 1,
                      ),
                      color: selected
                          ? theme.colorScheme.primary.withValues(alpha: 0.1)
                          : null,
                    ),
                    child: Center(
                      child: Text(icon, style: const TextStyle(fontSize: 20)),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            // Color picker
            Text('Color', style: theme.textTheme.labelLarge),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _colorOptions.map((hex) {
                final color = Color(int.parse(hex, radix: 16));
                final selected = hex == _selectedColor;
                return GestureDetector(
                  onTap: () => setState(() => _selectedColor = hex),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                      border: Border.all(
                        color: selected
                            ? theme.colorScheme.onSurface
                            : Colors.transparent,
                        width: selected ? 3 : 0,
                      ),
                    ),
                    child: selected
                        ? Icon(Icons.check,
                            size: 18,
                            color: color.computeLuminance() > 0.5
                                ? Colors.black
                                : Colors.white)
                        : null,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            // Default amount
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: 'Default Amount (${unit.abbreviation})',
                border: const OutlineInputBorder(),
                suffixText: unit.abbreviation,
              ),
            ),
            const SizedBox(height: 16),
            // Hydration multiplier
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Hydration Factor: ${(_hydrationMultiplier * 100).round()}%',
                    style: theme.textTheme.labelLarge,
                  ),
                ),
                Text(
                  _hydrationLabel(),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            Slider(
              value: _hydrationMultiplier,
              min: 0.0,
              max: 1.5,
              divisions: 15,
              onChanged: (v) =>
                  setState(() => _hydrationMultiplier = (v * 10).round() / 10),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                if (_isEditing && !(widget.existing?.isBuiltIn ?? true))
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _deactivate,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: theme.colorScheme.error,
                      ),
                      child: const Text('Delete'),
                    ),
                  ),
                if (_isEditing && !(widget.existing?.isBuiltIn ?? true))
                  const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: _save,
                    child: Text(_isEditing ? 'Save' : 'Create'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _hydrationLabel() {
    if (_hydrationMultiplier >= 1.0) return 'Full hydration';
    if (_hydrationMultiplier >= 0.8) return 'Good hydration';
    if (_hydrationMultiplier >= 0.5) return 'Moderate';
    return 'Low hydration';
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    final unit = ref.read(unitSystemProvider);
    var amountMl = int.tryParse(_amountController.text) ?? 250;
    if (unit == UnitSystem.imperial) {
      amountMl = amountMl.toMl().round();
    }

    final db = ref.read(databaseProvider);

    if (_isEditing) {
      await db.drinkTypeDao.updateDrinkType(
        DrinkTypesCompanion(
          name: drift.Value(name),
          icon: drift.Value(_selectedIcon),
          colorHex: drift.Value(_selectedColor),
          defaultAmountMl: drift.Value(amountMl),
          hydrationMultiplier: drift.Value(_hydrationMultiplier),
        ),
        widget.existing!.id,
      );
    } else {
      // Get next sort order
      final allTypes = await db.drinkTypeDao.getAllActive();
      final nextSort =
          allTypes.isEmpty ? 0 : allTypes.last.sortOrder + 1;

      await db.drinkTypeDao.insertDrinkType(
        DrinkTypesCompanion(
          name: drift.Value(name),
          icon: drift.Value(_selectedIcon),
          colorHex: drift.Value(_selectedColor),
          defaultAmountMl: drift.Value(amountMl),
          hydrationMultiplier: drift.Value(_hydrationMultiplier),
          isBuiltIn: const drift.Value(false),
          isActive: const drift.Value(true),
          sortOrder: drift.Value(nextSort),
        ),
      );
    }

    HapticFeedback.lightImpact();
    if (mounted) Navigator.pop(context);
  }

  Future<void> _deactivate() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Drink Type?'),
        content: const Text(
          'This will remove the drink type from your list. '
          'Existing entries will be preserved.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref
          .read(databaseProvider)
          .drinkTypeDao
          .deactivate(widget.existing!.id);
      HapticFeedback.lightImpact();
      if (mounted) Navigator.pop(context);
    }
  }
}
