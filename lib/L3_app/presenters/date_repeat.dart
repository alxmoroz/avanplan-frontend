// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';

import '../../L1_domain/entities/task_repeat.dart';

extension RepeatPresenter on TaskRepeat {
  String get prefix => Intl.message('task_repeat_period_${periodType.toLowerCase()}_prefix', args: [periodLength]);
  String get suffix => Intl.message('task_repeat_period_${periodType.toLowerCase()}_suffix', args: [periodLength]);

  String get localizedString {
    final value = periodLength > 1 ? ' $periodLength ' : ' ';
    return '$prefix$value$suffix';
  }
}
