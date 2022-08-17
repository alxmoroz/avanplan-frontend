// Copyright (c) 2022. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../extra/services.dart';
import '../../presenters/task_filter_presenter.dart';
import '../../presenters/task_stats_presenter.dart';

part 'task_filter_controller.g.dart';

class TaskFilterController extends _TaskFilterControllerBase with _$TaskFilterController {}

abstract class _TaskFilterControllerBase with Store {
  int compareTasks(Task t1, Task t2) {
    int res = 0;
    if (t1.hasDueDate || t2.hasDueDate) {
      if (!t1.hasDueDate) {
        res = 1;
      } else if (!t2.hasDueDate) {
        res = -1;
      } else {
        res = t1.dueDate!.compareTo(t2.dueDate!);
      }
    }

    if (res == 0) {
      res = t1.title.compareTo(t2.title);
    }

    return res;
  }

  /// непосредственно фильтр и сортировка
  @computed
  Iterable<Task> get _tasks {
    final tasks = taskViewController.selectedTask.tasks;
    tasks.sort(compareTasks);
    return tasks;
  }

  @computed
  int get tasksCount => _tasks.length;

  @computed
  Iterable<Task> get _openedTasks => _tasks.where((t) => !t.closed);

  @computed
  int get openedTasksCount => _openedTasks.length;
  @computed
  bool get hasOpened => openedTasksCount > 0;

  /// непосредственно фильтр

  @observable
  TaskFilter? _tasksFilter;

  @computed
  TaskFilter get tasksFilter => _tasksFilter ?? (hasOpened ? TaskFilter.opened : TaskFilter.all);

  @action
  void setFilter(TaskFilter? _filter) => _tasksFilter = _filter;

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
  Map<TaskFilter, Iterable<Task>> get _taskFilters => {
        TaskFilter.opened: _openedTasks,
        TaskFilter.all: _tasks,
      };

  @computed
  Iterable<Task> get filteredTasks => _taskFilters[tasksFilter] ?? [];
}
