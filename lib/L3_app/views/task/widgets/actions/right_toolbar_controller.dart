// Copyright (c) 2023. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../components/vertical_toolbar_controller.dart';
import '../../controllers/task_controller.dart';

part 'right_toolbar_controller.g.dart';

class TaskRightToolbarController extends _TaskRightToolbarControllerBase with _$TaskRightToolbarController {
  TaskRightToolbarController(TaskController taskControllerIn) {
    taskController = taskControllerIn;
    compact = taskController.task?.isTask == false;
  }
}

abstract class _TaskRightToolbarControllerBase extends VerticalToolbarController with Store {
  late final TaskController taskController;

  @observable
  bool showActions = false;

  @action
  void toggleShowActions() => showActions = !showActions;

  @override
  @action
  void toggleWidth() {
    super.toggleWidth();
    showActions = false;
  }
}
