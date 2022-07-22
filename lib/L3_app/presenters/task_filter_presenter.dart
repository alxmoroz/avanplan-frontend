// Copyright (c) 2022. Alexandr Moroz

import '../extra/services.dart';

enum TaskFilter {
  all,
  opened,
  // overdue, risky, ok, noDue, closable, inactive
}

const _sep = ': ';

String taskFilterText(TaskFilter tf) {
  String res = '???';
  switch (tf) {
    // case TaskFilter.overdue:
    //   res = '${loc.task_filter_overdue}$_sep${tasksFilterController.overdueTasksCount}';
    //   break;
    // case TaskFilter.risky:
    //   res = '${loc.task_filter_risky}$_sep${tasksFilterController.riskyTasksCount}';
    //   break;
    // case TaskFilter.noDue:
    //   res = '${loc.task_filter_no_due}$_sep${tasksFilterController.noDueTasksCount}';
    //   break;
    // case TaskFilter.inactive:
    //   res = '${loc.task_filter_no_progress}$_sep${tasksFilterController.inactiveTasksCount}';
    //   break;
    // case TaskFilter.closable:
    //   res = '${loc.task_filter_no_opened_tasks}$_sep${tasksFilterController.closableTasksCount}';
    //   break;
    // case TaskFilter.ok:
    //   res = '${loc.task_filter_ok}$_sep${tasksFilterController.okTasksCount}';
    //   break;
    case TaskFilter.opened:
      res = '${loc.task_filter_opened}$_sep${tasksFilterController.openedTasksCount}';
      break;
    case TaskFilter.all:
      res = '${loc.task_filter_all}$_sep${tasksFilterController.tasksCount}';
      break;
  }
  return res;
}
