// Copyright (c) 2022. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../extra/services.dart';

part 'ew_filter_controller.g.dart';

class EWFilterController extends _EWFilterControllerBase with _$EWFilterController {}

abstract class _EWFilterControllerBase with Store {
  // TODO: здесь можно заменить на EW для подзадач и использовать в дашборде задач и цели. И перенести в контроллер EWViewController
  // TODO: инициализировать родителем (выбранная цель)

  Iterable<Task> get _allEW => taskViewController.selectedTask?.tasks ?? [];

  @computed
  int get allEWCount => _allEW.length;

  @computed
  Iterable<Task> get openedEW => _allEW.where((e) => !e.closed);
  @computed
  int get openedEWCount => openedEW.length;
  @computed
  bool get hasOpened => openedEWCount > 0;

  @computed
  Iterable<Task> get timeBoundEW => openedEW.where((e) => e.dueDate != null);
  @computed
  int get _timeBoundEWCount => timeBoundEW.length;
  @computed
  bool get hasTimeBound => _timeBoundEWCount > 0;

  @computed
  Iterable<Task> get overdueEW => timeBoundEW.where((e) => e.overallState == OverallState.overdue);
  @computed
  int get overdueEWCount => overdueEW.length;
  @computed
  bool get hasOverdue => overdueEWCount > 0;

  @computed
  Iterable<Task> get riskyEW => timeBoundEW.where((e) => e.overallState == OverallState.risk);
  @computed
  int get riskyEWCount => riskyEW.length;
  @computed
  bool get hasRisk => riskyEWCount > 0;

  @computed
  Iterable<Task> get noDueEW => openedEW.where((e) => e.dueDate == null);
  @computed
  int get noDueEWCount => noDueEW.length;
  @computed
  bool get hasNoDue => noDueEWCount > 0;

  @computed
  Iterable<Task> get okEW => timeBoundEW.where((e) => e.overallState == OverallState.ok);
  @computed
  int get okEWCount => okEW.length;
  @computed
  bool get hasOk => okEWCount > 0;

  @computed
  Iterable<Task> get _activeEW => openedEW.where((e) => e.closedTasksCount > 0);
  @computed
  Iterable<Task> get closableEW => _activeEW.where((e) => e.leftTasksCount == 0);
  @computed
  int get closableEWCount => closableEW.length;
  @computed
  bool get hasClosable => closableEWCount > 0;

  @computed
  Iterable<Task> get inactiveEW => openedEW.where((e) => e.closedTasksCount == 0);
  @computed
  int get inactiveEWCount => inactiveEW.length;
  @computed
  bool get hasInactive => inactiveEWCount > 0;

  @computed
  Duration get overduePeriod {
    int totalSeconds = 0;
    overdueEW.forEach((g) => totalSeconds += g.overduePeriod?.inSeconds ?? 0);
    return Duration(seconds: totalSeconds);
  }

  @computed
  Duration get riskPeriod {
    int totalSeconds = 0;
    riskyEW.forEach((g) => totalSeconds += g.etaRiskPeriod?.inSeconds ?? 0);
    return Duration(seconds: totalSeconds);
  }

  @observable
  TaskFilter? ewFilter;

  @action
  void setFilter(TaskFilter? _ewFilter) => ewFilter = _ewFilter;

  @action
  void setDefaultFilter() => setFilter(ewFilterKeys.contains(TaskFilter.opened) ? TaskFilter.opened : TaskFilter.all);

  @computed
  List<TaskFilter> get ewFilterKeys {
    final keys = <TaskFilter>[];
    if (hasOverdue && overdueEWCount < allEWCount) {
      keys.add(TaskFilter.overdue);
    }
    if (hasRisk && riskyEWCount < allEWCount) {
      keys.add(TaskFilter.risky);
    }
    if (hasNoDue && noDueEWCount < allEWCount) {
      keys.add(TaskFilter.noDue);
    }
    if (hasInactive && inactiveEWCount < allEWCount) {
      keys.add(TaskFilter.inactive);
    }
    if (hasClosable && closableEWCount < allEWCount) {
      keys.add(TaskFilter.closable);
    }
    if (hasOk && okEWCount < allEWCount) {
      keys.add(TaskFilter.ok);
    }
    if (hasOpened && openedEWCount < allEWCount) {
      keys.add(TaskFilter.opened);
    }
    keys.add(TaskFilter.all);
    return keys;
  }

  @computed
  bool get hasFilters => ewFilterKeys.length > 1;

  @computed
  Map<TaskFilter, Iterable<Task>> get ewFilters => {
        TaskFilter.overdue: overdueEW,
        TaskFilter.risky: riskyEW,
        TaskFilter.noDue: noDueEW,
        TaskFilter.inactive: inactiveEW,
        TaskFilter.closable: closableEW,
        TaskFilter.opened: openedEW,
        TaskFilter.ok: okEW,
        TaskFilter.all: _allEW,
      };

  @computed
  Iterable<Task> get filteredEW => ewFilters[ewFilter] ?? openedEW;
}
