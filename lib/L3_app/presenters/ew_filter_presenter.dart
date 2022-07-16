// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/task.dart';
import '../extra/services.dart';

const _sep = ': ';

String ewFilterText(TaskFilter ewf) {
  String res = '???';
  switch (ewf) {
    case TaskFilter.overdue:
      res = '${loc.ew_filter_overdue}$_sep${tasksFilterController.overdueTasksCount}';
      break;
    case TaskFilter.risky:
      res = '${loc.ew_filter_risky}$_sep${tasksFilterController.riskyTasksCount}';
      break;
    case TaskFilter.noDue:
      res = '${loc.ew_filter_no_due}$_sep${tasksFilterController.noDueTasksCount}';
      break;
    case TaskFilter.inactive:
      res = '${loc.ew_filter_no_progress}$_sep${tasksFilterController.inactiveTasksCount}';
      break;
    case TaskFilter.closable:
      res = '${loc.ew_filter_no_opened_tasks}$_sep${tasksFilterController.closableTasksCount}';
      break;
    case TaskFilter.ok:
      res = '${loc.ew_filter_ok}$_sep${tasksFilterController.okTasksCount}';
      break;
    case TaskFilter.opened:
      res = '${loc.ew_filter_opened}$_sep${tasksFilterController.openedTasksCount}';
      break;
    case TaskFilter.all:
      res = '${loc.ew_filter_all}$_sep${tasksFilterController.allTasksCount}';
      break;
  }
  return res;
}
