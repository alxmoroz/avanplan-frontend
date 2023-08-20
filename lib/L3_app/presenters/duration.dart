// Copyright (c) 2022. Alexandr Moroz

import '../extra/services.dart';

const year = Duration(days: 365);

const daysPerMonth = 30.41666;
const _daysPerYear = 365.0;
const _daysPerWeek = 7.0;

extension DurationPresenter on Duration {
  num get _inWeeks => inDays / _daysPerWeek;
  num get _inMonths => inDays / daysPerMonth;
  num get _inYears => inDays / _daysPerYear;
  String get localizedString => _inYears > 1
      ? loc.years_count(_inYears.round())
      : _inMonths > 1
          ? loc.months_count(_inMonths.round())
          : _inWeeks > 1
              ? loc.weeks_count_accusative(_inWeeks.round())
              : loc.days_count(inDays);
}
