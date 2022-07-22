// Copyright (c) 2022. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../extra/services.dart';
import '../../presenters/task_filter_presenter.dart';

part 'task_filter_controller.g.dart';

class TaskFilterController extends _TaskFilterControllerBase with _$TaskFilterController {}

abstract class _TaskFilterControllerBase with Store {
  Iterable<Task> get _tasks => taskViewController.selectedTask?.tasks ?? [];

  @computed
  int get tasksCount => _tasks.length;

  @computed
  Iterable<Task> get openedTasks => _tasks.where((e) => !e.closed);

  @computed
  int get openedTasksCount => openedTasks.length;
  @computed
  bool get hasOpened => openedTasksCount > 0;

  @observable
  TaskFilter? tasksFilter;

  @action
  void setFilter(TaskFilter? _filter) => tasksFilter = _filter;

  @action
  void setDefaultFilter() => setFilter(taskFilterKeys.contains(TaskFilter.opened) ? TaskFilter.opened : TaskFilter.all);

  @computed
  List<TaskFilter> get taskFilterKeys {
    final keys = <TaskFilter>[];
    if (hasOpened && openedTasksCount < tasksCount) {
      keys.add(TaskFilter.opened);
    }
    keys.add(TaskFilter.all);
    return keys;
  }

  @computed
  bool get hasFilters => taskFilterKeys.length > 1;

  @computed
  Map<TaskFilter, Iterable<Task>> get taskFilters => {
        TaskFilter.opened: openedTasks,
        TaskFilter.all: _tasks,
      };

  @computed
  Iterable<Task> get filteredTasks {
    final tasks = (taskFilters[tasksFilter] ?? openedTasks).toList();
    tasks.sort((t1, t2) => t1.title.compareTo(t2.title));
    return tasks;
  }
}
