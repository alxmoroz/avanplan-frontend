// Copyright (c) 2022. Alexandr Moroz

import '../extra/services.dart';

const _daysPerMonth = 30.41;
const _daysPerYear = 365;

extension DurationPresenter on Duration {
  int get _inMonths => inDays ~/ _daysPerMonth;
  int get _inYears => inDays ~/ _daysPerYear;
  String get localizedString => _inYears > 0
      ? loc.years_count(_inYears)
      : _inMonths > 0
          ? loc.months_count(_inMonths)
          : inDays > 0
              ? loc.days_count(inDays)
              : loc.hours_count(inHours);
}
