// Copyright (c) 2024. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities/task_view_settings.dart';
import '../../controllers/task_controller.dart';

part 'view_settings_controller.g.dart';

class TasksViewSettingsController extends _Base with _$TasksViewSettingsController {
  TasksViewSettingsController(TaskController tc) {
    _taskController = tc;
    viewSettings = tc.task.viewSettings;
  }
}

abstract class _Base with Store {
  late final TaskController _taskController;

  Task get task => _taskController.task;

  @observable
  TaskViewSettings viewSettings = TaskViewSettings();

  @action
  setViewMode(String? name) => viewSettings = viewSettings.copyWith(
        viewMode: name == TasksViewMode.LIST.name ? TasksViewMode.LIST : TasksViewMode.BOARD,
      );
}
