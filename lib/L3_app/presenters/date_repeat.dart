// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';

import '../../L1_domain/entities/task_repeat.dart';
import '../../L1_domain/utils/dates.dart';

extension RepeatPresenter on TaskRepeat {
  String get prefix => Intl.message('task_repeat_period_${periodType.toLowerCase()}_prefix', args: [periodLength]);
  String get suffix => Intl.message('task_repeat_period_${periodType.toLowerCase()}_suffix', args: [periodLength]);

  String get _weekdays {
    final days = daysList.split(',');
    days.sort();
    return days.map((wd) => DateFormat.E().format(now.add(Duration(days: int.parse(wd) - now.weekday)))).join(', ');
  }

  String get localizedString {
    final value = periodLength > 1 ? ' $periodLength ' : ' ';
    final details = weekly && daysList.isNotEmpty ? ': $_weekdays' : '';
    return '$prefix$value$suffix$details';
  }
}
