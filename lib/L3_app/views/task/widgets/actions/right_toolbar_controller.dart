// Copyright (c) 2023. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../components/constants.dart';
import '../../controllers/task_controller.dart';

part 'right_toolbar_controller.g.dart';

class TaskRightToolbarController extends _TaskRightToolbarControllerBase with _$TaskRightToolbarController {
  TaskRightToolbarController(TaskController taskController) {
    _taskController = taskController;
    width = _taskController.task?.isTask == true ? _TaskRightToolbarControllerBase._wideWidth : _TaskRightToolbarControllerBase._compactWidth;
  }
}

abstract class _TaskRightToolbarControllerBase with Store {
  late final TaskController _taskController;

  static const _wideWidth = 300.0;
  static const _compactWidth = P11;

  @observable
  double width = _wideWidth;
  @computed
  bool get compact => width == _compactWidth;

  @observable
  bool showActions = false;

  @action
  void toggleShowActions() => showActions = !showActions;

  @action
  void toggleWidth() {
    width = compact ? _wideWidth : _compactWidth;
    showActions = false;
  }
}
