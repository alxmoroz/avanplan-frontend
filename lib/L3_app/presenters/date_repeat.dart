// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

import '../../L1_domain/entities/task_repeat.dart';
import '../../L1_domain/utils/dates.dart';
import '../views/app/services.dart';

extension RepeatPresenter on TaskRepeat {
  String get prefix => Intl.message('task_repeat_period_${periodType.toLowerCase()}_prefix', args: [periodLength]);
  String get suffix => Intl.message('task_repeat_period_${periodType.toLowerCase()}_suffix', args: [periodLength]);

  List<String> get _sortedDays => daysList.split(',').sorted(compareNatural);

  String get _weekdays {
    return _sortedDays.map((wd) => DateFormat.E().format(now.add(Duration(days: int.parse(wd) - now.weekday)))).join(', ');
  }

  String get _monthDays {
    final days = _sortedDays;

    String lastDayText = '';
    if (days.contains('-1')) {
      days.remove('-1');
      lastDayText = loc.task_repeat_period_monthly_last_day_short;
    }

    String daysText = '';
    if (days.isNotEmpty) {
      if (lastDayText.isNotEmpty) lastDayText = ', $lastDayText';
      daysText = days.map((d) => loc.task_repeat_period_monthly_day_ordinal_suffix(int.parse(d))).join(', ');
      if (loc.task_repeat_period_monthly_days_suffix.isNotEmpty) daysText += ' ${loc.task_repeat_period_monthly_days_suffix}';
    }

    return '$daysText$lastDayText';
  }

  String get localizedString {
    final value = periodLength > 1 ? ' $periodLength ' : ' ';
    final details = daysList.isNotEmpty
        ? weekly
            ? ': $_weekdays'
            : monthly
                ? ': $_monthDays'
                : ''
        : '';
    return '$prefix$value$suffix$details';
  }
}
