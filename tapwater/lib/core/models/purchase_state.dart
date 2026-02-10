import 'enums.dart';

class PurchaseState {
  final PurchaseTier tier;
  final bool isLoading;

  const PurchaseState({
    this.tier = PurchaseTier.free,
    this.isLoading = false,
  });

  PurchaseState copyWith({PurchaseTier? tier, bool? isLoading}) {
    return PurchaseState(
      tier: tier ?? this.tier,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  bool get canEditEntries => tier.canEditEntries;
  bool get canUseCustomDrinks => tier.canUseCustomDrinks;
  bool get canBackdate => tier.canBackdate;
  bool get canSetDayBoundary => tier.canSetDayBoundary;
  bool get canViewFullHistory => tier.canViewFullHistory;
  bool get canUseNonWaterFavorites => tier.canUseNonWaterFavorites;
  bool get canUseAnalytics => tier.canUseAnalytics;
  bool get canExport => tier.canExport;
  bool get canUseTags => tier.canUseTags;
}
