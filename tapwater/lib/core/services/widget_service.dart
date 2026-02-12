import 'dart:convert';
import 'package:home_widget/home_widget.dart';

const _appGroupId = 'group.com.tapwater.app';
const _iOSWidgetName = 'TapWaterWidget';

class WidgetService {
  WidgetService._();

  static Future<void> initialize() async {
    await HomeWidget.setAppGroupId(_appGroupId);
  }

  static Future<void> updateWidgetData({
    required int totalMl,
    required int goalMl,
    required double progressPercent,
    required String displayTotal,
    required String displayGoal,
    required List<Map<String, String>> recentEntries,
  }) async {
    await Future.wait([
      HomeWidget.saveWidgetData('totalMl', totalMl),
      HomeWidget.saveWidgetData('goalMl', goalMl),
      HomeWidget.saveWidgetData('progressPercent', progressPercent),
      HomeWidget.saveWidgetData('displayTotal', displayTotal),
      HomeWidget.saveWidgetData('displayGoal', displayGoal),
      HomeWidget.saveWidgetData('recentEntries', jsonEncode(recentEntries)),
    ]);
    await HomeWidget.updateWidget(iOSName: _iOSWidgetName);
  }
}
