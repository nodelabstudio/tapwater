class DefaultDrinkType {
  final String name;
  final String icon;
  final double hydrationMultiplier;
  final int defaultAmountMl;
  final String colorHex;
  final int sortOrder;

  const DefaultDrinkType({
    required this.name,
    required this.icon,
    required this.hydrationMultiplier,
    required this.defaultAmountMl,
    required this.colorHex,
    required this.sortOrder,
  });
}

const defaultDrinkTypes = [
  DefaultDrinkType(
    name: 'Water',
    icon: '\u{1F4A7}',
    hydrationMultiplier: 1.0,
    defaultAmountMl: 250,
    colorHex: 'FF2196F3',
    sortOrder: 0,
  ),
  DefaultDrinkType(
    name: 'Coffee',
    icon: '\u{2615}',
    hydrationMultiplier: 0.8,
    defaultAmountMl: 240,
    colorHex: 'FF795548',
    sortOrder: 1,
  ),
  DefaultDrinkType(
    name: 'Tea',
    icon: '\u{1FAD6}',
    hydrationMultiplier: 0.9,
    defaultAmountMl: 240,
    colorHex: 'FF8BC34A',
    sortOrder: 2,
  ),
  DefaultDrinkType(
    name: 'Juice',
    icon: '\u{1F9C3}',
    hydrationMultiplier: 0.8,
    defaultAmountMl: 200,
    colorHex: 'FFFF9800',
    sortOrder: 3,
  ),
  DefaultDrinkType(
    name: 'Milk',
    icon: '\u{1F95B}',
    hydrationMultiplier: 0.9,
    defaultAmountMl: 240,
    colorHex: 'FFF5F5F5',
    sortOrder: 4,
  ),
  DefaultDrinkType(
    name: 'Soda',
    icon: '\u{1F964}',
    hydrationMultiplier: 0.5,
    defaultAmountMl: 355,
    colorHex: 'FFE91E63',
    sortOrder: 5,
  ),
  DefaultDrinkType(
    name: 'Smoothie',
    icon: '\u{1F353}',
    hydrationMultiplier: 0.9,
    defaultAmountMl: 300,
    colorHex: 'FF9C27B0',
    sortOrder: 6,
  ),
  DefaultDrinkType(
    name: 'Sports Drink',
    icon: '\u{1F3C3}',
    hydrationMultiplier: 1.0,
    defaultAmountMl: 500,
    colorHex: 'FF00BCD4',
    sortOrder: 7,
  ),
];
