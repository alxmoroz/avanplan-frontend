// Copyright (c) 2022. Alexandr Moroz

import '../extra/services.dart';

const _daysPerMonth = 30.41;
const _daysPerYear = 365.0;
const _daysPerWeek = 7.0;

extension DurationPresenter on Duration {
  int get _inWeeks => (inDays / _daysPerWeek).round();
  int get _inMonths => (inDays / _daysPerMonth).round();
  int get _inYears => (inDays / _daysPerYear).round();
  String get localizedString => _inYears > 0
      ? loc.years_count(_inYears)
      : _inMonths > 0
          ? loc.months_count(_inMonths)
          : _inWeeks > 0
              ? loc.weeks_count_accusative(_inWeeks)
              : inDays > 0
                  ? loc.days_count(inDays)
                  : loc.hours_count(inHours);
}
