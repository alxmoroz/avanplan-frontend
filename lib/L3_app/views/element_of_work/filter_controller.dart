// Copyright (c) 2022. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/goals/element_of_work.dart';
import '../../extra/services.dart';

part 'filter_controller.g.dart';

class FilterController extends _FilterControllerBase with _$FilterController {}

enum FilterVariant { all, opened, overdue, risky, ok, noDue, closable, inactive }

abstract class _FilterControllerBase with Store {
  // TODO: здесь можно заменить на Smartable для подзадач и использовать в дашборде задач и цели. И перенести в контроллер Smartable
  // TODO: инициализировать родителем (выбранная цель)

  Iterable<ElementOfWork> get allEW => goalController.goals;

  @computed
  Iterable<ElementOfWork> get openedEW => allEW.where((e) => !e.closed);

  @computed
  Iterable<ElementOfWork> get timeBoundEW => openedEW.where((e) => e.dueDate != null);

  @computed
  Iterable<ElementOfWork> get overdueEW => timeBoundEW.where((e) => e.overallState == OverallState.overdue);

  @computed
  Iterable<ElementOfWork> get riskyEW => timeBoundEW.where((g) => g.overallState == OverallState.risk);

  @computed
  Iterable<ElementOfWork> get okEW => timeBoundEW.where((g) => g.overallState == OverallState.ok);

  @computed
  Iterable<ElementOfWork> get noDueEW => openedEW.where((g) => g.dueDate == null);

  @computed
  Iterable<ElementOfWork> get _activeEW => openedEW.where((g) => g.closedTasksCount > 0);

  @computed
  Iterable<ElementOfWork> get closableEW => _activeEW.where((g) => g.lefTasksCount == 0);

  @computed
  Iterable<ElementOfWork> get inactiveEW => openedEW.where((g) => g.closedTasksCount == 0);

  @observable
  FilterVariant? filterVariant = FilterVariant.opened;

  @action
  void setFilter(FilterVariant? _filterVariant) => filterVariant = _filterVariant;

  @computed
  Map<FilterVariant, Iterable<ElementOfWork>> get filterVariants => {
        FilterVariant.all: allEW,
        FilterVariant.opened: openedEW,
        FilterVariant.overdue: overdueEW,
        FilterVariant.risky: riskyEW,
        FilterVariant.ok: okEW,
        FilterVariant.noDue: noDueEW,
        FilterVariant.closable: closableEW,
        FilterVariant.inactive: inactiveEW,
      };

  @computed
  Iterable<ElementOfWork> get filteredEW => filterVariants[filterVariant] ?? openedEW;

  String filterText(FilterVariant fv) {
    String res = '???';
    switch (fv) {
      case FilterVariant.all:
        res = loc.ew_all_items;
        break;
      case FilterVariant.opened:
        res = loc.ew_opened_items;
        break;
      case FilterVariant.risky:
        res = loc.ew_risky_items;
        break;
      case FilterVariant.noDue:
        res = loc.ew_no_due_items;
        break;
      case FilterVariant.closable:
        res = loc.ew_no_opened_tasks_items;
        break;
      case FilterVariant.inactive:
        res = loc.ew_no_progress_items;
        break;
      case FilterVariant.overdue:
        res = loc.ew_overdue_items;
        break;
      case FilterVariant.ok:
        res = loc.ew_ok_items;
        break;
    }
    return res;
  }
}
