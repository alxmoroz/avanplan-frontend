// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';

import '../../L1_domain/entities/goal.dart';

extension GoalPresenter on Goal {
  int get tasksCount => report.tasksCount;
  int get closedTasksCount => report.closedTasksCount;
  double? get closedRatio => tasksCount > 0 ? closedTasksCount / tasksCount : null;

  String get tasksCountStr => '${report.closedTasksCount} / ${report.tasksCount}';
  String get dueDateStr => dueDate != null ? DateFormat.yMMMMd().format(dueDate!) : '';
  String get etaDateStr => report.etaDate != null ? DateFormat.yMMMMd().format(report.etaDate!) : '';
  num get pace => report.factSpeed - report.planSpeed;
}
