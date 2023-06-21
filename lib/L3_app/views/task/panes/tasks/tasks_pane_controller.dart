// Copyright (c) 2023. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../task_view_controller.dart';

part 'tasks_pane_controller.g.dart';

class TasksPaneController extends _TasksPaneControllerBase with _$TasksPaneController {
  TasksPaneController(TaskViewController _taskController) {
    taskController = _taskController;
  }
}

abstract class _TasksPaneControllerBase with Store {
  late final TaskViewController taskController;

  @observable
  bool showBoard = false;

  @action
  void toggleMode() => showBoard = !showBoard;
}
