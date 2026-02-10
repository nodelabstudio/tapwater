import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;
  NotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await _plugin.initialize(settings);
  }

  Future<bool> requestPermission() async {
    final ios = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    if (ios != null) {
      final granted = await ios.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      return granted ?? false;
    }
    return false;
  }

  Future<void> scheduleReminders({
    required int startHour,
    required int endHour,
    required int intervalMinutes,
  }) async {
    await cancelAll();

    if (intervalMinutes <= 0 || startHour >= endHour) return;

    int id = 0;
    for (int hour = startHour; hour < endHour;) {
      await _plugin.periodicallyShow(
        id++,
        'Time to hydrate!',
        'Take a moment to drink some water.',
        RepeatInterval.hourly,
        const NotificationDetails(
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );
      hour += (intervalMinutes ~/ 60).clamp(1, 24);
      if (id > 20) break; // Safety limit
    }
  }

  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }
}
