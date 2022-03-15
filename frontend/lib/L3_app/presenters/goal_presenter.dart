// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';

import '../../L1_domain/entities/goals/goal.dart';

extension GoalPresenter on Goal {
  String get tasksCountStr => '$closedTasksCount / $tasksCount';
  String get dueDateStr => dueDate != null ? DateFormat.yMMMMd().format(dueDate!) : '';
  String get etaDateStr => report?.etaDate != null ? DateFormat.yMMMMd().format(report!.etaDate!) : '';
}
