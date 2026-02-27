import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tapwater/core/database/app_database.dart';
import 'package:tapwater/core/models/enums.dart';
import 'package:tapwater/core/providers/database_provider.dart';
import 'package:tapwater/core/providers/drink_entry_providers.dart';
import 'package:tapwater/core/providers/drink_type_providers.dart';
import 'package:tapwater/core/providers/settings_providers.dart';
import 'package:tapwater/shared/extensions/amount_extensions.dart';

void showEntryEditSheet(BuildContext context, WidgetRef ref, DrinkEntry entry) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) => _EntryEditContent(entry: entry),
  );
}

class _EntryEditContent extends ConsumerStatefulWidget {
  final DrinkEntry entry;
  const _EntryEditContent({required this.entry});

  @override
  ConsumerState<_EntryEditContent> createState() => _EntryEditContentState();
}

class _EntryEditContentState extends ConsumerState<_EntryEditContent> {
  late TextEditingController _amountController;
  late DateTime _selectedTime;
  int? _selectedTypeId;

  @override
  void initState() {
    super.initState();
    // Controller text is set in didChangeDependencies after ref is available
    _amountController = TextEditingController();
    _selectedTime = widget.entry.createdAt;
    _selectedTypeId = widget.entry.drinkTypeId;
  }

  bool _didInitAmount = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didInitAmount) {
      _didInitAmount = true;
      final unit = ref.read(unitSystemProvider);
      final displayValue = unit == UnitSystem.imperial
          ? widget.entry.amountMl.toOz().round()
          : widget.entry.amountMl;
      _amountController.text = displayValue.toString();
    }
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

    return SingleChildScrollView(
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
          Text('Edit Entry', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          // Drink type selector
          drinkTypes.when(
            loading: () => const CircularProgressIndicator(),
            error: (e, st) => const Text('Error'),
            data: (types) => Wrap(
              spacing: 8,
              runSpacing: 8,
              children: types.map((type) {
                final selected = _selectedTypeId == type.id;
                final color = Color(int.parse(type.colorHex, radix: 16));
                return ChoiceChip(
                  label: Text('${type.icon} ${type.name}'),
                  selected: selected,
                  selectedColor: color.withValues(alpha: 0.2),
                  onSelected: (_) => setState(() => _selectedTypeId = type.id),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          // Amount
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Amount (${unit.abbreviation})',
              border: const OutlineInputBorder(),
              suffixText: unit.abbreviation,
            ),
          ),
          const SizedBox(height: 16),
          // Time picker
          OutlinedButton.icon(
            onPressed: _pickTime,
            icon: const Icon(Icons.access_time),
            label: Text(DateFormat.jm().format(_selectedTime)),
          ),
          const SizedBox(height: 16),
          // Date picker (backdate)
          OutlinedButton.icon(
            onPressed: _pickDate,
            icon: const Icon(Icons.calendar_today),
            label: Text(DateFormat.yMMMd().format(_selectedTime)),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _delete,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error,
                  ),
                  child: const Text('Delete'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: _save,
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedTime),
    );
    if (time != null) {
      setState(() {
        _selectedTime = DateTime(
          _selectedTime.year,
          _selectedTime.month,
          _selectedTime.day,
          time.hour,
          time.minute,
        );
      });
    }
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedTime,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() {
        _selectedTime = DateTime(
          date.year,
          date.month,
          date.day,
          _selectedTime.hour,
          _selectedTime.minute,
        );
      });
    }
  }

  Future<void> _save() async {
    final unit = ref.read(unitSystemProvider);
    var amountMl =
        int.tryParse(_amountController.text) ?? widget.entry.amountMl;
    if (unit == UnitSystem.imperial) {
      amountMl = amountMl.toMl().round();
    }

    HapticFeedback.mediumImpact();
    final db = ref.read(databaseProvider);
    await db.drinkEntryDao.updateEntry(
      DrinkEntriesCompanion(
        drinkTypeId: drift.Value(_selectedTypeId ?? widget.entry.drinkTypeId),
        amountMl: drift.Value(amountMl),
        createdAt: drift.Value(_selectedTime),
      ),
      widget.entry.id,
    );

    ref.invalidate(weeklyTotalsProvider);
    ref.invalidate(todayTotalMlProvider);
    ref.invalidate(todayEntriesProvider);

    if (mounted) Navigator.pop(context);
  }

  Future<void> _delete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Entry'),
        content: const Text('Are you sure you want to delete this entry?'),
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
      final db = ref.read(databaseProvider);
      await db.drinkEntryDao.deleteEntry(widget.entry.id);
      ref.invalidate(weeklyTotalsProvider);
      ref.invalidate(todayTotalMlProvider);
      ref.invalidate(todayEntriesProvider);
      if (mounted) Navigator.pop(context);
    }
  }
}
