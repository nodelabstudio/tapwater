extension DateTimeX on DateTime {
  DateTime startOfDay({int dayBoundaryHour = 0}) {
    if (dayBoundaryHour == 0) {
      return DateTime(year, month, day);
    }
    // If hour is before the boundary, the "day" started yesterday at boundaryHour
    if (hour < dayBoundaryHour) {
      final yesterday = subtract(const Duration(days: 1));
      return DateTime(yesterday.year, yesterday.month, yesterday.day, dayBoundaryHour);
    }
    return DateTime(year, month, day, dayBoundaryHour);
  }

  DateTime endOfDay({int dayBoundaryHour = 0}) {
    final start = startOfDay(dayBoundaryHour: dayBoundaryHour);
    return start.add(const Duration(hours: 24));
  }

  bool isSameDay(DateTime other, {int dayBoundaryHour = 0}) {
    final thisStart = startOfDay(dayBoundaryHour: dayBoundaryHour);
    final otherStart = other.startOfDay(dayBoundaryHour: dayBoundaryHour);
    return thisStart == otherStart;
  }

  String get shortDate => '$month/$day/$year';
}
