import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../models/enums.dart';

class PurchaseService {
  static const _apiKey = 'appl_FaYnlLDlLZOwnTzCSFyGvDUooUL';

  static final PurchaseService _instance = PurchaseService._();
  factory PurchaseService() => _instance;
  PurchaseService._();

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    await Purchases.configure(PurchasesConfiguration(_apiKey));
    _initialized = true;
  }

  Future<PurchaseTier> checkEntitlements() async {
    if (!_initialized) return PurchaseTier.free;
    try {
      final info = await Purchases.getCustomerInfo();
      if (info.entitlements.active.containsKey('insights')) {
        return PurchaseTier.insights;
      }
      if (info.entitlements.active.containsKey('pro')) {
        return PurchaseTier.pro;
      }
    } catch (e) {
      debugPrint('PurchaseService: Error checking entitlements: $e');
    }
    return PurchaseTier.free;
  }

  Future<List<Package>> getOfferings() async {
    if (!_initialized) return [];
    try {
      final offerings = await Purchases.getOfferings();
      return offerings.current?.availablePackages ?? [];
    } catch (e) {
      debugPrint('PurchaseService: Error getting offerings: $e');
      return [];
    }
  }

  Future<PurchaseTier> purchase(Package package) async {
    if (!_initialized) return PurchaseTier.free;
    try {
      final result = await Purchases.purchasePackage(package);
      if (result.entitlements.active.containsKey('insights')) {
        return PurchaseTier.insights;
      }
      if (result.entitlements.active.containsKey('pro')) {
        return PurchaseTier.pro;
      }
    } catch (e) {
      debugPrint('PurchaseService: Error purchasing: $e');
    }
    return PurchaseTier.free;
  }

  Future<PurchaseTier> restore() async {
    if (!_initialized) return PurchaseTier.free;
    try {
      final info = await Purchases.restorePurchases();
      if (info.entitlements.active.containsKey('insights')) {
        return PurchaseTier.insights;
      }
      if (info.entitlements.active.containsKey('pro')) {
        return PurchaseTier.pro;
      }
    } catch (e) {
      debugPrint('PurchaseService: Error restoring: $e');
    }
    return PurchaseTier.free;
  }
}
