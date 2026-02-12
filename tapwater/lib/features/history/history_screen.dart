import 'package:flutter/material.dart';
import 'widgets/bubble_calendar.dart';
import 'widgets/calendar_strip.dart';
import 'widgets/daily_entries_list.dart';
import 'widgets/insights_analytics.dart';
import 'widgets/weekly_bar_chart.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool _showBubbleView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          IconButton(
            icon: Icon(_showBubbleView ? Icons.list : Icons.grid_view_rounded),
            tooltip: _showBubbleView ? 'List view' : 'Year view',
            onPressed: () => setState(() => _showBubbleView = !_showBubbleView),
          ),
        ],
      ),
      body: _showBubbleView
          ? const BubbleCalendar()
          : const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CalendarStrip(),
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Last 7 Days'),
                  ),
                  SizedBox(height: 8),
                  WeeklyBarChart(),
                  SizedBox(height: 24),
                  InsightsAnalytics(),
                  SizedBox(height: 24),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Entries'),
                  ),
                  SizedBox(height: 8),
                  DailyEntriesList(),
                  SizedBox(height: 32),
                ],
              ),
            ),
    );
  }
}
