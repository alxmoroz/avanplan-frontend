// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/goals/element_of_work.dart';
import '../extra/services.dart';

const _sep = ': ';

String ewFilterText(EWFilter ewf) {
  String res = '???';
  switch (ewf) {
    case EWFilter.overdue:
      res = '${loc.ew_filter_overdue}$_sep${ewFilterController.overdueEWCount}';
      break;
    case EWFilter.risky:
      res = '${loc.ew_filter_risky}$_sep${ewFilterController.riskyEWCount}';
      break;
    case EWFilter.noDue:
      res = '${loc.ew_filter_no_due}$_sep${ewFilterController.noDueEWCount}';
      break;
    case EWFilter.inactive:
      res = '${loc.ew_filter_no_progress}$_sep${ewFilterController.inactiveEWCount}';
      break;
    case EWFilter.closable:
      res = '${loc.ew_filter_no_opened_tasks}$_sep${ewFilterController.closableEWCount}';
      break;
    case EWFilter.ok:
      res = '${loc.ew_filter_ok}$_sep${ewFilterController.okEWCount}';
      break;
    case EWFilter.opened:
      res = '${loc.ew_filter_opened}$_sep${ewFilterController.openedEWCount}';
      break;
    case EWFilter.all:
      res = '${loc.ew_filter_all}$_sep${ewFilterController.allEWCount}';
      break;
  }
  return res;
}
