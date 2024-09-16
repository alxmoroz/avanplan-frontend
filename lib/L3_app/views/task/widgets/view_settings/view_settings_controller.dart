// Copyright (c) 2024. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities/task_view_settings.dart';
import '../../../../extra/services.dart';
import '../../controllers/task_controller.dart';

part 'view_settings_controller.g.dart';

class TaskViewSettingsController extends _Base with _$TaskViewSettingsController {
  TaskViewSettingsController(TaskController tc) {
    _taskController = tc;
    viewMode = tc.task.viewSettings.viewMode;
    filters = ObservableList.of(tc.task.viewSettings.filters ?? []);
  }
}

abstract class _Base with Store {
  late final TaskController _taskController;

  Task get task => _taskController.task;

  _save() {
    task.viewSettings = TaskViewSettings(viewMode: viewMode, filters: filters);
    tasksMainController.refreshUI();
  }

  @observable
  TaskViewMode viewMode = TaskViewMode.BOARD;

  @observable
  ObservableList<TaskViewFilter> filters = ObservableList();

  @action
  setViewMode(String? name) {
    viewMode = name == TaskViewMode.LIST.name ? TaskViewMode.LIST : TaskViewMode.BOARD;
    _save();
  }

  @action
  setFilter(TaskViewFilter filter) {
    if (filter.isEmpty) {
      filters.removeWhere((f) => f.type == filter.type);
    } else {
      final index = filters.indexOf((f) => f.type == filter.type);
      if (index > -1) {
        filters[index] = filter;
      } else {
        filters.add(filter);
      }
    }
    _save();
  }
}
