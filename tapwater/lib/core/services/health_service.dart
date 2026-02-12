import 'package:health/health.dart';

class HealthService {
  HealthService._();

  static final _health = Health();

  static const _types = [HealthDataType.WATER];
  static const _permissions = [HealthDataAccess.READ_WRITE];

  /// Check if HealthKit access has been granted.
  static Future<bool> isAuthorized() async {
    final result = await _health.hasPermissions(_types, permissions: _permissions);
    return result == true;
  }

  /// Request HealthKit permissions.
  static Future<bool> requestPermission() async {
    return _health.requestAuthorization(_types, permissions: _permissions);
  }

  /// Write a water intake entry to HealthKit.
  /// [amountMl] is the amount in milliliters.
  static Future<bool> writeWaterIntake({
    required int amountMl,
    required DateTime timestamp,
  }) async {
    // HealthKit expects water in liters
    final liters = amountMl / 1000.0;

    return _health.writeHealthData(
      value: liters,
      type: HealthDataType.WATER,
      startTime: timestamp,
      endTime: timestamp.add(const Duration(seconds: 1)),
      unit: HealthDataUnit.LITER,
    );
  }
}
