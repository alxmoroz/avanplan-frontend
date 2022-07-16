// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/task.dart';
import '../extra/services.dart';

const _sep = ': ';

String ewFilterText(TaskFilter ewf) {
  String res = '???';
  switch (ewf) {
    case TaskFilter.overdue:
      res = '${loc.ew_filter_overdue}$_sep${ewFilterController.overdueEWCount}';
      break;
    case TaskFilter.risky:
      res = '${loc.ew_filter_risky}$_sep${ewFilterController.riskyEWCount}';
      break;
    case TaskFilter.noDue:
      res = '${loc.ew_filter_no_due}$_sep${ewFilterController.noDueEWCount}';
      break;
    case TaskFilter.inactive:
      res = '${loc.ew_filter_no_progress}$_sep${ewFilterController.inactiveEWCount}';
      break;
    case TaskFilter.closable:
      res = '${loc.ew_filter_no_opened_tasks}$_sep${ewFilterController.closableEWCount}';
      break;
    case TaskFilter.ok:
      res = '${loc.ew_filter_ok}$_sep${ewFilterController.okEWCount}';
      break;
    case TaskFilter.opened:
      res = '${loc.ew_filter_opened}$_sep${ewFilterController.openedEWCount}';
      break;
    case TaskFilter.all:
      res = '${loc.ew_filter_all}$_sep${ewFilterController.allEWCount}';
      break;
  }
  return res;
}
