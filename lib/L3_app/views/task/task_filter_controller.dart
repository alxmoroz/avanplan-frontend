// Copyright (c) 2022. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../extra/services.dart';

part 'task_filter_controller.g.dart';

class TaskFilterController extends _TaskFilterControllerBase with _$TaskFilterController {}

abstract class _TaskFilterControllerBase with Store {
  // TODO: эти расчёты должны быть привязаны к задаче. В контроллере только что касается самого фильтра

  Iterable<Task> get _allTasks => taskViewController.selectedTask?.tasks ?? [];

  @computed
  int get allTasksCount => _allTasks.length;

  @computed
  Iterable<Task> get openedTasks => _allTasks.where((e) => !e.closed);
  @computed
  int get openedTasksCount => openedTasks.length;
  @computed
  bool get hasOpened => openedTasksCount > 0;

  @computed
  Iterable<Task> get timeBoundTasks => openedTasks.where((e) => e.dueDate != null);
  @computed
  int get _timeBoundTasksCount => timeBoundTasks.length;
  @computed
  bool get hasTimeBound => _timeBoundTasksCount > 0;

  @computed
  Iterable<Task> get overdueTasks => timeBoundTasks.where((e) => e.overallState == OverallState.overdue);
  @computed
  int get overdueTasksCount => overdueTasks.length;
  @computed
  bool get hasOverdue => overdueTasksCount > 0;

  @computed
  Iterable<Task> get riskyTasks => timeBoundTasks.where((e) => e.overallState == OverallState.risk);
  @computed
  int get riskyTasksCount => riskyTasks.length;
  @computed
  bool get hasRisk => riskyTasksCount > 0;

  @computed
  Iterable<Task> get noDueTasks => openedTasks.where((e) => e.dueDate == null);
  @computed
  int get noDueTasksCount => noDueTasks.length;
  @computed
  bool get hasNoDue => noDueTasksCount > 0;

  @computed
  Iterable<Task> get okTasks => timeBoundTasks.where((e) => e.overallState == OverallState.ok);
  @computed
  int get okTasksCount => okTasks.length;
  @computed
  bool get hasOk => okTasksCount > 0;

  @computed
  Iterable<Task> get _activeTasks => openedTasks.where((e) => e.closedTasksCount > 0);
  @computed
  Iterable<Task> get closableTasks => _activeTasks.where((e) => e.leftTasksCount == 0);
  @computed
  int get closableTasksCount => closableTasks.length;
  @computed
  bool get hasClosable => closableTasksCount > 0;

  @computed
  Iterable<Task> get inactiveTasks => openedTasks.where((e) => e.closedTasksCount == 0);
  @computed
  int get inactiveTasksCount => inactiveTasks.length;
  @computed
  bool get hasInactive => inactiveTasksCount > 0;

  @computed
  Duration get overduePeriod {
    int totalSeconds = 0;
    overdueTasks.forEach((g) => totalSeconds += g.overduePeriod?.inSeconds ?? 0);
    return Duration(seconds: totalSeconds);
  }

  @computed
  Duration get riskPeriod {
    int totalSeconds = 0;
    riskyTasks.forEach((g) => totalSeconds += g.etaRiskPeriod?.inSeconds ?? 0);
    return Duration(seconds: totalSeconds);
  }

  @observable
  TaskFilter? tasksFilter;

  @action
  void setFilter(TaskFilter? _filter) => tasksFilter = _filter;

  @action
  void setDefaultFilter() => setFilter(taskFilterKeys.contains(TaskFilter.opened) ? TaskFilter.opened : TaskFilter.all);

  // void updateFilter(Task task) {
  //   if (!task.deleted && !task.closed && filteredTasks.firstWhereOrNull((e) => e.id == task.id) == null ||
  //       !taskFilterKeys.contains(tasksFilter)) {
  //     setDefaultFilter();
  //   }
  // }

  @computed
  List<TaskFilter> get taskFilterKeys {
    final keys = <TaskFilter>[];
    if (hasOverdue && overdueTasksCount < allTasksCount) {
      keys.add(TaskFilter.overdue);
    }
    if (hasRisk && riskyTasksCount < allTasksCount) {
      keys.add(TaskFilter.risky);
    }
    if (hasNoDue && noDueTasksCount < allTasksCount) {
      keys.add(TaskFilter.noDue);
    }
    if (hasInactive && inactiveTasksCount < allTasksCount) {
      keys.add(TaskFilter.inactive);
    }
    if (hasClosable && closableTasksCount < allTasksCount) {
      keys.add(TaskFilter.closable);
    }
    if (hasOk && okTasksCount < allTasksCount) {
      keys.add(TaskFilter.ok);
    }
    if (hasOpened && openedTasksCount < allTasksCount) {
      keys.add(TaskFilter.opened);
    }
    keys.add(TaskFilter.all);
    return keys;
  }

  @computed
  bool get hasFilters => taskFilterKeys.length > 1;

  @computed
  Map<TaskFilter, Iterable<Task>> get taskFilters => {
        TaskFilter.overdue: overdueTasks,
        TaskFilter.risky: riskyTasks,
        TaskFilter.noDue: noDueTasks,
        TaskFilter.inactive: inactiveTasks,
        TaskFilter.closable: closableTasks,
        TaskFilter.opened: openedTasks,
        TaskFilter.ok: okTasks,
        TaskFilter.all: _allTasks,
      };

  @computed
  Iterable<Task> get filteredTasks => taskFilters[tasksFilter] ?? openedTasks;
}
