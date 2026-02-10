enum UnitSystem { imperial, metric }

enum EntrySource { manual, quickAdd, widget, watch }

enum PurchaseTier { free, pro, insights }

extension UnitSystemX on UnitSystem {
  String get label => switch (this) {
    UnitSystem.metric => 'Metric (ml)',
    UnitSystem.imperial => 'Imperial (oz)',
  };

  String get abbreviation => switch (this) {
    UnitSystem.metric => 'ml',
    UnitSystem.imperial => 'oz',
  };
}

extension PurchaseTierX on PurchaseTier {
  bool get canEditEntries => this != PurchaseTier.free;
  bool get canUseCustomDrinks => this != PurchaseTier.free;
  bool get canBackdate => this != PurchaseTier.free;
  bool get canSetDayBoundary => this != PurchaseTier.free;
  bool get canViewFullHistory => this != PurchaseTier.free;
  bool get canUseNonWaterFavorites => this != PurchaseTier.free;
  bool get canUseAnalytics => this == PurchaseTier.insights;
  bool get canExport => this == PurchaseTier.insights;
  bool get canUseTags => this == PurchaseTier.insights;
}
