// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../components/button.dart';
import '../../../components/constants.dart';
import '../../../extra/services.dart';
import '../../../usecases/task_edit.dart';
import '../../../usecases/task_tree.dart';
import '../../../usecases/ws_tasks.dart';
import 'task_controller.dart';

part 'subtasks_controller.g.dart';

class SubtasksController extends _SubtasksControllerBase with _$SubtasksController {
  SubtasksController(TaskController _parentTaskController) {
    parentTaskController = _parentTaskController;
    _setControllers(_parentTaskController.task!.subtasks);
  }
}

abstract class _SubtasksControllerBase with Store {
  late final TaskController parentTaskController;

  Task get parent => parentTaskController.task!;

  @observable
  ObservableList<TaskController> taskControllers = ObservableList();

  @action
  void _setControllers(Iterable<Task> tasks) => taskControllers = ObservableList.of(tasks.map((t) => TaskController(t)));

  @action
  Future addTask() async {
    final newTask = await parent.ws.createTask(parent);
    if (newTask != null) {
      final tc = TaskController(newTask, isNew: true);
      taskControllers.add(tc);
      setFocus(true, tc);
    }
  }

  void setFocus(bool f, TaskController tc) {
    final fn = tc.focusNode(TaskFCode.title.index);
    if (fn != null) {
      final hf = fn.hasFocus == true;
      if (f && !hf) {
        fn.requestFocus();
      } else if (hf) {
        fn.unfocus();
      }
    }
  }

  @action
  Future<bool> deleteTask(TaskController tc) async {
    await tc.task!.delete();
    tc.dispose();
    taskControllers.remove(tc);
    return false;
  }

  Future editTitle(TaskController tc, String str) async {
    await tc.titleController.editTitle(str);
  }

  void dispose() => taskControllers.forEach((tc) => tc.dispose());

  @observable
  bool _loading = false;

  @action
  Future _loadClosed() async {
    _loading = true;
    final tasks = await myUC.getTasks(parent.wsId, parent: parent, closed: true);
    tasksMainController.removeClosed(parent);
    if (tasks.isNotEmpty) {
      tasksMainController.addTasks(tasks);
    }
    _loading = false;
  }

  Widget? loadClosedButton({bool board = false}) => (parent.closedSubtasksCount ?? 0) > parent.closedSubtasks.length
      ? MTButton.secondary(
          constrained: !board,
          padding: EdgeInsets.symmetric(horizontal: board ? P3 : 0),
          titleText: loc.show_closed_action_title,
          margin: EdgeInsets.only(top: board ? P : P3, bottom: board ? P2 : 0),
          loading: _loading,
          onTap: _loadClosed,
        )
      : null;
}
