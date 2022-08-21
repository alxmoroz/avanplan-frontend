// Copyright (c) 2022. Alexandr Moroz

import 'package:gercules/L1_domain/usecases/task_comparators.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/task_ext_state.dart';
import '../../extra/services.dart';
import '../../presenters/task_filter_presenter.dart';
import '../_base/base_controller.dart';

part 'task_view_controller.g.dart';

class TaskViewController extends _TaskViewControllerBase with _$TaskViewController {
  TaskViewController() {
    setTaskID(mainController.selectedTaskId);
  }
}

abstract class _TaskViewControllerBase extends BaseController with Store {
  @override
  bool get isLoading => super.isLoading || mainController.isLoading;

  @observable
  int? taskID;

  @action
  void setTaskID(int? _id) => taskID = _id;

  @computed
  Task get task => mainController.taskForId(taskID);

  /// непосредственно фильтр и сортировка
  @computed
  Iterable<Task> get _sortedTasks {
    final tasks = task.tasks;
    tasks.sort(sortByDateAsc);
    return tasks;
  }

  @computed
  Iterable<Task> get _sortedOpenedTasks {
    final tasks = task.openedTasks.toList();
    tasks.sort(sortByDateAsc);
    return tasks;
  }

  /// фильтр

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
}
