// Copyright (c) 2023. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../presenters/task_tree.dart';
import '../usecases/delete.dart';
import '../usecases/edit.dart';
import 'task_controller.dart';

part 'subtasks_controller.g.dart';

class SubtasksController extends _SubtasksControllerBase with _$SubtasksController {
  SubtasksController(TaskController parentTaskController) {
    _parentTaskController = parentTaskController;
  }
}

abstract class _SubtasksControllerBase with Store {
  late final TaskController _parentTaskController;

  Task get parent => _parentTaskController.task;

  @observable
  ObservableList<TaskController> tasksControllers = ObservableList();

  @action
  void reload() => tasksControllers = ObservableList.of(
        parent.subtasks.map(
          (t) => TaskController(
            taskIn: t,
            isPreview: _parentTaskController.isPreview,
          ),
        ),
      );

  @action
  Future add() async {
    final tc = await _parentTaskController.addSubtask(noGo: true);
    if (tc != null) tasksControllers.add(tc);
  }

  @action
  Future delete(int index) async {
    final tc = tasksControllers[index];
    if (await tc.delete()) {
      tc.dispose();
      tasksControllers.remove(tc);
    }
  }
}
