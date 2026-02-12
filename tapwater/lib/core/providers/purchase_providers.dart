import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../models/enums.dart';
import '../models/purchase_state.dart';
import '../services/purchase_service.dart';

class PurchaseNotifier extends StateNotifier<PurchaseState> {
  PurchaseNotifier() : super(const PurchaseState()) {
    _init();
  }

  Future<void> _init() async {
    state = state.copyWith(isLoading: true);
    await PurchaseService().init();
    final tier = await PurchaseService().checkEntitlements();
    state = state.copyWith(tier: tier, isLoading: false);
  }

  Future<void> refresh() async {
    final tier = await PurchaseService().checkEntitlements();
    state = state.copyWith(tier: tier);
  }

  void setTier(PurchaseTier tier) {
    state = state.copyWith(tier: tier);
  }

  Future<PurchaseTier> purchase(Package package) async {
    state = state.copyWith(isLoading: true);
    final tier = await PurchaseService().purchase(package);
    state = state.copyWith(tier: tier, isLoading: false);
    return tier;
  }

  Future<void> restore() async {
    state = state.copyWith(isLoading: true);
    final tier = await PurchaseService().restore();
    state = state.copyWith(tier: tier, isLoading: false);
  }
}

final purchaseProvider =
    StateNotifierProvider<PurchaseNotifier, PurchaseState>((ref) {
  return PurchaseNotifier();
});

final purchaseTierProvider = Provider<PurchaseTier>((ref) {
  return ref.watch(purchaseProvider).tier;
});
