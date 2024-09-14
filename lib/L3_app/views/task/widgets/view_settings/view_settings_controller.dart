// Copyright (c) 2024. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../controllers/task_controller.dart';

part 'view_settings_controller.g.dart';

class TasksViewSettingsController extends _Base with _$TasksViewSettingsController {
  TasksViewSettingsController(TaskController tc) {
    _taskController = tc;
    viewMode = tc.task.viewMode;
  }
}

abstract class _Base with Store {
  late final TaskController _taskController;

  Task get task => _taskController.task;

  @observable
  TasksViewMode viewMode = TasksViewMode.BOARD;

  @action
  setViewMode(String? name) => viewMode = name == TasksViewMode.LIST.name ? TasksViewMode.LIST : TasksViewMode.BOARD;
}
