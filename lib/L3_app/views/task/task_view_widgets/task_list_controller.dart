// Copyright (c) 2022. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/task_ext_state.dart';
import '../../../extra/services.dart';

part 'task_list_controller.g.dart';

enum TaskFilter {
  all,
  opened,
  // overdue, risky, ok, noDue, closable, inactive
}

class TaskListController extends _TaskListControllerBase with _$TaskListController {
  TaskListController(int taskId) {
    taskID = taskId;
  }
}

abstract class _TaskListControllerBase with Store {
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

  int? taskID;

  @computed
  Task get task => taskViewController.taskForId(taskID);

  /// непосредственно фильтр и сортировка
  @computed
  Iterable<Task> get _sortedTasks {
    final tasks = task.tasks;
    tasks.sort(compareTasks);
    return tasks;
  }

  @computed
  Iterable<Task> get _sortedOpenedTasks {
    final tasks = task.openedTasks.toList();
    tasks.sort(compareTasks);
    return tasks;
  }

  /// непосредственно фильтр

  @observable
  TaskFilter? _tasksFilter;

  @computed
  TaskFilter get tasksFilter => _tasksFilter ?? (task.hasOpenedTasks ? TaskFilter.opened : TaskFilter.all);

  @action
  void setFilter(TaskFilter? _filter) => _tasksFilter = _filter;

  @computed
  List<TaskFilter> get taskFilterKeys {
    final keys = <TaskFilter>[];
    if (task.hasOpenedTasks && task.openedTasksCount < task.tasks.length) {
      keys.add(TaskFilter.opened);
    }
    keys.add(TaskFilter.all);
    return keys;
  }

  @computed
  bool get hasFilters => taskFilterKeys.length > 1;

  Map<TaskFilter, Iterable<Task>> get _taskFilters => {
        TaskFilter.opened: _sortedOpenedTasks,
        TaskFilter.all: _sortedTasks,
      };

  @computed
  Iterable<Task> get filteredTasks => _taskFilters[tasksFilter] ?? [];

  String taskFilterText(TaskFilter tf) {
    const _sep = ': ';
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
        res = '${loc.task_filter_opened}$_sep${task.openedTasksCount}';
        break;
      case TaskFilter.all:
        res = '${loc.task_filter_all}$_sep${task.tasks.length}';
        break;
    }
    return res;
  }
}
