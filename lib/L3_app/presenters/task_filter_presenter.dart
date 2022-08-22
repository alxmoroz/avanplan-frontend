// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/task_ext_state.dart';
import '../extra/services.dart';

enum TaskFilter {
  all,
  opened,
  // overdue, risky, ok, noDue, closable, inactive
}

extension TaskFilterPresenter on Task {
  String taskFilterText(TaskFilter tf) {
    const _sep = ': ';
    String res = '???';
    switch (tf) {
      case TaskFilter.opened:
        res = '${loc.task_filter_opened}$_sep$openedSubtasksCount';
        break;
      case TaskFilter.all:
        res = '${loc.task_filter_all}$_sep${tasks.length}';
        break;
    }
    return res;
  }
}
