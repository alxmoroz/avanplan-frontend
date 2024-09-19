// Copyright (c) 2024. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities/task_view_settings.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_view.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/edit.dart';

part 'view_settings_controller.g.dart';

class TaskViewSettingsController extends _Base with _$TaskViewSettingsController {
  TaskViewSettingsController(TaskController tc) {
    _tc = tc;
    viewMode = task.viewSettings.viewMode;
    _filters = List.of(task.viewSettings.filters ?? []);
  }
}

abstract class _Base with Store {
  late final TaskController _tc;
  late final List<TaskViewFilter> _filters;

  Task get task => _tc.task;

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
    bool hasChanges = false;

    if (filter.isEmpty) {
      _filters.removeWhere((f) => f.type == filter.type);
    } else {
      final index = _filters.indexWhere((f) => f.type == filter.type);
      if (index > -1) {
        final oldFilter = _filters[index];
        hasChanges = oldFilter.values != filter.values;
        if (hasChanges) _filters[index] = filter;
      } else {
        hasChanges = true;
        _filters.add(filter);
      }
    }
    _save();

    // обновляем проект с целями при включении фильтрации
    if (hasChanges && task.isProjectWithGoalsAndFilters) _tc.reload();
  }

  void resetAssigneesFilter() {
    _filters.removeWhere((f) => f.type == TaskViewFilterType.ASSIGNEE);
    _save();
  }
}
