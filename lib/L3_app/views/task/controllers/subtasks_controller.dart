// Copyright (c) 2023. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../usecases/task_edit.dart';
import '../../../usecases/task_tree.dart';
import 'task_controller.dart';

part 'subtasks_controller.g.dart';

class SubtasksController extends _SubtasksControllerBase with _$SubtasksController {
  SubtasksController(TaskController parentTaskController) {
    _parentTaskController = parentTaskController;
    reload();
  }
}

abstract class _SubtasksControllerBase with Store {
  late final TaskController _parentTaskController;

  Task get parent => _parentTaskController.task;

  @observable
  ObservableList<Task> subtasks = ObservableList();

  @action
  void reload() => subtasks = ObservableList.of(parent.subtasks);

  @action
  Future add() async {
    final t = await _parentTaskController.addSubtask(noGo: true);
    if (t != null) subtasks.add(t);
  }

  @action
  Future delete(int index) async {
    final t = subtasks[index];
    if (await t.delete() != null) subtasks.remove(t);
  }
}
