import 'package:tapwater/core/models/enums.dart';

const double _mlPerOz = 29.5735;

extension AmountConversion on double {
  double toOz() => this / _mlPerOz;
  double toMl() => this * _mlPerOz;

  String displayAmount(UnitSystem unit) {
    if (unit == UnitSystem.imperial) {
      return '${toOz().round()} oz';
    }
    return '${round()} ml';
  }
}

extension IntAmountConversion on int {
  double toOz() => toDouble() / _mlPerOz;
  double toMl() => toDouble() * _mlPerOz;

  String displayAmount(UnitSystem unit) {
    if (unit == UnitSystem.imperial) {
      return '${toOz().round()} oz';
    }
    return '$this ml';
  }
}
