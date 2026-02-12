import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tapwater/core/models/enums.dart';
import 'package:tapwater/core/providers/database_provider.dart';
import 'package:tapwater/core/providers/settings_providers.dart';
import 'package:tapwater/shared/extensions/amount_extensions.dart';

class ExportScreen extends ConsumerStatefulWidget {
  const ExportScreen({super.key});

  @override
  ConsumerState<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends ConsumerState<ExportScreen> {
  DateTimeRange? _dateRange;
  bool _exporting = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _dateRange = DateTimeRange(
      start: now.subtract(const Duration(days: 30)),
      end: now,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM d, yyyy');

    return Scaffold(
      appBar: AppBar(title: const Text('Export Data')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.date_range),
                title: const Text('Date Range'),
                subtitle: _dateRange != null
                    ? Text(
                        '${dateFormat.format(_dateRange!.start)} - ${dateFormat.format(_dateRange!.end)}')
                    : const Text('Select a range'),
                trailing: const Icon(Icons.chevron_right),
                onTap: _pickDateRange,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CSV Format',
                        style: theme.textTheme.titleSmall),
                    const SizedBox(height: 8),
                    Text(
                      'Columns: Date, Time, Drink Type, Amount (ml), '
                      'Amount (display), Hydration Factor',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: _exporting ? null : _exportCsv,
              icon: _exporting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.download),
              label: Text(_exporting ? 'Exporting...' : 'Export CSV'),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDateRange() async {
    final now = DateTime.now();
    final result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: now,
      initialDateRange: _dateRange,
    );
    if (result != null) {
      setState(() => _dateRange = result);
    }
  }

  Future<void> _exportCsv() async {
    if (_dateRange == null) return;

    setState(() => _exporting = true);

    try {
      final db = ref.read(databaseProvider);
      final unit = ref.read(unitSystemProvider);

      // Fetch entries
      final start = DateTime(
        _dateRange!.start.year,
        _dateRange!.start.month,
        _dateRange!.start.day,
      );
      final end = DateTime(
        _dateRange!.end.year,
        _dateRange!.end.month,
        _dateRange!.end.day,
        23, 59, 59,
      );
      final entries = await db.drinkEntryDao.getEntriesInRange(start, end);

      // Fetch all drink types for lookup
      final types = await db.drinkTypeDao.getAllActive();
      final typeMap = {for (final t in types) t.id: t};

      // Build CSV
      final buf = StringBuffer();
      buf.writeln('Date,Time,Drink Type,Amount (ml),Amount (${unit.abbreviation}),Hydration Factor');

      final dateFormat = DateFormat('yyyy-MM-dd');
      final timeFormat = DateFormat('HH:mm');

      for (final entry in entries) {
        final type = typeMap[entry.drinkTypeId];
        final typeName = type?.name ?? 'Unknown';
        final multiplier = type?.hydrationMultiplier ?? 1.0;
        final displayAmount = unit == UnitSystem.imperial
            ? '${entry.amountMl.toOz().round()} oz'
            : '${entry.amountMl} ml';

        buf.writeln(
          '${dateFormat.format(entry.createdAt)},'
          '${timeFormat.format(entry.createdAt)},'
          '"$typeName",'
          '${entry.amountMl},'
          '"$displayAmount",'
          '$multiplier',
        );
      }

      // Write to temp file
      final dir = await getTemporaryDirectory();
      final fileName =
          'tapwater_${dateFormat.format(_dateRange!.start)}_to_${dateFormat.format(_dateRange!.end)}.csv';
      final file = File('${dir.path}/$fileName');
      await file.writeAsString(buf.toString());

      // Share
      await Share.shareXFiles(
        [XFile(file.path)],
        subject: 'TapWater Export',
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }
}
