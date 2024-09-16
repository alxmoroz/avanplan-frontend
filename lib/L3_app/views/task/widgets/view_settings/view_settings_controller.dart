// Copyright (c) 2024. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities/task_view_settings.dart';
import '../../../../extra/services.dart';

part 'view_settings_controller.g.dart';

class TaskViewSettingsController extends _Base with _$TaskViewSettingsController {
  TaskViewSettingsController(Task t) {
    task = t;
    viewMode = task.viewSettings.viewMode;
    _filters = List.of(task.viewSettings.filters ?? []);
  }
}

abstract class _Base with Store {
  late final Task task;
  late final List<TaskViewFilter> _filters;

  void _save() {
    task.viewSettings = TaskViewSettings(viewMode: viewMode, filters: _filters);
    tasksMainController.refreshUI();
  }

  @observable
  TaskViewMode viewMode = TaskViewMode.BOARD;

  @action
  void setViewMode(String? name) {
    viewMode = name == TaskViewMode.LIST.name ? TaskViewMode.LIST : TaskViewMode.BOARD;
    _save();
  }

  void setFilter(TaskViewFilter filter) {
    if (filter.isEmpty) {
      _filters.removeWhere((f) => f.type == filter.type);
    } else {
      final index = _filters.indexWhere((f) => f.type == filter.type);
      if (index > -1) {
        _filters[index] = filter;
      } else {
        _filters.add(filter);
      }
    }
    _save();
  }

  void resetAssigneesFilter() {
    _filters.removeWhere((f) => f.type == TaskViewFilterType.ASSIGNEE);
    _save();
  }
}
