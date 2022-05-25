// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/goals/element_of_work.dart';
import '../extra/services.dart';

String ewFilterText(EWFilter ewf) {
  String res = '???';
  switch (ewf) {
    case EWFilter.all:
      res = loc.ew_all_items;
      break;
    case EWFilter.opened:
      res = loc.ew_opened_items;
      break;
    case EWFilter.risky:
      res = loc.ew_risky_items;
      break;
    case EWFilter.noDue:
      res = loc.ew_no_due_items;
      break;
    case EWFilter.closable:
      res = loc.ew_no_opened_tasks_items;
      break;
    case EWFilter.inactive:
      res = loc.ew_no_progress_items;
      break;
    case EWFilter.overdue:
      res = loc.ew_overdue_items;
      break;
    case EWFilter.ok:
      res = loc.ew_ok_items;
      break;
  }
  return res;
}
